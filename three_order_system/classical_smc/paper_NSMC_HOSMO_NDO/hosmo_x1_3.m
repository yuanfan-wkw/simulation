function [sys,x0,str,ts,simStateCompliance]=hosmo_x1_3(t,x,u,flag)
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
sizes.NumContStates  = 4;    %设置系统连续状态的数量;x1,x2
sizes.NumDiscStates  = 0;    %设置系统离散状态的数量
sizes.NumOutputs     = 4;    %x1 and x2 Observable
sizes.NumInputs      = 1;    %only control input 
sizes.DirFeedthrough = 0;    %设置系统直接通过量的数量，一般为1 x=x[1,0]+0u
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);
x0  = [0,0,0,0];    % 系统初始状态  
str = [];       % 保留变量，保持为空,初始时刻x_1=0,x_2=0
ts  = [0 0];    % sample time: [period, offset] if continue system ts=0 

% speicfy that the simState for this s-function is same as the default
simStateCompliance = 'DefaultSimState';
end

% Compute derivatives for continuous states.
function sys = mdlDerivatives(t,x,u)




v0=-11*abs(x(1)-u(1))^(3/4)*sign(x(1)-u(1))+x(2);

sys(1)=v0;

v1=-15*abs(x(2)-v0)^(2/3)*sign(x(2)-v0)+x(3);

sys(2)=v1;

v2=-30*abs(x(3)-v1)^(1/2)*sign(x(3)-v1)+x(4);

sys(3)=v2;

sys(4)=-50*sign(x(4)-v2);
end


% Return the output vector for the S-function
function sys = mdlOutputs(t,x,u)
sys = [x(1) x(2) x(3) x(4)];
end
