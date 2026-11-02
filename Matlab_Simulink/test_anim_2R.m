% TEST_ANIM_2R  Verifie l'animation sans Simulink 
% Necessite MGI.m et anim_2R.m (qui definit a1 et a2) dans le dossier courant.
% Espace de travail : couronne de rayon |a1-a2| a a1+a2 = 0.925 m --> comme
% vu en cours de 3A
clear anim_2R
Ts = 0.03;                    % pas d'animation [s]
%%%% Le robot trace un cercle %%%%
T  = 0:Ts:4;                 % 10 s
xc = 0.45; yc = 0.30; r = 0.25;   % cercle entierement atteignable
for k = 1:numel(T)
    X = [xc + r*cos(2*pi*0.3*T(k));
         yc + r*sin(2*pi*0.3*T(k))];
    anim_2R(X);
    pause(Ts);                % cadence temps reel
end
pause(1)

%%%% Le robot va ensuite sur les boules (comme sur le TP avec coppelia %%%%

x_d = [0.9; 0.0];  %%% correspond à boule sur coppelia x_d_boule1 = [0.9; 0.0]
anim_2R(x_d);
pause(1)

x_d = [0.55; -0.3]; %%%% boule du bas
anim_2R(x_d);

pause(1)
x_d = [0.85; 0.25]; %%%% boule du milieu
anim_2R(x_d);