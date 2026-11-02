function [sys,x0]=anim_coppelia(t,x,u,flag);  % c'est de s-function --> pas besoin de x ni de u

global copsim clientID h_joint
if flag == 2,   %%%%% partie qui tourne en Rtime
	    X = u(1:2);
        q = MGI(X) ;       %%% q = [q1; q2];
        
        for i=1:2
            copsim.simxSetJointTargetPosition(clientID, h_joint(i),q(i), copsim.simx_opmode_streaming); %action set joint pos
        end
            
	sys=[];

elseif flag == 4


% % %%%%%%%%%%%%%%%%%  POUR MODE SYNCHRO %%%%%%%%%%%%%%%%%%%%%
% % configure le mode synchronous
% % copsim.simxSynchronous(clientID,true)
% % 
% % Configure le pas de simulation à dt
% % ATTENTION  pris en compte uniquement si dt=Custom sur VREP
% % copsim.simxSetFloatingParameter(clientID,copsim.sim_floatparam_simulation_time_step,dt,copsim.simx_opmode_oneshot)
% % 
% % démarre la sumulation en mode oneshot_wait (un pas et attend)
% % copsim.simxStartSimulation(clientID,copsim.simx_opmode_oneshot_wait);
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


elseif flag == 0,  %%% c'est l'init : ne tourne qu'une seule fois

	disp('Program started');
    copsim=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
    copsim.simxFinish(-1); % just in case, close all opened connections
    clientID=copsim.simxStart('127.0.0.1',19999,true,true,5000,5);

    if (clientID>-1)
    disp('Connected to remote API server');
    end

     % Now try to retrieve data in a blocking fashion (i.e. a service call):
     %%% recup?rer les ID des articulations dans objs
     [res,objs]=copsim.simxGetObjects(clientID,copsim.sim_handle_all,copsim.simx_opmode_blocking);


      if (res==copsim.simx_return_ok)
            fprintf('Number of objects in the scene: %d\n',length(objs));
        else
            fprintf('Remote API function call returned with error code: %d\n',res);
      end


 % Now retrieve streaming data (i.e. in a non-blocking fashion):

       copsim.simxGetIntegerParameter(clientID,copsim.sim_intparam_mouse_x,copsim.simx_opmode_streaming) ;% Initialize streaming  -- regarder ? quoi ?a sert
       copsim.simxAddStatusbarMessage(clientID,'Hello CoppeliaSim from Sfunction animation!',copsim.simx_opmode_oneshot);

       [r, h_joint(1)]=copsim.simxGetObjectHandle(clientID,'J1', copsim.simx_opmode_blocking);
       [r, h_joint(2)]=copsim.simxGetObjectHandle(clientID,'J2', copsim.simx_opmode_blocking);

	 
	sys=[0 0 0 2 0 0]; %%% definir le vecteur d'entrée : 2 nb d'entrée x et y
	x0=[];

end

