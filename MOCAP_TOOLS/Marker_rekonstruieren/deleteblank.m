function Y = deleteblank(string)
leer = char(32);
j = 1;
for i = 1:length(string)
    if string(i) ~= leer;
        Y(j) = string(i);
        j=j+1;
    end
end