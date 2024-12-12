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


% Tracé du lieu de Nyquist
figure;
nyquist(G);
grid on;
title('Lieu de Nyquist de la FTBO');

% Amplitudes admissibles pour le lieu critique
A = linspace(Delta + 0.1, 10, 100); % A > Delta
C_reel = ( -(A*pi) / (4*M) ) .* ( sqrt(1 - ( (Delta^2) ./ (4*A) )));
C_imag = ( -(A*pi) / (4*M) ) .* (-Delta ./ (2*A) );      

% Superposition au graphe de Nyquist
hold on;
plot(C_reel, C_imag, 'r', 'LineWidth', 2);
legend('Lieu de Nyquist', 'Lieu critique');


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

% simulation portrait de phase 

% for l = 1:5                 % nombre de trajectoires à simuler/tracer
%     [x10,x20] = ginput(1);  % récupère les coordonnées (x,y) du point cliqué sur le graphique
%     Vtheta0 = x10;          % mise à jour des conditions initiales pour le simulink
%     dVtheta_dt0 = -x20;
%     simOut = sim('simTP1_2023a.slx');     % lancement simulation
%     x1 = simOut.simout.Data(:,1);         % x1 = V_theta_point - V_theta
%     x2 = simOut.simout.Data(:,2);         % x2 - -dV_theta
%     plot(x1,x2,'LineWidth',2);          % mise à jour du portrait de phase
% 
%     drawnow
% end



