function reconstruct_marker_GUI(F_GUT, F_SCHLECHT, M1, M2, M3, MR, changename)



M = c3dserver;

openc3d(M,0, F_GUT);
%%
[Markers, Labels, Gaps, start, ende, freq] = getlabeledmarkers(F_GUT);
assignin('base', 'Markers', Markers);
[O_frame, R_frame] = gettechnicalframe_reconstruct(Markers.(M1).data, Markers.(M2).data,Markers.(M3).data);

for i = 1:size(Markers.(M1).data,2)
    MR_lokal(:,i) = R_frame(:,:,i)' * (Markers.(MR).data(:,i) - O_frame(:,i));
end

MR_lokal_mean = mean(MR_lokal,2);

closec3d(M);




M2c3d = c3dserver;

openc3d(M2c3d,0, F_SCHLECHT);
%%

[Markers2, Labels2, Gaps2, start2, ende2, freq2] = getlabeledmarkers(F_SCHLECHT);


[O_frame2, R_frame2] = gettechnicalframe_reconstruct(Markers2.(M1).data, Markers2.(M2).data,Markers2.(M3).data);
for i = 1:size(O_frame2,2)
    MR_global(:,i) = R_frame2(:,:,i) * MR_lokal_mean + O_frame2(:,i);
end
IND_ADDED_MARKER = M2c3d.AddMarker;
index1 = M2c3d.GetParameterIndex('POINT', 'LABELS');
n_channels = M2c3d.GetParameterLength(index1);
for w = 1:n_channels
    if sum(strcmp(M2c3d.GetParameterValue(index1,w-1), MR)) > 0
        channelMR = w-1
    end
end
if ~exist('channelMR', 'var')
    index2 = M2c3d.GetParameterLength(index1);
    IND_ADDED_PARAMETER = M2c3d.AddParameterData(index1,1);
    M2c3d.SetParameterValue(index1,IND_ADDED_MARKER, MR);
    for l = 0:2
        M2c3d.SetPointDataEx(IND_ADDED_MARKER, l, start2, single(MR_global(l+1,:)));
    end
else
    for l = 0:2
        M2c3d.SetPointDataEx(channelMR, l, start2, single(MR_global(l+1,:)));
        disp('done');
    end
    M2c3d.SetPointDataEx(channelMR, 3, start2, single(zeros(1,length(MR_global))));
end
if changename
    nRet = M2c3d.SaveFile([F_SCHLECHT(1:end-4), '_CORR.c3d'],-1);
else
    nRet = M2c3d.SaveFile([F_SCHLECHT(1:end-4), '.c3d'],-1);
end
closec3d(M2c3d)


