plot(KNEE.Y)
hold on
for i = 1:length(StartFlex)
plot([StartFlex(i) StartFlex(i)], get(gca, 'Ylim'), 'g--');
end

for i = 1:length(StartFlex)
plot([EndFlex(i) EndFlex(i)], get(gca, 'Ylim'), 'r--');
end