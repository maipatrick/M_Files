function [FRAMEWORK, n_subjects] = get_file_framework_generell(top_folder, type)
%This function gets you the file framework. The idea is that you can use
%this framewrok to loop through all the data from your study. This allows
%you to start data analysis by one click and afterwords the model takes the
%data by itself, if the data is arranged in the correct way inside the
%folder structure (framework)


folders = dir(top_folder);
n_dir = 1;
size_framework = size(folders,1) - 2;

for d = 3:size_framework+2
    if folders(d).isdir
        FRAMEWORK(n_dir).pathname = cellstr([char(top_folder),'/', folders(d).name, '/']);
        C3ds = dir([char(FRAMEWORK(n_dir).pathname),type]);
        
        
        for e = 1:size(C3ds,1)
            FRAMEWORK(n_dir).filename(e) = cellstr(C3ds(e).name);
        end
        n_dir = n_dir+1;
        clear C3ds CSVs
    end
end
n_subjects = n_dir - 1;
