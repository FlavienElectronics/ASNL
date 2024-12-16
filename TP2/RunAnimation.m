%
% RunAnimation.m
% Script pour lancer l'animation du système de sustentation magnétique
% Il est nécessaire de lancer le simulink de simulation au préalable
%

t = out.simout.Time;
y = out.simout.Data(:,1);   % position de la bille

% parametres d'affichage
rbille = 0.5;
xpos = 0;
cercle = [0:0.01:2*pi];

figNumber=figure( ...
    'name','MagLev', ...
    'NumberTitle','off', ...
    'MenuBar', 'none');

imdata = imread('fond-animation.png','png');
imagesc([-5.9 20-5.9],[-10 10],imdata);
title('Simulation du système de sustentation magnétique');
hold on;
grid on;


% trace bille
fill(xpos+rbille*cos(cercle),y0*100+rbille*sin(cercle),'b','LineWidth',2,'EdgeColor','white','Tag','bille');

% trace repère CI et ref
plot([-4,4],y0*100*[1,1],'Color',[0 0.4470 0.7410],'LineWidth',2,'LineStyle','--');
plot([-4,4],r*100*[1,1],'Color',[0.8500 0.3250 0.0980],'LineWidth',2,'LineStyle','--');
text(4.5,y0*100,sprintf('$y_0=%.1f cm$',y0*100),'Interpreter','latex','FontSize',14)
text(4.73,r*100,sprintf('$r=%.1f cm$',r*100),'Interpreter','latex','FontSize',14)
% trace temps
text(8,6,sprintf('$t=%.1f s$',t(1)),'Interpreter','latex','FontSize',24,'Tag','timing')


% sous échantillonnage du temps
Te = 0.04;
timing = Te;
index = [1];
while timing<t(end)-Te,
    index = [index find(t>=timing,1)];
    timing = timing + Te;
end

tic
for ii = index
    figure(figNumber)
    tracesysteme(y(ii),rbille,t(ii));
    while toc<Te, end
    tic
end




function tracesysteme(y,rbille,temps)

xpos = 0;
cercle = [0:0.01:2*pi];


graphCourant=findobj('Tag','bille');
if y<0,
    y=0;
end
set(graphCourant,'XData',[xpos+rbille*cos(cercle)],'YData',[y*100+rbille*sin(cercle)]);
graphCourant=findobj('Tag','timing');
set(graphCourant,'String',sprintf('$t=%.1f s$',temps));
drawnow;

end