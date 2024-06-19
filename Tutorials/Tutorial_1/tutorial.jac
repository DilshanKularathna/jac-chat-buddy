'''
The guess will allow a player to guess a number between 1 and 100. The player will have 10 chances to guess the number.
'''
# import the random module, from random import randit

import:py random;

walker GuessGame {
    has corrrect_number:int = random.randint(1,100); #(1,100) |> random.randit;
    can start_game with `root entry;
    can process_guess(guess:int);

}

node turn{
    can check with GuessGame entry;

}

# ===============================================================

:node:turn:can:check {
    guess = input("Enter a number between 1 and 100 :");
    if guess.isdigit() {
        here.process_guess(guess = int(guess));
    } 
    else {
        print("Please enter a valid number");
    }

    visit [-->];
    #self.
    #here.
}

:walker:GuessGame:can:start_game {
    end = here;
    for i=0 to i<10 by i+=1 {
        end ++> (end := turn());
    }
    visit [-->];
    #self.
    #here. #-> The Node which walker is on at the time
}

:walker:GuessGame:can:process_guess {
    if guess == self.corrrect_number {
        print("You guessed the correct number");
        disengage;
    } elif guess < self.corrrect_number {
        print("Your guess is too low");
    } else {
        print("your guess is too high");
    }

}

with entry {
    GuessGame() spawn root;
}
