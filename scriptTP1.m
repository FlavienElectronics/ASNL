%
% Script TP1 ASNL - Asservissement d'un moteur DC avec commande hystérésis
%

%% définition paramètres et systèmes
Delta = 4;
M = 6;

Km = 38.57;
tau = 0.27;
Kg = 0.0129;
Ks = 1.57;
k2 = 0;

% conditions initiales
Vtheta0 = 0;
dVtheta_dt0 = 0;

Gm = tf(Km,[tau 1]);
Int = tf(1,[1 0]);

% FTBO
G = Gm * Ks/9 * Int;



% Simulation
simOut = sim('simTP1_2023a.slx');
figure
plot(simOut.tout,simOut.simout.Data(:,2),'LineWidth',2); grid on;


% Représentation dans le plan de phase
% initialisation figure
xmin = -Delta/2*3; ymin = -Km*Ks*M/9*1.1; xmax = -xmin; ymax = -ymin;
figure1 = figure; axes1 = axes('Parent',figure1); hold(axes1,'on');
box(axes1,'on'); grid(axes1,'on'); set(axes1,'FontSize',14);
ylabel('$x_2$','FontSize',20,'Interpreter','latex');
xlabel('$x_1$','FontSize',20,'Interpreter','latex');
axis([xmin xmax ymin ymax]);
hold on;

% simulation portrait de phase /!\ Compléter les "..." /!\

for l = 1:5                 % nombre de trajectoires à simuler/tracer
    [x10,x20] = ginput(1);  % récupération des conditions initiales pointées sur le graphique de la figure
    Vtheta0 = ...;          % mise à jour des conditions initiales pour le simulink
    dVtheta_dt0 = ...;
    simOut = sim('simTP1_2023a.slx');     % lancement simulation
    x1 = ...;                           % récupération de l'état x1 et x2 simulés
    x2 = ...;
    plot(x1,x2,'LineWidth',2);          % mise à jour du portrait de phase

    drawnow
end



