function [sys,x0,str,ts] = pmsm_paper(t,x,u,flag)

switch flag

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0
    [sys,x0,str,ts]=mdlInitializeSizes;

  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  case 1
    sys=mdlDerivatives(t,x,u);

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3
    sys=mdlOutputs(t,x,u);

  case {2,4,9}
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
function [sys,x0,str,ts]=mdlInitializeSizes

sizes = simsizes;

sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 4;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

% initialize the initial conditions
x0  = [0;0;0];
% str is always an empty matrix
str = [];
% initialize the array of sample times
ts  = [0 0];
simStateCompliance = 'UnknownSimState';
% end mdlInitializeSizes
%===================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%===================================================================
function sys=mdlDerivatives(t,x,u)
R = 1.55;
Ld = 6.71e-3;
Lq =6.71e-3;
Pn = 4;
lambda = 0.175;
J = 0.0002;
B=0.0003;
%״̬����u_d
%
%
sys(1)=(1/Ld)*u(1)-(R/Ld)*x(1)+(Lq/Ld)*Pn*x(2)*x(3);
                          %��Ӧ΢�ַ��̣�1-27��
sys(2)=(1/Lq)*u(2)-(R/Lq)*x(2)-(Ld/Lq)*Pn*x(3)*x(2)-(lambda*Pn/Lq)*x(3);
                          %��Ӧ΢�ַ��̣�1-27��
sys(3)=(1/J)*(1.5*Pn*(lambda*x(2)+(Ld-Lq)*x(2)*x(3))-B*x(3)-u(3));
                          %��Ӧ΢�ַ��̣�1-28��

% end mdlDerivatives
%=====================================================================
% mdlOutputs
% Return the block outputs.
%=====================================================================
function sys=mdlOutputs(t,x,u)
%R = 1.55;
Ld = 6.71e-3;
Lq =6.71e-3;
Pn = 4;
Phi = 0.175;

Te=1.5*Pn*(Phi*x(2)+(Ld-Lq)*x(2)*x(3));
sys(1)=x(1);      
sys(2)=x(2);
sys(3)=x(3);
sys(4)=Te;
% end mdlOutputs