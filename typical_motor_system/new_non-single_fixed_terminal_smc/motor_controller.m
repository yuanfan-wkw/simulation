function [sys,x0,str,ts,simStateCompliance]=motor_controller(t,x,u,flag)
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
sizes.NumDiscStates  = 0;    %设置系统离散状态的数量ß;
sizes.NumOutputs     = 1;    %u 
sizes.NumInputs      = 3;    %x1 x2 x1d
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
x1d = u(1);%10*sin(pi*t)
dx1d=cos(t);%控制器中需要要微分器Differentiator，这里手动微分。
ddx1d=-sin(t);
x1=u(2);
x2=u(3);

%silding surface 
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

gama1=3;
gama2=3;

b1=3;
b2=3;

h=133;
f=25*x2;

e1=x1-x1d;
e2=x2-dx1d;

s=e2+a1*sign(e1)*abs(e1)^(m1/n1)+b1*sign(e1)*abs(e1)^(p1/q1)+gama1*e1;


sup=10;

delta=1;


sys(1)=-(1/h)*(-f-ddx1d+a1*(m1/n1)*sign(e1)*abs(e1)^(m1/n1-1)*e2+b1*(p1/q1)*sign(e1)*abs(e1)^(p1/q1-1)*e2+gama1*e2+a2*sign(s)*abs(s)^(m2/n2)+b2*sign(s)*abs(s)^(p2/q2)+gama2*s+(sup+delta)*2/pi*atan(30*s));
end
