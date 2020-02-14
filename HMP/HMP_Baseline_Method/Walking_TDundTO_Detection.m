clc
clear
close all

[filename, pathname] = uigetfile('*.mat', 'MatFiles auswählen bitte', 'C:\Users\maipa\Desktop\HMP_Steffen_Test_Data\HMP\Stairs_Down_Right', 'MultiSelect', 'on');
if ischar(filename)
   filename = {filename}; 
end

for i = 1:length(filename)
   load([pathname, filename{i}], 'WINKEL')
   
   fnames = fieldnames(WINKEL);
   
   for t = 1:length(fnames)
        W = WINKEL.(fnames{t}).JOINT.Classic.Right_Knee.grad.Y;
        figure
        plot(W);
                   title ((fnames{t}), 'interpreter', 'none')
        box off
        hold on
        [x,~] = ginput;
        for tt = 1:length(x)
           [~,TD.(fnames{t})(tt)] = min(W(x(tt)-20:x(tt)+20));
           TD.(fnames{t})(tt) = round(TD.(fnames{t})(tt)+ x(tt)-19);

           plot([TD.(fnames{t})(tt) TD.(fnames{t})(tt)], get(gca, 'Ylim'), 'k--');
        end
        [x2,~] = ginput(length(x));
        for tt = 1:length(x)
           PF.(fnames{t})(tt) = x2(tt);
           
           plot([PF.(fnames{t})(tt) PF.(fnames{t})(tt)], get(gca, 'Ylim'), 'r--');
        end
        pause
        
        close(gcf);
        
   end
   save( [pathname, filename{i}] , 'TD', 'PF' ,'-append');
end