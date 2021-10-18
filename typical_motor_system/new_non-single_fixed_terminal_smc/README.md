# 毕业论文



### 提纲/目录

#### 1绪论

##### 1.1本文背景及研究意义

##### 1.2 国内外的研究现状与发展趋势

###### 1.2.1 永磁同步电机常用控制方法现状

###### 1.2.2 永磁同步电机速度控制策略发展现状

###### 1.2.3 滑模控制在永磁同步电机速度控制策略发展现状

###### 1.2.4 干扰估计在永磁同步电机控制研究和发展

##### 1.3 内容安排

##### 1.4 本文的主要研究内容



#### 2永磁同步电机的数学模型及矢量控制原理

##### 2.1 永磁同步电机分类和原理

##### 2.2 三种坐标系与坐标变换

##### 2.3 矢量控制原理

##### 2.4 永磁同步电机数学模型

##### 2.5 本章小结



#### 3滑模控制原理与滑模控制器设计

##### 3.1 滑模控制基本原理

##### 3.2 滑模控制器设计

##### 3.3 滑模控制性能指标

##### 3.4 基于滑模控制的典型的电机系统

###### 3.4.1 线性滑模控制设计

###### 3.4.2 终端滑模控制设计

###### 3.4.3有限时间双幂次滑模控制设计

##### 3.5 滑模控制存在的问题和改进方法

###### 3.5.1 滑模控制收敛速度

###### 3.5.2 滑模控制器设计奇异性问题

###### 3.5.3 滑模控制抖振问题

###### 3.5.4 滑模控制改进改进验证(稳定性证明和仿真)



#### 4 干扰观测方法

##### 4.1 匹配干扰和不匹配干扰

##### 4.2 干扰观测的原理及其意义

##### 4.3 高阶滑模观测器和非线性干扰观测器原理

###### 4.3.1 HOSMD原理

###### 4.3.2 NDO 原理

##### 4.5 一种新型的观测器的应用

###### 4.5.1 高阶系统

###### 4.5.2 典型的电机系统下干扰估计



#### 5 一种新型有限时间无抖振的滑模控制方法

##### 5.1 滑模面的设计

##### 5.2 趋近律设计

##### 5.3 干扰观测器设计

##### 5.4 永磁同步电机速度环和电流环滑模控制设计

###### 5.4.1 永磁同步电机速度环设计

###### 5.4.2 永磁同步电机电流环设计

##### 5.5 本章小节 



#### 6 仿真验证与结果分析

#### 6.1 仿真平台

##### 6.2 实验验证

##### 6.3 本章小节 



##### 3.4 典型的电机系统

​		系统方程:
$$
J\ddot\theta=u(t)+d(t)\tag{1}
$$

​		其中 $J$ 是旋转矩阵; $\theta(t)$ 代表电机旋转未知; $u(t)$ 代表控制输入; $d(t)$ 代表外部干扰。

​		式(1)更加精确的记为：
$$
\ddot\theta=-f(\theta,t)+hu(t)+d(t)
$$
​		$f(\theta,t)$ is 粘滞阻力，可以通过实验的方法测算。

###### 3.4.1 线性滑模设计

​		经典的滑模控制器，线性滑模控制器:

