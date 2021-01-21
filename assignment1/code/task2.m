%% Zadatak 2
x_osa   = linspace(-2/3, 4/3, 1000);
teorija = linspace(-2/3, 4/3, 1000);

%% Teoretska raspodela
teorija(x_osa < 0) = (3/2) * teorija(x_osa < 0) + 1;
teorija(x_osa > 0 & x_osa < 2/3) = 0;
teorija(2/3 < x_osa) = -3 * teorija(2/3 < x_osa) + 4;

%% Eksperiment
N = 1e5;
eksperiment = rand(N, 1);

eksperiment(eksperiment < 1/3) = (sqrt(3 * eksperiment(eksperiment < 1/3)) - 1) * 2/3;
eksperiment(eksperiment >= 1/3) = (4 - sqrt(6 - 6 * eksperiment(eksperiment >= 1/3))) / 3;

%% Plot
f1 = figure;
histogram(eksperiment, 50, 'Normalization', 'pdf')
hold on
plot(x_osa, teorija)
legend('eksperiment', 'teorija', 'Location', 'NorthWest')
title('Funkcija gustine verovatnoce')
saveas(f1, 'z2_plot.jpg')

%% Numericke karakteristike
m = sum(eksperiment) / N
v = sum((eksperiment - m) .^ 2) / (N - 1)