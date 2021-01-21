% Zadatak 1
% Eksperiment: bacanje debelog novčića

% P(pismo)  = 0.33
% P(glava)  = 0.66
% P(strana) = 0.01

% Teorijske vrednosti
p = [0.33, 0.66, 0.01];
F = cumsum(p);
x_osa = [0, 1, 2];

%% Eksperiment
N = 1000;
eksperiment = rand(N, 1);
eksperiment(eksperiment <= 0.33) = 0;
eksperiment(0.33 < eksperiment & eksperiment <= 0.99) = 1;
eksperiment(0.99 < eksperiment & eksperiment < 1) = 2;

pismo  = sum(eksperiment == 0) / N;
glava  = sum(eksperiment == 1) / N;
strana = sum(eksperiment == 2) / N;

p_eksp = [pismo, glava, strana];
F_eksp = cumsum(p_eksp);

%% Plot
f0 = figure;
histogram(eksperiment)
xticks([0 1 2])
xticklabels({'pismo'; 'glava'; 'strana'})
title('Histogram ishoda 10^3 eksperimenata')
saveas(f0, 'z1_ishod eksperimenta.jpg')

f1 = figure;
bar(x_osa, [p; p_eksp]');
title('Funkcija mase verovatnoće')
legend('egzaktna', 'eksperimentalna')
saveas(f1, 'z1_masa_verovatnoce.jpg')

f2 = figure;
bar(x_osa, [F; F_eksp]')
title('Funkcija raspodele')
legend('egzaktna', 'eksperimentalna')
saveas(f2, 'z1_gustina_raspodele.jpg')

%% Numericke karakteristike
m = sum(eksperiment) / N
v = sum((eksperiment - m) .^ 2) / (N - 1)