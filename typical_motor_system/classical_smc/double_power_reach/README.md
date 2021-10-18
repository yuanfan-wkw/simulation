### a typical motor system

##### 1.system equation:

$$
J\ddot\theta=u(t)+d(t)
$$

​		Where $J$ is rotary inertia; $\theta(t)$ represents position instruction; $u(t)$ respresents coantrol input; $d(t)$

represents external disturbance.

​		More precise, it can describe as:
$$
\ddot\theta=-f(\theta,t)+hu(t)+d(t)
$$
​		$f(\theta,t)$ is 粘滞阻力，或者时变变量。

​		

​		Classical silding model control(SMC) can be design as follow:

​		State space equation, $\theta=x_1;\dot\theta=x_2$:
$$
\left\{\begin{align}
\dot{x}_1&=x_2\\
\dot{x}_2&=-f(\theta,t)+hu(t)+d(t)
\end{align}\right.
$$

##### 2. classic sliding model controler design:

​		注：论文中常用以等速趋近律设计的滑模控制器为classic 

​		Assuming that $\theta_{d},(x_{1d})$is ideal position,so define  track error $e=\theta -\theta_d=x_1-x_{1d}$, sliding model surface $s=ce+\dot e$.

​		caculate $\dot s$ to design $u(t)$:
$$
\begin{align}
\dot{s}&=\ddot e+c\dot e\\
&=c(\dot x_1-\dot x_{1d}) +\ddot x_1 -\ddot x_{1d}\\
&=c(x_2-\dot x_{1d})-f(\theta,t)+hu(t)+d(t)-\ddot x_{1d}
\end{align}
$$
​		so $u(t)=u(t)_{eq}+u(t)_{en}$ ,where $\delta > 0$
$$
\begin{align}
u(t)_{eq}&=-\frac{1}{h}(c(x_2-\dot{x}_{1d})-f(\theta,t)-\ddot x_{1d}\\
u(t)_{en}&=-\frac{1}{h}(\sup(d(t))+\delta)\operatorname{sign}{s}
\end{align}
$$
​		so: 
$$
\begin{align}
\dot{s}&=(\sup(d(t))-10-\delta)\operatorname{sign}(s)<=20\operatorname{sign}(s)
\end{align}
$$
​		if initial state is far from silding model,  收敛时间很慢。Therefore, the isokinetic reach term εsgn(s) is added to ensure when s is close to 0, the reaching velocity is ε instead of 0.收敛速度比较慢。改进方法非常的多，双幂次等...。在此之上结合观测器。

##### 3.simlation $x_d=\sin( t),c=15$

###### 3.1 等速趋近律;(增加绘制滑模面与轨迹)

​		1.Here $f(\theta,t)=25\dot\theta$ and $h$=133 are set as known condition;$d(t)$ is set as $10\sin(\pi t)$.



