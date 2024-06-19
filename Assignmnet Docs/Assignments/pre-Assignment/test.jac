'''
Guess game as a graph (binary tree)
'''

import:py random;

walker Runner {
    has correctAns: int = random.randint(1, 100);
    can start_game with `root entry;
    can runner_logic(playerAns:int);
}

node high {
    can checkH with Runner entry;
}

node low {
    can checkL with Runner entry;
}


# =========================================================================================

:walker:Runner:can:start_game {
    end = here;
    

    

    visit [-->];
}

:node:high:can:checkH {
    print("High");
    visit [-->];

}

:node:low:can:checkL {
    print("low");
    visit [-->];

}

:node:connector:can:connect {
    guess = int(input("Number :" ));
    here.runner_logic(playerAns = guess);
    visit [-->];

}

:walker:Runner:can:runner_logic {
    if playerAns == self.correctAns {
        print("you won");
        disengage;
    } elif playerAns < self.correctAns {
        print("low");
        end ++> (end := low());
    } else {
        print("high");
        end ++> (end := high());
    }


}

#=========================================================================================================

with entry {
    Runner() spawn root;
}