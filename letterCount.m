function letterCounts = letterCount(word)
% LETTERCOUNT finds the count of each letter in a word "word"
% --- "word" is a character array (string acceptable)


% converts word to lowercase
word = lower(word);

% converts word to a character array
word = char(word);

% converts a to numbers
wordAsNum = word - 'a' + 1;

% defines edge (letters a-z as numbers)
edgesLetters = [1:27];

% counts the number of times each letter occurs
letterCounts = histcounts(wordAsNum, edgesLetters);

end