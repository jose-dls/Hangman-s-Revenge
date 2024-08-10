function shownWordOutput = shownWord(hangmanWord)
% SHOWNWORD creates shownWord given a vector "hangmanWord"
% --- "hangmanWord" must be a 2 x m vector where m is the length of the word
% === row 1 must contain the letters of the word
% === row 2 must contain boolean values depending on whether the respective
% letter (same column) is hidden or shown (0 = hidden; 1 = shown)


% initialises shownWord within the function
shownWord = '';

for i = 1:size(hangmanWord, 2)

    % checks which letters are marked as visible and hidden
    if hangmanWord(2, i)

        % reveals visible letters
        shownWord = [shownWord, hangmanWord(1, i), ' '];

    else

        % shows hidden letters as "_ "
        shownWord = [shownWord, '_ '];

    end
end

% outputs shownWord
shownWordOutput = shownWord;

end