clc
clear
close all

'C:\IBO\Brooks_Tuned_Zones\HMP_AllMat\Ramp_Up_Right'
[filename, pathname] = uigetfile('*.mat', 'MatFiles auswählen bitte','C:\Users\maipa\Desktop\HMP\Cut\Fast_Walking' , 'MultiSelect', 'on');
if ischar(filename)
    filename = {filename};
end

for i = 1:length(filename)
    disp(filename{i});
    load([pathname, filename{i}], 'WINKEL')
    try
        load([pathname, filename{i}], 'TD')
        clear TD
    end
    fnames = fieldnames(WINKEL);
    
    for t = 1:length(fnames)
        W = WINKEL.(fnames{t}).JOINT.Classic.Right_Knee.grad.Y;
        figure
        plot(W);
        hold on
        title ((fnames{t}), 'interpreter', 'none')
        box off
        [x,~] = ginput;
        for tt = 1:length(x)
            [~,TD.(fnames{t})(tt)] = min(W(x(tt)-15:x(tt)+10));
            TD.(fnames{t})(tt) = round(TD.(fnames{t})(tt)+ x(tt)-19);
            plot([TD.(fnames{t})(tt) TD.(fnames{t})(tt)], get(gca, 'Ylim'), 'k--');
            
        end
        
        pause
        
        close(gcf);
        
    end
    save( [pathname, filename{i}] , 'TD' ,'-append');
end