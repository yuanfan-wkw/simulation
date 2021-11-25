function [sys,x0,str,ts,simStateCompliance]=ndo(t,x,u,flag)
%选择函数执行
switch flag

  case 0
    [sys,x0,str,ts,simStateCompliance] = mdlInitializeSizes();

  case 1
    sys = mdlDerivatives(t,x,u);

  case 2
    %sys =mdlUpdate(t,x,u);
    sys=[];

  case 3
    sys = mdlOutputs(t,x,u);

  case 4
    %sys=mdlGetTimeOfNextVarHit(t,x,u);
    sys=[];
  case 9
    %sys=mdlTerminate(t,x,u);
    sys=[];

  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end
end


function [sys,x0,str,ts,simStateCompliance] = mdlInitializeSizes()

sizes = simsizes;
sizes.NumContStates  = 1;    %设置系统连续状态的数量;$\hat{d}_3$
sizes.NumDiscStates  = 0;    %设置系统离散状态的数量
sizes.NumOutputs     = 1;    %x1 and x2 Observable
sizes.NumInputs      = 5;    %only control input 
sizes.DirFeedthrough = 0;    %设置系统直接通过量的数量，一般为1 x=x[1,0]+0u
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);
x0  = 0;    % 系统初始状态  
str = [];       % 保留变量，保持为空,初始时刻x_1=0,x_2=0
ts  = [0 0];    % sample time: [period, offset] if continue system ts=0 

% speicfy that the simState for this s-function is same as the default
simStateCompliance = 'DefaultSimState';
end

% Compute derivatives for continuous states.
function sys = mdlDerivatives(t,x,u)
eta=2;
F=0.01*u(2)*exp(-0.5*u(1));
sys(1)=-eta*x(1)+eta*(u(4)-u(1)*u(2)*u(3)-u(1)*sin(u(1))-5*u(5)-F);
end


% Return the output vector for the S-function
function sys = mdlOutputs(t,x,u)
sys = x(1);
end
