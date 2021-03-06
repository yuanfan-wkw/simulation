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
sizes.NumDiscStates  = 0;    %设置系统离散状态的数量;
sizes.NumOutputs     = 1;    %u 
sizes.NumInputs      = 4;    %x1 x2 x3 x1d
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
%here x can be s0 s1;for easy

%x1d=sin(t)

x1d=0.5*(sin(t)+sin(0.5*t));

dx1d=0.5*(cos(t)+0.5*cos(0.5*t));

ddx1d=0.5*(-sin(t)-0.25*sin(0.5*t));

dddx1d=0.5*(-cos(t)-0.125*cos(0.5*t));

d1=0.5*sin(2*t)+sin(t);

dd1=cos(2*t)+cos(t);

d2=t*exp(-0.5*t);

c0=1;

c1=1;



s1=(u(4)+d2+dd1-ddx1d)+(c0+c1)*(u(3)+d1-dx1d)+c0*c1*(u(2)-x1d);



sys(1)=-1/5*(u(2)*u(3)*u(4)+u(2)*sin(u(2))-dddx1d+(c0+c1)*(u(4)-ddx1d)+c0*c1*(u(3)-dx1d)+((0.8+1.5+1)+(c0+c1)*(2*exp(-1)+2)+c0*c1*1.5)*sign(s1));
end
