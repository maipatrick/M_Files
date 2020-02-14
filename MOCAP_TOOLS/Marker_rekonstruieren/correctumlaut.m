function Y = correctumlaut(string)
for i = 1:length(string)
    if string(i) == 'ä'
        string(i) = 'a';
    elseif string(i) == '-'
        string(i) = '_';
    elseif string(i) == 'ö'
        string(i) = 'o';
    elseif string(i) == 'ü'
        string(i) = 'u';
    elseif string(i) == 'ß'
        string(i) = 's';
    end
end

Y = string;