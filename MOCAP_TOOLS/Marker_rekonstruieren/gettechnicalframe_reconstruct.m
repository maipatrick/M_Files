function [O_frame, R_frame] = gettechnicalframe_reconstruct(M1, M2,M3)
%% Die Funktion gibt die Rotationsmatrix des Unterschenkelsegments relativ zum
%% globalen Koordinatensystem zurück. MMAL, LMAL, und TIB sind die
%% Ortsvektoren (3 x 1 x n) der dazugehörigen Marker im globalen
%% Koordinatensystem im Bild n.
%% bein kann entweder 'l' oder 'r' (linkes oder rechtes Bein sein). Die
%% positive Y Achse des Segments zeigt immer nach medial. X immer nach
%% vorne, Z nach oben.
%% origin kann entweder 'MALL' (Mittelpunkt zwischen den drei Punkten).
%% 'PMAL' (Mittelpunkt zwischen MMAL und LMAL) oder 'MMAL', 'LMAL'
%% oder'TIB' (Origin im jeweiligen Punkt) sein.

[x, y] = size(M1);
O_frame = zeros(3,y);

if nargin == 3;
    for i = 1:y
        O_frame(1:x,i) = (M1(1:x,i) + M2(1:x,i) + M3(1:x,i)) / 3;
    end
end




Help1 = zeros(3,1,y);
X = zeros(3,1,y);
Y = zeros(3,1,y);
Z = zeros(3,1,y);
for i = 1:y
    
    
    X(1:x,i) = M3(1:x,i) - M1(1:x,i);
    Help1(1:x,i) = M2(1:x,i) - M1(1:x,i);
    Z(1:x,i) = cross(X(1:x,i), Help1(1:x,i));
    Y(1:x,i) = cross(Z(1:x,i), X(1:x,i));
    X(1:x,i) = X(1:x,i) / norm(X(1:x,i));
    Y(1:x,i) = Y(1:x,i) / norm(Y(1:x,i));
    Z(1:x,i) = Z(1:x,i) / norm(Z(1:x,i));
end






R_frame = [X,Y,Z];