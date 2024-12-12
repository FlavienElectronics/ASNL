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

for l = 1:5                 % nombre de trajectoires à simuler/tracer
    [x1_0,x2_0] = ginput(1);  % récupère les coordonnées (x,y) du point cliqué sur le graphique
    Vtheta0 = -x1_0;          % mise à jour des conditions initiales pour le simulink
    dVtheta_dt0 = -x2_0;
    %disp([num2str(Vtheta0), " , " ,num2str(dVtheta_dt0)]);
    text = sprintf('(x1_0 ; x2_0) =  (%.3f ; %.3f)',x1_0,x2_0);
    disp(text);
    simOut = sim('simTP1_2023a.slx');     % lancement simulation
    x1 = simOut.get("x1");       % x1 = V_theta_point - V_theta
    x2 = -simOut.get("x2");         % x2 = -dV_theta
    %x1 = simOut.simout.Data(:,1); % x1 = erreur
    %x2 = simOut.simout.Data(:,2); % x2 = accélération
    plot(x1,x2,'LineWidth',2);          % mise à jour du portrait de phase

    drawnow
end


% %
% % Simulation pour système TD2
% %
% 
% clear all
% close all
% 
% theta0 = 2;
% r = 4;
% k = 0.1;
% M = 0.5;
% 
% xmin = -M*2;
% ymin = -k*M*2;
% xmax = -xmin;
% ymax = -ymin;
% 
% 
% figure1 = figure; axes1 = axes('Parent',figure1); hold(axes1,'on');
% box(axes1,'on'); grid(axes1,'on'); set(axes1,'FontSize',14);
% ylabel('$x_2$','FontSize',20,'Interpreter','latex');
% xlabel('$x_1$','FontSize',20,'Interpreter','latex');
% axis([xmin xmax ymin ymax]);
% hold on;
% plot([-M -M],[ymin ymax],'m:','LineWidth',2);
% plot([M M],[ymin ymax],'m:','LineWidth',2);
% plot([xmin xmax],[-k*M -k*M],'m:','LineWidth',2);
% plot([xmin xmax],[k*M k*M],'m:','LineWidth',2);
% 
% for l = 1:5
%     [x10,x20] = ginput(1);      % selection graphique des conditions initiales
%     theta0 = r-x10;
%     simout = sim('simDCmotorControl',[0 40]); % lancement du modele simulink
%     x1 = simout.get('x1');      % 1er composante etat x
%     x2 = simout.get('x2');      % 2nd composante etat x
%     theta = simout.get('theta');% sortie du systeme theta
%     tout = simout.get('tout');  % temps t  
% 
%     % tracé traj dans plan de phase
%     plot(x1,x2,'LineWidth',2);
% 
% 
%     drawnow
% end



