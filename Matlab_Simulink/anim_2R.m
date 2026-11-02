function anim_2R(X, reset)
% ANIM_2R  Animation temps reel d'un robot plan 2R (remplace anim_coppelia).
%
%   anim_2R(X)      X = [x; y] position cartesienne de l'effecteur. Appelle MGI(X) pour
%                   obtenir q = [q1; q2], puis dessine le robot.
%   anim_2R(X,true) ferme la figure et reinitialise.
%
% ------------------------- PARAMETRES DU ROBOT --------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global a1 a2
%% Robot
a1 = 0.467;       % longueur du corps 1 = 0,467 m
a2 = 0.458;       % longueur du corps 2 = 0,458 m
NMAX = 3000;       % nb max de points conserves dans la trace
xe = 0.80528;      % position de l'environnement (Mur de type ressort - voir TP cmd en force)
% ------------------------------------------------------------------------

persistent fig hLink hJoint hEff hTrace hTarget ax

if nargin > 1 && reset
    if ~isempty(fig) && isvalid(fig), close(fig); end
    clear fig hLink hJoint hEff hTrace hTarget ax
    return
end

X = double(X(:));
q = MGI(X);
q = q(:);

% --- creation de la figure au premier appel ---
if isempty(fig) || ~isvalid(fig)
    fig = figure('Name','Robot 2R','NumberTitle','off','Color','w');
    ax  = axes('Parent',fig); hold(ax,'on'); grid(ax,'on'); axis(ax,'equal');
    R = (a1+a2)*1.1;
    axis(ax,[-R R -R R]);
    xlabel(ax,'x [m]'); ylabel(ax,'y [m]');
    title(ax,'Robot 2R plan');
    % limite de l'espace de travail
    th = linspace(0,2*pi,200);
    plot(ax,(a1+a2)*cos(th),(a1+a2)*sin(th),'--','Color',[.7 .7 .7]);
    if abs(a1-a2) > 1e-9
        plot(ax,abs(a1-a2)*cos(th),abs(a1-a2)*sin(th),'--','Color',[.7 .7 .7]);
    end
    plot(ax,[xe xe],[-R R],'-','Color',[0.55 0.35 0.15],'LineWidth',6);
    % cibles (boules 2D) : positions x_d et rayon en metres
    xd_cibles = [0.9 0.0; 0.55 -0.3; 0.85 0.25];   % une cible par ligne [x y]
    rb = 0.02;                                      % rayon des boules [m]
    for i = 1:size(xd_cibles,1)
        rectangle(ax,'Position',[xd_cibles(i,1)-rb, xd_cibles(i,2)-rb, 2*rb, 2*rb], ...
              'Curvature',[1 1],'FaceColor',[0.2 0.75 0.3],'EdgeColor','k','LineWidth',1.5);
    end
    hTrace  = plot(ax,NaN,NaN,'-','Color',[0.2 0.6 1],'LineWidth',1);
    hTarget = plot(ax,NaN,NaN,'rx','MarkerSize',10,'LineWidth',2);
    hLink   = plot(ax,[0 0 0],[0 0 0],'-','Color',[0.1 0.1 0.1],'LineWidth',5);
    hJoint  = plot(ax,[0 0],[0 0],'o','MarkerFaceColor','w', ...
                   'MarkerEdgeColor','k','MarkerSize',9,'LineWidth',2);
    hEff    = plot(ax,NaN,NaN,'o','MarkerFaceColor','r', ...
                   'MarkerEdgeColor','r','MarkerSize',7);
end

% --- point hors espace de travail : on affiche juste la cible ---
%if any(~isfinite(q)) || ~isreal(q)
if numel(q) < 2 || any(~isfinite(q)) || ~isreal(q)
    set(hTarget,'XData',X(1),'YData',X(2));
    title(ax,'Cible hors espace de travail','Color','r');
    drawnow limitrate; return
end
title(ax,'Robot 2R plan','Color','k');

% --- modele geometrique direct pour le dessin ---
P1 = a1*[cos(q(1)); sin(q(1))];
P2 = P1 + a2*[cos(q(1)+q(2)); sin(q(1)+q(2))];

set(hLink,  'XData',[0 P1(1) P2(1)], 'YData',[0 P1(2) P2(2)]);
set(hJoint, 'XData',[0 P1(1)],       'YData',[0 P1(2)]);
set(hEff,   'XData',P2(1),           'YData',P2(2));
set(hTarget,'XData',X(1),            'YData',X(2));

% --- trace de l'effecteur ---
xd = [get(hTrace,'XData') P2(1)];
yd = [get(hTrace,'YData') P2(2)];
if numel(xd) > NMAX, xd = xd(end-NMAX+1:end); yd = yd(end-NMAX+1:end); end
set(hTrace,'XData',xd,'YData',yd);

drawnow limitrate;   % rafraichit sans bloquer la simulation
end
