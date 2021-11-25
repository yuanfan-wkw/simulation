function [sys,x0,str,ts] = dq_abc(t,x,u,flag)

switch flag

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  %case 0
   % [sys,x0,str,ts]=mdlInitializeSizes;

  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
 

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3
    sys=mdlOutputs(t,x,u);

  case {0,1,2,4,9}
    sys=[];

  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end

%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%

% end mdlInitializeSizes
%===================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%===================================================================

%=====================================================================
% mdlOutputs
% Return the block outputs.
%=====================================================================
function sys=mdlOutputs(t,x,u)

%a
sys(1)=3;%u(1)*cos(u(3))-u(2)*sin(u(3));
%b
sys(2)=2;%u(1)*cos(u(3)-2/3*pi)-u(2)*sin(u(3)-2/3*pi);
%c
sys(3)=1;%u(1)*cos(u(3)+2/3*pi)-u(2)*sin(u(3)+2/3*pi);

% end mdlOutputs