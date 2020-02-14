function [Markers, Labels, Gaps, start, ende, freq, ftkratio] = getlabeledmarkers(Pfad)
% liest die im C3D File 'Pfad' gespeicherten Markerpositionen aus und
% schreibt deren Koordinaten in die Struktur Markers. Hierbei steht die
% X-Koordinate in der ersten Zeile, Y inder zweiten und Z in der dritten
% Koordinate. Die einzelnen Frames stehen jeweils in einer Spalte.
% Ghostmarker werden ignoriert. Labelnamen, die mit Zahlen beginnen sollten
% vermieden werden. Im C3D File vorhandene Labelnamen werden in das Cell
% Array Labels gespeichert. Sollten Gaps im File vorhanden sein werden sie
% in der Struktur Gaps.'labelname'.exist vermerkt (0 = kein Gap, 1 = Gap).
% Ob in einem einzelnen Frame ein Gap vorhanden ist wird in
% Gaps.'labelname'.frame vermerkt.
% start und ende sind die Positionen des ersten bzw. letzten Frames im File
% (=Positionen der Schneidemarken).
% freq ist die Aufnahmefrequenz der Videodaten.

%% Öffnen des C3D Files zum Einlesen von Daten mit Hilfe des C3D Servers
M = c3dserver;
openc3d(M,0,Pfad);
freq = M.GetVideoFrameRate;
ftkratio = M.GetAnalogVideoRatio;

%% Ermitteln von Ausgabevariablen start und ende
start = M.GetVideoFrame(0);
ende = M.GetVideoFrame(1);

%% Einlesen von Label Namen und Speichern in Labels, nachfolgend Einlesen
%% der Markerkoordinaten in Markers
index1 = M.GetParameterIndex('POINT', 'LABELS');
n_labels = M.GetParameterLength(index1);
run = 1;
for i = 0:n_labels-1
    label = deleteblank(M.GetParameterValue(index1,i));
    sternlabel = findstr(label, '*');
    
    if isempty(sternlabel) 
        Labels(run,1) = cellstr(label);
        run = run+1;
        for j = 0:2
            Markers.(label).data(j+1,:) = cell2mat(M.GetPointDataEx(i,j,start,ende,'1'));
        end
    end
    clear label sternlabel
end

%% Überprüfung auf Gaps
for k = 1:length(Labels)
    for l = 1:ende-start+1
        if sum(Markers.(char(Labels(k,1))).data(1:3,l)) == 0
            Gaps.(char(Labels(k,1))).frames(1,l) = 1;
        else
            Gaps.(char(Labels(k,1))).frames(1,l) = 0;
        end
    end
    Gaps.exist = 0;
    if sum(Gaps.(char(Labels(k,1))).frames(1,:)) > 0
        Gaps.(char(Labels(k,1))).exist = 1;
        Gaps.exist = 1;
    else
        Gaps.(char(Labels(k,1))).exist = 0;
    end
end
closec3d(M);