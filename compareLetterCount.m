function comparedCount = compareLetterCount(matchList, comparedWord)
% COMPARELETTERCOUNT creates a vector that matches the count of
% each letter in string/char "matchList" in a word "comparedWord"
% --- "matchList" is a character array (string acceptable) containing a list of letters
% --- "comparedWord" is a character array word (string acceptable)
% returns a 1 x 26 vector where, based on the original LetterCount "comparedWord",
% only the counts of the letters in "matchList" are displayed
% e.g., if "matchList" contains 'abc', only the count of 'a', 'b' and 'c' are
% shown from "comparedWord" even if other letters occurs


% converts matchList and comparedWord to a character array
matchList = char(matchList);
comparedWord = char(comparedWord);

% extracts letters from matchList
matchList = matchList(isstrprop(matchList, "alpha"));

% obtains the letterCount of comparedWord
comparedWordLetterCount = letterCount(comparedWord);

% converts matchList to lowercase
matchList = lower(matchList);

% converts matchList to numbers
matchListAsNum = matchList - 'a' + 1;

% initialises newLetterCounts
newLetterCounts = zeros(1,26);

% finds the number of times each guess occurs
for i = 1:length(matchList)

    % searches each guessed letter count from old letterCount "b"
    newLetterCounts(matchListAsNum(i)) = comparedWordLetterCount(matchListAsNum(i));

end

comparedCount = newLetterCounts;

end