​		转化为状态空间控制, $\theta=x_1;\dot\theta=x_2$:
$$
\left\{\begin{align}
\dot{x}_1&=x_2\\
\dot{x}_2&=-f(\theta,t)+hu(t)+d(t)
\end{align}\right.
$$

​		注：论文中常用以线性滑模面和等速趋近律设计的滑模控制为经典的滑模控制。

​		假设 $\theta_{d}=\theta_{d}(t),(x_{1d})$ 是期望的电机的转角的位置,假设跟踪误差 $e=\theta -\theta_d=x_1-x_{1d}$, 滑模面设计为 $s=ce+\dot e$.

​		通过计算 $\dot s$ 求的 $u(t)$:
$$
\begin{align}
\dot{s}&=\ddot e+c\dot e\\
&=c(\dot x_1-\dot x_{1d}) +\ddot x_1 -\ddot x_{1d}\\
&=c(x_2-\dot x_{1d})-f(\theta,t)+hu(t)+d(t)-\ddot x_{1d}
\end{align}
$$
​		so $u(t)=u(t)_{eq}+u(t)_{en}$ ,其中 $\delta > 0$
$$
\begin{align}
u(t)_{eq}&=-\frac{1}{h}(c(x_2-\dot{x}_{1d})-f(\theta,t)-\ddot x_{1d})\\
u(t)_{en}&=-\frac{1}{h}(\sup(d(t))+\delta)\operatorname{sign}{s}
\end{align}
$$
​		于是: 
$$
\begin{align}
\dot{s}&=(\sup(d(t))-10-\delta)\operatorname{sign}(s)<=20\operatorname{sign}(s)
\end{align}
$$
​		如果初始状态远离平衡点或者远离滑模面,  收敛时间将很慢。同时等速趋近律缺点在于当状态在平衡点附近速度也是常数, 会造成控制律的抖振。改进方法非常的多，双幂次等提升收敛速度。同时可以结合观测器对干扰进行高精度观测，对干扰进行补偿，于是可以设计较小的$\delta$。

仿真参数 $x_d=\sin( t),c=15,f(\theta,t)=25\dot\theta,h=133,d(t)=10\sin(\pi t)$

等速趋近律;(增加绘制滑模面与轨迹)

​		![track](/Users/wkw/Documents/GitHub/simulation/typical_motor_system/classical_smc/Isokinetic_reach/track.jpg)

![control](/Users/wkw/Documents/GitHub/simulation/typical_motor_system/classical_smc/Isokinetic_reach/control.jpg)

###### 3.4.2 非奇异快速终端滑模控制

为了解决收敛速度问题，首先想到有终端滑模，传统的终端滑模存在非奇异和和收敛速度在原理平衡点时收敛速度慢，于是出现非奇异快速终端，或者双幂次形。将两种结合即存在线性项的双幂次的非奇异快速。

​		用同样的微分方程形式设计趋近律，是一种自然的想法。

​		终端滑模控制terminal SMC 一般形式。本质是一种微分方程。$\alpha,\beta>0$ and $q/p<1$ ,$p,q$ 为奇数
$$
s=\dot{x}+\alpha x+\beta x^{\frac{q}{p}}=0
$$
​		针对本系统设计：
$$
e=\theta -\theta_d=x_1-x_{1d}
$$

$$
\dot e=\dot{x}_1-\dot{x}_{1d}=x_2-\dot x_{1d}
$$
​		等效状态方程
$$
\left\{\begin{align}
\dot{e}_1&=e_2\\
\dot{e}_2&=-f(\theta,t)+hu(t)+d(t)-\ddot x_{1d}
\end{align}\right.
$$
​		当$e_1\rightarrow 0$,有$x_1\rightarrow x_{1d}$。于是终端滑模可以设计为
$$
s=\dot{e}_1+\alpha e_1+\beta e^{\frac{q}{p}}_1=e_2+\alpha e_1+\beta e^{\frac{q}{p}}_1 \tag{2} \label{eq2}
$$
​		然而：

$$
\dot s=\dot e_2+\alpha \dot e_1+(\beta q/p) e^{\frac{q}{p}-1}_1 \tag{3} \label{eq3}
$$
​		(3)会出现负指数项。于是改进$1<p/q<2$

$$
s=e_{1}+\frac{1}{\beta} e_{2}^{\frac{p}{q}}
$$
​		求导得到：没有出现负数幂次：
$$
\dot{s}=e_{2}+\frac{1}{\beta} \frac{p}{q} e_{2}^{\frac{p}{q}-1} \dot{e}_{2}
$$
###### 3.4.4 双幂次滑模控制

双幂次型滑模面也是一种常见形式比如文献Non-singular fixed-time terminal sliding mode control of non-linear systems,
$$
s=e_{2}+\alpha_{1} e_{1}^{\left(m_{1} / n_{1}\right)}+\beta_{1} e_{1}^{\left(p_{1} / q_{1}\right)}
$$
其中:$m_1>n_1,p_1<q_1<2p_1$.
$$
\begin{align}
\dot s&=\dot e_{2}+\alpha_{1} (m_1/n_1)e_{1}^{\left(m_{1} / n_{1}-1\right)}e_2+\beta_{1} (p_1/q_1)e_{1}^{\left(p_{1} / q_{1}-1\right)}e_2\\
&=-f(\theta,t)+hu(t)+d(t)-\ddot x_{1d}+\alpha_{1} (m_1/n_1)e_{1}^{\left(m_{1} / n_{1}-1\right)}e_2+\beta_{1} (p_1/q_1)e_{1}^{\left(p_{1} / q_{1}-1\right)}e_2
\end{align}
$$
同理趋近律设计为：
$$
\dot{s}=-\alpha_{2} s^{\frac{m_{2}}{n_{2}}}-\beta_{2} s^{\frac{p_{2}}{q_{2}}}-\gamma \operatorname{sign}(s)
$$
其中$\gamma =\sup(d(t))+\delta,\delta > 0$

于是控制律为：
$$
u=\frac{1}{h}(-f(\theta,t)-\ddot x_{1d}+\alpha_{1} (m_1/n_1)e_{1}^{\left(m_{1} / n_{1}-1\right)}e_2+\beta_{1} (p_1/q_1)e_{1}^{\left(p_{1} / q_{1}-1\right)}e_2+\alpha_{2} s^{\frac{m_{2}}{n_{2}}}+\beta_{2} s^{\frac{p_{2}}{q_{2}}}+\gamma \operatorname{sign}(s))
$$
仿真结果:

![track](/Users/wkw/Documents/GitHub/simulation/typical_motor_system/classical_smc/double_power_reach/track.jpg)

![control](/Users/wkw/Documents/GitHub/simulation/typical_motor_system/classical_smc/double_power_reach/control.jpg)`



###### 3.4.5 新型滑模控制

根据快速终端滑模设计思想，但是远离平衡点速度收敛速度慢，结合双幂次滑模控制方法，设计双幂次加线性项$\gamma e_1$,$m_1 > n_1,1/2<p1/q1<1$。
$$
s=e_{2}+\alpha_{1} e_{1}^{\left(m_{1} / n_{1}\right)}+\beta_{1} e_{1}^{\left(p_{1} / q_{1}\right)}+\gamma_1 e_1 \tag{4}\label{eq4}
$$
$$
\begin{align}
\dot s&=\dot{e}_2+\alpha_1(m_1/n_2)e^{(m_1/n_1-1)}_1e_2+\beta_1(p_1/q_1)e^{(p_1/q_1-1)}_1e_2+\gamma_1  e_2
\end{align}
$$
​		其中$\beta_1(p_1/q_1)e^{(p_1/q_1-1)}_1e_2$似乎是非奇异项，当$e_1=0,e_2 \neq 0$,但是不会出现这种情况。
$$
\begin{align}
\beta_1(p_1/q_1)e^{(p_1/q_1-1)}_1e_2&=-\beta_1(p_1/q_1)e^{(p_1/q_1-1)}_1(\alpha_{1} e_{1}^{\left(m_{1} / n_{1}\right)}+\beta_{1} e_{1}^{\left(p_{1} / q_{1}\right)}+\gamma_1 e_1)\\
&=-\alpha_1 \beta_1(p_1/q_1)e^{(m_1/n_1+p_1/q_1-1)}_1-\beta^2_1(p_1/q_1)e^{(2p_1/q_1-1)}_1-\beta_1(p_1/q_1)e^{(p_1/q_1)}_1
\end{align}
$$
​	所有不存在奇异现象。

同理具有有限时间的特性。(==给出证明==)有限时间的证明

​		根据上述分析，趋近律设计再利用$\eqref{eq4}$微分方程。不过趋近律不设计奇异性，只需$m_2>n_2,p_2<q_2$
$$
\dot{s}=-\alpha_{2} s^{\frac{m_{2}}{n_{2}}}-\beta_{2} s^{\frac{p_{2}}{q_{2}}}-\gamma_2 s -(\sup(d(t))+\delta)\operatorname{sign}(s)
$$
于是可以设计出相应的$u$,上述方法依次解决传统滑模的问题，但是抖振问题还解决。
$$
\begin{align}
\dot s &=\dot{e}_2+\alpha_1(m_1/n_2)e^{(m_1/n_1-1)}_1e_2+\beta_1(p_1/q_1)e^{(p_1/q_1-1)}_1e_2+\gamma_1  e_2 \\
\dot s &=-f(\theta,t)+hu(t)+d(t)-\ddot x_{1d}+\alpha_1(m_1/n_2)e^{(m_1/n_1-1)}_1e_2+\beta_1(p_1/q_1)e^{(p_1/q_1-1)}_1e_2+\gamma_1  e_2
\end{align}
$$
于是 $u(t)=u(t)_{eq}+u(t)_{en}$
$$
\begin{align}
u(t)_{eq}&=-\frac{1}{h}(-f(\theta,t)-\ddot x_{1d}+\alpha_1(m_1/n_1)e^{(m_1/n_1-1)}_1e_2+\beta_1(p_1/q_1)e^{(p_1/q_1-1)}_1e_2+\gamma_1  e_2 +\alpha_{2} s^{\frac{m_{2}}{n_{2}}}+\beta_{2} s^{\frac{p_{2}}{q_{2}}}+\gamma_2 s)\\
u(t)_{en}&=-\frac{1}{h}(\sup(d(t))+\delta)\operatorname{sign}{s}
\end{align}
$$
仿真参数 $x_d=\sin( t),c=15,f(\theta,t)=25\dot\theta,h=133,d(t)=10\sin(\pi t),m_1=5,n_1=3,p_1=5,q_1=7,m_2=5,n_2=3,p_2=5,q_2=7,$$\alpha_1=\alpha_2=3,\beta_1=\beta_2=3，\gamma_1=\gamma_2=3$

仿真结果

![track](/Users/wkw/Documents/GitHub/simulation/typical_motor_system/new_non-single_fixed_terminal_smc/track.jpg)

![control](/Users/wkw/Documents/GitHub/simulation/typical_motor_system/new_non-single_fixed_terminal_smc/control.jpg)



#### 4.干扰观测方法

要抑制抖振或者消除是有必要的，最直接的方法的将符号函数替换为连续的函数会造成收敛精度。对于高阶系统或者存在不匹配的系统这种情况更加明显。









#### 5 一种新型有限时间无抖振的滑模控制方法

##### 5.1 新型滑模面设计

##### 5.2 趋近律设计

##### 5.3 有限时间证明和稳定性证明

##### 5.4 PMSM 矢量控制速度控制

###### 5.4.1  PI控制 和传统滑模控制原理及缺点

pi控制的效果：

![mot](/Users/wkw/Desktop/mot.jpg)

![untitled](/Users/wkw/Desktop/untitled.jpg)

3 采用新设计的滑模控制的优点仿真













