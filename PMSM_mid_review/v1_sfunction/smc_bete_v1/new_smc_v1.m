function [sys,x0,str,ts,simStateCompliance]=new_smc_v1(t,x,u,flag)
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
sizes.NumInputs      = 5;    %x1 x1d hatd
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
%input paprameter
x1=u(1);
x2=u(2);
x1d=u(3);
dx1d=u(4);
hatd=u(5);

ddx1d=0;


%motor parameter


%controler parameter
ki=0.06;
kp=0.2;

m1=5;
n1=3;
p1=5;
q1=7;

m2=5;
n2=3;
p2=5;
q2=7;

a1=3;
a2=3;

gamma1=3;
gamma2=3;

b1=3;
b2=3;
% control parameter
delta=1;

e1=x1-x1d;

e2=x2-dx1d;

s=e2+a1*sign(e1)*abs(e1)^(m1/n1)+b1*sign(e1)*abs(e1)^(p1/q1)+gamma1*e1;

out=-(-ki/kp*x2+hatd-ddx1d+a1*(m1/n1)*sign(e1)*abs(e1)^(m1/n1-1)*e2+b1*(p1/q1)*sign(e1)*abs(e1)^(p1/q1-1)*e2+gamma1*e2+a2*sign(s)*abs(s)^(m2/n2)+b2*sign(s)*abs(s)^(p2/q2)+gamma2*s+1*s+delta*2/pi*atan(30*s));

sys(1)= out;
end
