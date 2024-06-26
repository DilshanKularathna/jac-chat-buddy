import:py random;

'''
User node has user_name attribute.
'''
node user{
    has user_name:string="user";
}

'''
Chat session of a user. This node contains the session_id, user_data and todo_list.
This should also include the chat history. Can have multiple chat sessions.
'''
node session{
    has session_id : string = 100;
    has user_data : dict = {}; # User data such as habits, heart rate etc.
    has todo_list : list = []; # List of things to do by the user.
}

'''
Consists of user data such as age, pressure, married status.
'''
node data{
    has user_data:dict = {
                "age" : 0,
                "Pressure" : (0,0),
                "Married" : False
                };
}

'''
List of things to do by the user.
'''
node todo{
    has todo_list:list = [];
}

'''
This is the chat walker which will be used to chat with the user.
The create_session ability:
    - gather the user data and todo list from connected nodes using filters.
    - Creates a new session with the user data and todo list.
    - Spawns the chat session with the session id.
'''
walker chat{

    can create_session with user entry{

        # Telescope into the nodes connected to the user node without walking.
        data_node = [-->](`?data)[0]; # Getting the data node filtered. can use [0] as having only one such node.
        todo_node = [-->](`?todo)[0]; # Getting the todo node filtered. can use [0] as having only one such node.
        new_session_id = str(random.randint(1,100));

        # Creating a new session node with the user data and todo list and connect it to the user.
        n = here ++> session(   session_id = new_session_id,
                            user_data = data_node.user_data,
                            todo_list = todo_node.todo_list
                        );
        
        query() spawn [-->](`?session)[0];

        visit n;
    }

    can chat_session with session entry{
        print(here.user_data);
        print(here.todo_list);
    }
}



walker query {

    
    has user_data: dict = {};

    can active with session entry {
        # print("Query Activeted");
        # session_node = [-->](`?session)[0];
        self.user_data = here.user_data;
    }

    can sub_graph with session entry{
        
        # directiveIn = input();
        end = here ++> (end := router(directive = input()));
        end ++> RAG();
        end ++> User_QA();
        end ++> TODO();

        visit end;

    }

    
}

node router {
    has directive: str = "directive";

    can directe_path with query entry{

        if (self.directive == "RAG") {

            # print("RAG node");
            RAG_node = [-->](`?RAG)[0];
            visit RAG_node;

        } elif (self.directive == "QA") {

            # print("User_QA node");
            QA_node = [-->](`?User_QA)[0];
            visit QA_node;

        } elif (self.directive == "TODO") {

            # print("TODO node");
            TODO_node = [-->](`?TODO)[0];
            visit TODO_node;
        }
    
    # visit [-->];
    }

}

node RAG {
    can printRAG with query entry{
        print("I am RAG");
    }
}

node User_QA {
    can sayRes with query entry{
        print("I will respond using user data.");
        # data_node = [-->](`?data)[0];
        print(here.user_data);
    }
}

node TODO {
    can respo with query entry{
        print("I will respond using a user to-do list.");
    }
}

'''
This is where we create the graph.
'''
walker create_graph{
    has user_data:dict = {};
    has todo_list:list = [];

    can generate_graph with `root entry{
        end = here; # Assign the current root node (here) to end
        end ++> (end := user()); # Create a user node and connect it to the end node. Assign the new user node to the end.
        end ++> data(user_data = self.user_data); # Create a data node with the user data and connect it to the end node.
        end ++> todo(todo_list = self.todo_list); # Create a todo node with the todo list and connect it to the end node.
        chat() spawn [-->](`?user)[0]; # Spawn the chat walker with the user node.
    }
}

with entry {
    create_graph(   user_data={ "age": 20,
                                "Pressure": (120, 80),
                                "Married": False
                            },
                     todo_list=["Do heart surgery",
                                "Buy Bread",
                                "Have pizza for dinner"]
                ) spawn root;
}
