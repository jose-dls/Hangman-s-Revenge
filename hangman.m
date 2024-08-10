% Project [Hangman's Revenge] (J.D)

% Program recreates the popular paper and pencil guessing game "Hangman" in
% which "[o]ne player [in this case the program] thinks of a word... and
% the other [in this case the user] tries to guess it by suggesting letters
% within a certain number of guesses."
% (Wikipedia 2022)
% [https://en.wikipedia.org/wiki/Hangman_(game)]


% initialises selectingMode - boolean var containing state of selection
% screen
selectingMode = 1; % true - selection in progress

% welcome screen
while selectingMode

    % welcome message and gamemode selection
    selectedMode = input("Welcome to Hangman :)\n" + ...
        "Please select a gamemode.\n" + ...
        "[1] - Singleplayer (Easy)\n" + ...
        "[2] - Singleplayer (Medium)\n" + ...
        "[3] - Singleplayer (Hard)\n" + ...
        "[4] - Singleplayer (Hangman's Revenge)\n" + ...
        "[5] - Multiplayer\n" + ...
        "[6] - Help\n", "s");

    % converts selectedMode to number
    selectedMode = str2num(selectedMode);

    % checks if input is a valid gamemode
    if ~ismember(selectedMode, [1:6])
        % invalid gamemode (not a number assigned to a mode)

        fprintf("Please select a valid gamemode.\n")

        % dummy input to stall text and wait for user
        input("Please press any key to return.\n", "s");

    elseif isempty(selectedMode)
        % invalid gamemode (empty input)

        fprintf("Please select a valid gamemode.\n")

        % dummy input to stall text and wait for user
        input("Please press any key to return.\n", "s");

    elseif selectedMode == 6
        % help screen
        imshow("help.png");
    elseif ismember(selectedMode, [1:5])
        % valid gamemode selected
        selectingMode = 0; % ends selection process
    end
end


% sets nGuessesLeft (number of incorrect guesses depending on difficulty)
% will be used to track how many guesses the player has left
switch selectedMode
    case 1
        nGuessesLeft = 10; % easy
    case 2
        nGuessesLeft = 8; % medium
    case 3
        nGuessesLeft = 6; % hard
    otherwise
        nGuessesLeft = 8; % Hangman's Revenge & multiplayer
end


% generates a word for the game
if ismember(selectedMode, [1:4])
    % singleplayer - random word by program

    % creates a vector "wordlist" containing all of the words in the text file
    % wordlist.txt
    wordlistID = fopen('wordlist.txt');
    wordlist = textscan(wordlistID, '%s');
    wordlist = transpose(wordlist{:});
    fclose(wordlistID);

    rng("shuffle"); % shuffles rng

    % obtains a random word from wordlist and converts to character array
    % to allow for hangman manipulation
    randomWord = char(wordlist(randi(length(wordlist))));
    % initialises hangmanWord
    hangmanWord = randomWord;

else
    % multiplayer - word by second player

    % initialises isInputting - boolean var containing state of Player 2
    % inputting word
    isInputting = 1;

    while isInputting

        % asks Player 2 to input a word; removes leading and trailing
        % whitespace
        hangmanWord = strtrim(input("Player 2, please enter a word: ", "s"));


        % checks if the input is valid (only contains letters)

        % creates a model that is valid
        validWordModel = ones(1, size(hangmanWord, 2));

        if validWordModel == isletter(hangmanWord)
            % valid word

            % exits inputting process
            isInputting = 0; % sets isInputting false

        else
            % invalid word
            fprintf("That is not a valid word.\n")
        end
    end
end

% modifies hangmanWord: stores the word for hangman in row 1 and a boolean
% value in row 2 indicating whether respective letter in column is hidden
% or revealed (has been guessed)
hangmanWord(2,:) = 0; % all false/hidden


% initialises guesses (contains letters guessed)
guesses = [];

% initialises correctGuesses (contains the correct letters guessed)
correctGuesses = [];

% initialises incorrectGuesses (contains the incorrect letters guessed)
incorrectGuesses = [];


% hides Player 2's word if multiplayer
if selectedMode == 5
    fprintf("\n\n\n\n\n\n\n\n\n\n");
end

% begins the game
fprintf("The game has started. Good luck.\n");

% displays the word for the first time (empty)
fprintf("%s\n", shownWord(hangmanWord));

% draws hangman image for the first time - initial stage depends on
% difficulty
drawHangman(10 - nGuessesLeft);

% initialises inProgress - boolean var containing progress state of game
inProgress = 1; % true; currently in progress

% initialises player1Won - boolean var containing win state of game
player1Won = 0; % false: player 1 losing at start

% initialises isHangmansRevenge - boolean var containing whether hangman's
% revenge is being played and initialises a vector for each word progression
if selectedMode == 4
    % is Hangman's Revenge

    isHangmansRevenge = 1; % turns on Hangman's Revenge
    wordProgression = []; % vector of all words in the game

else
    % is not Hangman's Revenge
    isHangmansRevenge = 0;
end

% runs the game while inProgress is true
while inProgress

    % populates wordProgression (when Hangman's Revenge)
    if isHangmansRevenge
        wordProgression = [wordProgression; string(hangmanWord(1,:))];
    end

    
    % initialises guessing - boolean var containing state of guess (whether
    % the user is still guessing a letter)
    guessing = 1; % true

    % runs the guessing sequence
    while guessing

        % shows the number of guesses left and the letters used
        fprintf("You have %d guesses left and have used the letters [%s].\n" ...
            , nGuessesLeft, guesses);

        % asks the user for a letter guess
        guess = lower(input("Please enter a letter: ", "s")); % sets lowercase

        % checks if the current guess is valid (single character; is a
        % letter; is not a previous guess)
        if length(guess) == 1 && isletter(guess) && ~ismember(guess, guesses)

            % saves the current guess to vector guesses
            guesses = [guesses, guess];

            % sets guessing to 0; therefore, guessing sequence has finished
            guessing = 0;

        else
            % guess invalid; asks the user for another letter
            fprintf("Please enter a valid letter.\n");
        end
    end


    % checks if the letter guessed is part of the hangman word

    % initialises isPart - boolean var containing state of whether guess is
    % a part of hangmanWord
    isPart = 0; % false

    for i = 1:size(hangmanWord, 2) % checks all letters
        if guess == hangmanWord(1, i)
            % found first letter in word equal to guess

            % finds all spaces where the guess exists in hangmanWord
            correctLocation = find(hangmanWord(1,:) == guess);

            % marks the letters in hangmanWord which are correctly found by
            % the guess
            for j = correctLocation
                hangmanWord(2,j) = 1;
            end

            % adds guess to the correctGuesses list
            correctGuesses = [correctGuesses, guess];
            isPart = 1; % sets isPart to true

            break % only check if the letter is part of the word once
        end
    end

    % if the guess is not part of the word
    if ~isPart

        % decreases the number of guesses left by 1
        nGuessesLeft = nGuessesLeft - 1;

        % adds guess to incorrectGuesses
        incorrectGuesses = [incorrectGuesses, guess];

        % as guess was incorrect, drawHangman
        drawHangman(10 - nGuessesLeft);

        % checks if the user has guesses left
        if nGuessesLeft == 0 % no guesses left
            inProgress = 0; % game ends
        end
    end

    
    % displays the hangmanWord - considering revealed letters
    fprintf("%s\n", shownWord(hangmanWord));
    


    % checks if the player has won the game because of the current guess
    % checks if the second row (correct guess indicator) is all ones
    if hangmanWord(2,:) == ones(size(hangmanWord, 2))
        player1Won = 1; % sets player1Won state to true (player won)
        inProgress = 0; % sets inProgress state to false
    end


    % changes the word (Hangman's Revenge)
    if isHangmansRevenge && inProgress

        % finds the number of times each correct guess occurs
        currentGuessesCounts = compareLetterCount(correctGuesses, hangmanWord(1,:));


        % finds words that match with the previous guesses (including the
        % count of each letter)

        % initialises matchingWords - vector storing all words that match
        matchingWords = [];

        % converts letters in guesses into numbers
        guessesAsNum = guesses - 'a' + 1;

        % searches wordlist for words that match guesses
        for i = 1:length(wordlist)

            % initialises nCorrectMatch - number of correct letter matches
            nCorrectMatch = 0;

            % letter count of current word being checked "wordlist(i)"
            iLetterCount = letterCount(char(wordlist(i)));

            for j = guessesAsNum
                % finds the number of correct letter matches
                if currentGuessesCounts(j) == iLetterCount(j)
                    nCorrectMatch = nCorrectMatch + 1;
                end
            end

            % adds correct matches to matchingWords
            if nCorrectMatch == length(guesses)
                matchingWords = [matchingWords; wordlist(i)];
            end

        end

        % replaces hangmanWord with new one from matchingWords

        % empties hangmanWord
        hangmanWord = [];

        % generates a new random word
        hangmanWord = char(matchingWords(randi(length(matchingWords))));

        % generates row 2 of hangmanWord
        hangmanWord(2,:) = 0; % all false

        % sets back all the correct letters
        for i = 1:length(correctGuesses)

            % finds new location of each correctly guessed letter
            newLocation = find(hangmanWord(1,:) == correctGuesses(i));
            
            % marks the new location in the new hangman word as found
            for j = newLocation
                hangmanWord(2,j) = 1;
            end

        end

    end
    
end


% defines the endState message of the game
if isHangmansRevenge
    % specific ending for Hangman's Revenge

    % sets the win state as lost
    endState = ['Player 1 lost. The final word was ', hangmanWord(1,:), '' ...
        ' and the original word was ', char(wordProgression(1)), '.'];

    % checks if the user won
    if player1Won
        n = newline;
        endState = ['Congratulations on winning Player 1 and guessing ' ...
            , hangmanWord(1,:), '!', n, 'The original word was ' ...
            , char(wordProgression(1)), '.'];
    end

else
    % ending for all gamemodes not Hangman's Revenge

    % sets the endstate as lost
    endState = ['Player 1 lost. The word was ', hangmanWord(1,:), '.'];

    % checks if the user won
    if player1Won
        endState = ['Congratulations on winning Player 1 and guessing ' ...
            '', hangmanWord(1,:), '!'];
    end
    
end

% prints the game over (ending) message
fprintf("The game has finished. %s\n", endState);

% asks the user if they want to see the progression of the words (Hangman's Revenge)
if isHangmansRevenge
    answer = input("\nDo you want to see the progression of words in your game?" + ...
        "\nType ""Y"" if yes, or anything else if no: ", 's');
    if upper(answer) == "Y"
        for i = 1:length(wordProgression)
            fprintf("%d. %s\n", i, wordProgression(i));
        end
    end
end