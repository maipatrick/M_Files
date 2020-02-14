clc
clear 

close all

[FRAMEWORK, n_subjects] = get_file_framework_generell('C:\IBO\Brooks_Tuned_Zones\HMP_AllMat', '*.mat');

for n = [1,2,4,5,7,8,9,10,12,13]%1:n_subjects
    for i = 1:length(FRAMEWORK(n).filename)
        name = FRAMEWORK(n).filename{i};
        ustrich = findstr(name, '_');
%         if n == 1
%         mkdir(['C:\IBO\Brooks_Tuned_Zones\HMP_Baseline\',name(1:ustrich-1)]);
%         end
        copyfile([FRAMEWORK(n).pathname{1},'\', FRAMEWORK(n).filename{i}], ['C:\IBO\Brooks_Tuned_Zones\HMP_Baseline\',name(1:ustrich-1), '\',name])
        
    end
end