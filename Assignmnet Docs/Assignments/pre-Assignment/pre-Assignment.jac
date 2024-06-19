'''
The guess game ==> guess a number between 1 to 100 in 10 chances
'''
import:py random; # to get randint function form random lib
#import:py from random, randint; # if want to only import the randint function

#Use include file_name.jac to inclued a jac file as an external module

# walker and node declarations with their methods(Abilities) and attributes(variabal parameters)

walker GuessGame{ # initializing a walker to walk through the graph
    has correct_number:int = random.randint(1, 100);
    can start_game with `root entry; # the method(Ability) only runs when a walker hit the root node
    can process_guess(guess:int); # a normal method (Normal Ability)
}

node turn{ # initializing a node of the graph
    can check with GuessGame entry;
}

# =====================================================================================================================

# Start to complete the methods defined in above objects

:node:turn:can:check {
    # if we say self. inside this it means turn node
    # if we uses here. we can access the walker currently in the node
    guessNum = input("Number between 1 and 100: ");
    if guessNum.isdigit() {
        # guess = int(guess);
        here.process_guess(guess = int(guessNum)); #Calling process_guess inside the node
    } else {
        print("Number is not valid");
    }

    visit [-->]; #Tell the walker to move on to the next node
}

:walker:GuessGame:can:start_game {
    #* if we say self. inside this it means GuessGame walker we can acsess the atribures of 
       GuessGame walker using this self. keyword *#
    # if we use here. we can access the node the walker currently in
    end = here; # giving the point as starring point
    #end ++> turn(); #create a turn node and connnect it with the root node using a genericEdge(using ++>)
    #end ++> (end := turn()); # like above comment connect it to the root and assigning new built node as the end
    #To create 10 such nodes use a for loop
    for i=0 to i<10 by i+=1{
        end ++> (end := turn());
    }
    # Now the linear graph has been made
    # Now its time to navigate through the graph

    visit [-->]; #This will visit the each node (In my knoledege)
}

:walker:GuessGame:can:process_guess{
    if guess == self.correct_number {
        print("You won! ");
        disengage; # If won no need to traverse the graph enymore so remove the walker(In this case the GuessGame) from the graph
    } elif guess < self.correct_number {
        print("Number is low try again");
    } else {
        print("Number is high tyr again");
    }
     # No need to tell the valker to visit(visit [-->];) anywere because we have already said him to visit in start_game
     # This method is just a function to communicate with the player
}

# ============================================================================================================

#To start the walker to get into initiatiting game
with entry {
    GuessGame() spawn root; # This tells the walker(In our case GuessGame) to come and start your work from the root
}


