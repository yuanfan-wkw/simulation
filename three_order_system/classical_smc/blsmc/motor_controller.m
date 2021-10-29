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
sizes.NumInputs      = 4;    %x1d x1 x2 x3
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

dx1d=cos(t);%控制器中需要要微分器Differentiator，这里手动微分。
ddx1d=-sin(t);
dddx1d=-cos(t);



c0=2;
c1=2;

d1=0.5*sin(2*t)+sin(t);
dd1=cos(2*t)+cos(t);
d2=t*exp(-0.5*t);

s1=(u(4)+d2+dd1-ddx1d+(c0+c1)*(u(3)+d1-u(1))+c0*c1(u(2)-u(2)));


sys(1)=-(1/5)*(u(2)*u(3)*u(4)+u(2)*sin(u(2))+0.01*exp(-0.5*u(2))-dddx1d+(c0+c1)*(u(4)-ddx1d)+c0*c1*(x2-dx1d)-(0.8+exp(-2)+3+(c0+c1)*(2*exp(-1)+2)+c0*c1+1)*sign(s1));
end
