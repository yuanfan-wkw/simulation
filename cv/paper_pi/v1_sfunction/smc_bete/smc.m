function [sys,x0,str,ts,simStateCompliance]=smc(t,x,u,flag)
%选择函数执行
switch flag

  case 0
    [sys,x0,str,ts,simStateCompliance] = mdlInitializeSizes();

  case 1
    sys = [];

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
sizes.NumContStates  = 0;    %设置系统连续状态的数量;控制器一般没有状态
sizes.NumDiscStates  = 0;    %设置系统离散状态的数量;
sizes.NumOutputs     = 1;    %u 
sizes.NumInputs      = 2;    %x1 x2 x3 x1d
sizes.DirFeedthrough = 1;    %设置系统直接通过量的数量，s=ce+de?
sizes.NumSampleTimes = 0;

sys = simsizes(sizes);
x0  = [];    % 系统初始状态  
str = [];       % 保留变量，保持为空,初始时刻x_1=0,x_2=0
ts  = [];    % sample time: [period, offset] if continue system ts=0 

% speicfy that the simState for this s-function is same as the default
simStateCompliance = 'DefaultSimState';
end

% Return the output vector for the S-function
function sys = mdlOutputs(t,x,u)
Pn=4;
J = 0.0002;
lambda = 0.175;

%controler parameter

c=10000;
varepsilon=1000;
k=10000;

sys(1)= (2*J/(3*Pn*lambda))*(c*u(1)+varepsilon*sign(u(2))+k*u(2));
end
