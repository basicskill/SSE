%% Zadatak 3
sigma1 = 0.1;
sigma2 = 1;

%% Teorija
x1 = -0.4:0.04:0.4;
x2 = -4:0.4:4;

[X1, X2] = meshgrid(x1, x2);
F = 1/(2*pi*sigma1*sigma2) *  ...
        exp(-(X1.^2)/(2*(sigma1^2)) - (X2.^2)/(2*(sigma2^2)));

%% Eksperiment
N = 1e5;
eksperiment = randn(N, 2);
eksperiment(:, 1) = eksperiment(:, 1) .* sigma1;
eksperiment(:, 2) = eksperiment(:, 2) .* sigma2;

%% Plot
f0 = figure;
histogram2(eksperiment(:, 1), eksperiment(:, 2), [20 20], ...
            'Normalization', 'pdf');
title('Eksperiment')
xlabel('x_1'); ylabel('x_2'); zlabel('f_e(x_1, x_2)')
saveas(f0, 'z3_a_eksperiment.jpg');

f1 = figure;
h = surf(x1, x2, F);
title('Teorija')
xlabel('x_1'); ylabel('x_2'); zlabel('f(x_1, x_2)')
saveas(f1, 'z3_a_teorija.jpg')

%% Drugi deo zadatka
%% Generisanje Y

A = [16, -1.2; 0, 3];
b = [0; 10];

Y = (A*eksperiment' + b)';

%% Ocekivanje
m = sum(Y) / N

%% Varijansa
R = ((Y - m)' * (Y - m)) / (N - 1);
R

f2 = figure;
plot(Y(:, 1), Y(:, 2), 'bx')
xlabel('Y_1')
ylabel('Y_2')
title('Raspodela Y za \rho = -0.6')
saveas(f2, 'z3_y.jpg')

%% d) ro = 0
A_1 = [20 0; 0 3];
Y_1 = (A_1*eksperiment' + b)';

f3 = figure;
plot(Y_1(:, 1), Y_1(:, 2), 'bx')
xlabel('Y_1')
ylabel('Y_2')
title('Raspodela Y za \rho = 0')
saveas(f3, 'z3_y1.jpg')

%% d) ro = 0.8
A_2 = [12 1.6; 0 3];
Y_2 = (A_2*eksperiment' + b)';

f4 = figure;
plot(Y_2(:, 1), Y_2(:, 2), 'bx');
xlabel('Y_1')
ylabel('Y_2')
title('Raspodela Y za \rho = 0.8')
saveas(f4, 'z3_y2.jpg')




