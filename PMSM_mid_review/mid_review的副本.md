 ###  一、     研究工作情况和已完成的研究内容  

根据开题报告主要研究内容和技术路线，从以下三个方面阐述研究工作情况和已完成的研究内容：  

永磁同步电机（PMSM）数学建模。 

新型滑模控制器设计。  

PMSM转速控制控制系统设计。  

以下对三个方面进行详细描述： 

####  1.PMSM数学建模  

永磁同步电机伺服系统是一个非线性、时变的复杂系统，存在不可避免的、未测量的干扰以及参数的变化。然而在多数研究和教材往往没有考虑不可避免的、未测量的干扰以及参数的变化。通常假定磁路是不饱和的、滞后的和涡流损耗可以忽略，磁场分布为正弦空间等，在此基础建立了基于矢量控制精确的数学模型：  
$$
\begin{equation*}
    		\left\{
    		\begin{aligned}
				v_{d}&=R_{s} i_{d}+L_{d} p i_{d}-\omega_{r} L_{q} i_{q} \\
			v_{q}&=R_{s} i_{q}+L_{q} p i_{q}+\omega_{r} L_{d} i_{d}+\omega_{r} \lambda_{m}\\
			\dot{\omega}_{m}&=\frac{T_e}{J}-\frac{B}{J}\omega_{m}-\frac{T_{L}}{J} 
			\end{aligned}
			\right.
   		\end{equation*}
$$
其中电磁转矩$T_{e}=\frac{3}{2} P\left[\lambda_{m}+\left(L_{d}-L_{q}\right) i_{d}\right] i_{q}$。$v_d,v_q$分别是定子电压的$d-q$轴分量；$i_d,i_q$分别是定子电流的$d-q$轴分量；$R_S$是定子的电阻；$\omega_r$是电角速度；$L_d,L_q$分别是$d-q $轴电感分量；$\lambda_m$代表永磁体磁链。$p$微分算子，$P$表示电机级数；$T_L$是电磁转矩，$B$是粘滞系数,$J$是转动惯量。$\omega_m,\omega_r$分别表示机械角速度，电角速度。

方程中参数确定，并不能体现PMSM存在不可避免的、未测量的干扰以及参数的变化。因此在此基础上建立更为普适的PMSM的电压方程和机械方程：

其中电压方程，为了分析简单不考虑定子电阻，$d-q$轴电感的不确定性，扰动。
$$
\begin{equation*}
    		\left\{
    		\begin{aligned}
			\frac{d i_{d}}{d t}&=-\frac{R_s}{L_{d}} i_{d}+\frac{L_{q}}{L_{d}} \omega_{r} i_{q}+\frac{1}{L_{d}} v_{d} \\
			\frac{d i_{q}}{d t}&=-\frac{R_s}{L_{q}} i_{q}-\frac{L_{d}}{L_{q}} \omega_{r} i_{d}-\frac{\omega_{r}}{L_{q}} \lambda_{m}+\frac{1}{L_{q}} v_{q}\\
			\end{aligned}
			\right.
   		\end{equation*}
$$
机械方程，考虑永磁体磁链$\lambda_m$会受温度影响；转子和负载在高速情况下会发生微小的形变，同时根据转动惯量定义可知转动惯量是不确定的。粘滞系数是一个复杂的变量受到温度，材料等影响。

实际$\lambda_m,J,B$需要考虑参数扰动，参数扰动分别定义为$\Delta \lambda_{m},\Delta J,\Delta B$
$$
\left\{\begin{array}{l}
\lambda_{mo}=\lambda_{m}+\Delta \lambda_{m} \\
J_{{o}}=J+\Delta J \\
B_{{o}}=B+\Delta B
\end{array}\right.
$$
于是机械方程：
$$
\begin{align}
\dot{\omega}_{m}&=\frac{T_e}{J}-\frac{B}{J}\omega_{m}-\frac{T_{L}}{J}\\
&=\frac{3P\left[\lambda_{m}+\left(L_{d}-L_{q}\right) i_{d}\right] i_{q}}{2J} -\frac{B}{J}\omega_{m}-\frac{T_{L}}{J}\\
\end{align}
$$
考虑扰动则：
$$
\begin{align}
\dot{\omega}_{m}&=\frac{T_e}{J}-\frac{B}{J}\omega_{m}-\frac{T_{L}}{J}\\
&=\frac{3P\left[\lambda_{mo}+\left(L_{d}-L_{q}\right) i_{d}\right] i_{q}}{2J_o} -\frac{B_o}{J_o}\omega_{m}-\frac{T_{L}}{J_o}\\
&=\frac{3P\left[\lambda_{m}+\Delta \lambda_{m}+\left(L_{d}-L_{q}\right) i_{d}\right] i_{q}}{2(J+\Delta J)} -\frac{B+\Delta B}{J+\Delta J}\omega_{m}-\frac{T_{L}}{J+\Delta J}\\
\end{align}
$$
为了简化分析，考虑表贴式PMSM,则有$L_d=L_q=L$,则有：
$$
\begin{align}
\dot{\omega}_{m}=\frac{3P\left(\lambda_{m}+\Delta \lambda_{m}\right) i_{q}}{2(J+\Delta J)} -\frac{B+\Delta B}{J+\Delta J}\omega_{m}-\frac{T_{L}}{J+\Delta J}\\
\end{align}
$$
综上所述：对于对于表贴式永磁同步电机状态方程可以表示为：
$$
\begin{equation*}
    		\left\{
    		\begin{aligned}
			\frac{\mathrm{d} i_{d}}{\mathrm{d} t}&=-\frac{R_s}{L_{d}} i_{d}+\frac{L_{q}}{L_{d}} \omega_{r} i_{q}+\frac{1}{L_{d}} v_{d} \\
			\frac{\mathrm{d} i_{q}}{\mathrm{d} t}&=-\frac{R_s}{L_{q}} i_{q}-\frac{L_{d}}{L_{q}} \omega_{r} i_{d}-\frac{\omega_{r}}{L_{q}} \lambda_{m}+\frac{1}{L_{q}} v_{q}\\
			\frac{\mathrm{d} \omega_m}{\mathrm{d} t}&=\frac{3P\left(\lambda_{m}+\Delta \lambda_{m}\right) i_{q}}{2(J+\Delta J)} -\frac{B+\Delta B}{J+\Delta J}\omega_{m}-\frac{T_{L}}{J+\Delta J}\\
			\end{aligned}
			\right.
   		\end{equation*}
$$

#### 2.新型滑模控制器设计

新型滑模控制主要分为三大部分，分别为新型滑模面设计，新型趋近律设计，集中扰动观测器设计。在设计过程会涉及稳定性证明，与传统方案的对比。

为了验证控制算法的有效性，首先以简单典型的电机系统作为被控对象。

系统方程:
$$
J\ddot\theta=u(t)+d(t)
$$
其中 $J$ 是旋转矩阵; $\theta(t)$ 代表电机旋转未知; $u(t)$ 代表控制输入; $d(t)$ 代表外部干扰。考虑粘滞阻力。
$$
\ddot\theta=-f(\theta,t)+hu(t)+d(t)
$$
$f(\theta,t)$ 是粘滞阻力，干扰$d(t)$有界限。

转化为状态空间控制, $\theta=x_1;\dot\theta=x_2$:
$$
\left\{\begin{align}
\dot{x}_1&=x_2\\
\dot{x}_2&=-f(x_1,t)+hu(t)+d(t)
\end{align}\right.
$$

针对本系统设计：
$$
e=\theta -\theta_d=x_1-x_{1d}
$$

$$
\dot e=\dot{x}_1-\dot{x}_{1d}=x_2-\dot x_{1d}
$$

​		误差状态方程
$$
\left\{\begin{align}
\dot{e}_1&=e_2\\
\dot{e}_2&=-f(x_1,t)+hu(t)+d(t)-\ddot x_{1d}
\end{align}\right.
$$
当$e_1\rightarrow 0$,有$x_1\rightarrow x_{1d}$。

##### 2.1 新型滑模面设计

滑动模式控制方法提高永磁同步电动机系统抗干扰性和鲁棒性的有效方法。然而有的文献使用传统的线性滑动面。注：论文中常用以线性滑模面和等速趋近律设计的滑模控制为经典的滑模控制。

假设 $\theta_{d}=\theta_{d}(t),(x_{1d})$ 是期望的电机的转角的位置,假设跟踪误差 $e=\theta -\theta_d=x_1-x_{1d}$, 滑模面设计为 $s=ce+\dot e$.

结合等速趋近率可以得到控制输入：
$$
u(t)=-\frac{1}{h}(c(x_2-\dot{x}_{1d})-f(\theta,t)-\ddot x_{1d}+\sup(d(t))+\delta)
$$
其中$\mathrm{sup}{(d(t))}$表示$d(t)$的上确界，在理论上上确界往往是未知的，但是通常假设有界，往往假设$|d(t)|\leqslant l$。为了分析和验证简单用$|d(t)|$的上确界代替上界。

如果初始状态远离平衡点或者远离滑模面,  收敛时间将很慢。同时等速趋近律缺点在于当状态在平衡点附近速度也是常数, 会造成控制律的抖振。改进方法非常的多，双幂次等提升收敛速度。同时可以结合观测器对干扰进行高精度观测，对干扰进行补偿，于是可以设计较小的$\delta$。

受到双幂次，终端滑模，快速终端滑模启发，设计一种新型滑模面。即快速双幂次滑模面。根据快速终端滑模设计思想，但是远离平衡点速度收敛速度慢，结合双幂次滑模控制方法，设计双幂次加线性项$\gamma e_1$,$m_1 > n_1,1/2<p1/q1<1$。
$$
s=e_{2}+\alpha_{1} e_{1}^{\left(m_{1} / n_{1}\right)}+\beta_{1} e_{1}^{\left(p_{1} / q_{1}\right)}+\gamma_1 e_1
$$
创新点分为三点：

1.相对传统终端滑模增加了非线性项$e_{1}^{\left(m_{1} / n_{1}\right)}$,提升状态远离平衡点时的收敛速率。

2.相对传统终端滑模避免奇异性的特点。

3.相对传统的双幂次有更快的收敛速率。

##### 2.2 新型趋近律设计

受到新型滑模面设计启发，设计新型趋近律。相对传统的等速趋近律，指数趋近律等有更快的收敛速率，使得不在滑模面的状态变量快速趋近滑模面。

新型趋近律定义为：
$$
\dot{s}=-\alpha_{2} s^{\frac{m_{2}}{n_{2}}}-\beta_{2} s^{\frac{p_{2}}{q_{2}}}-\gamma_2 s -(\sup(d(t))+\delta)\operatorname{sign}(s)
$$
趋近律不用考虑奇异性，只需$m_2>n_2,p_2<q_2$。

控制输入：$u(t)=u(t)_{eq}+u(t)_{en}$

其中：
$$
\begin{align}
u(t)_{eq}&=-\frac{1}{h}(-f(\theta,t)-\ddot x_{1d}+\alpha_1(m_1/n_1)e^{(m_1/n_1-1)}_1e_2+\beta_1(p_1/q_1)e^{(p_1/q_1-1)}_1e_2+\gamma_1  e_2 +\alpha_{2} s^{\frac{m_{2}}{n_{2}}}+\beta_{2} s^{\frac{p_{2}}{q_{2}}}+\gamma_2 s)\\
u(t)_{en}&=-\frac{1}{h}(\sup(d(t))+\delta)\operatorname{sign}{s}
\end{align}
$$
其中$\beta_1(p_1/q_1)e^{(p_1/q_1-1)}_1e_2$似乎是非奇异项，当$e_1=0,e_2 \neq 0$时，该项数值为无穷大，但是不会出现这种情况，证明如下：
$$
\begin{align}
\beta_1(p_1/q_1)e^{(p_1/q_1-1)}_1e_2&=-\beta_1(p_1/q_1)e^{(p_1/q_1-1)}_1(\alpha_{1} e_{1}^{\left(m_{1} / n_{1}\right)}+\beta_{1} e_{1}^{\left(p_{1} / q_{1}\right)}+\gamma_1 e_1)\\
&=-\alpha_1 \beta_1(p_1/q_1)e^{(m_1/n_1+p_1/q_1-1)}_1-\beta^2_1(p_1/q_1)e^{(2p_1/q_1-1)}_1-\beta_1(p_1/q_1)e^{(p_1/q_1)}_1
\end{align}
$$
指数都不为负数，所以不存在奇异现象。

为了控制输入连续，用函数$\mathrm{sigm}()=\frac{2}{\pi}\arctan()$代替符号函数$\mathrm{sign()}$。

仿真对比：

略。

##### 2.3 集中扰动观测器设计

滑模控制一个显而易见的缺点就是滑模面附近频繁的切换和不连续控制律引起的抖振现象。针对抖振的削弱或消除问题，研究了不同的方法。一种方法是用连续函数代替符号函数，以减小抖振，也就是上述用函数$\mathrm{sigm}()=\frac{2}{\pi}\arctan()$代替符号函数$\mathrm{sign()}$。这种方法简单已实现，但是在某种程度上牺牲了抗干扰性能。于是考虑一种集中扰动观测器估计扰动，对这些扰动进行前馈补偿后，可以选择较小的滑模控制器切换增益，以减小抖振。再用连续函数代替符号函数，这样可以弥补牺牲了抗干扰性能。这里简单描述控制器，观测器的设计方法，不对细节进行证明。

研究集中干扰观测器，考虑一种更加普适的非线性仿射系统：
$$
\begin{equation}
\left\{
	\begin{aligned}
	\dot{x}_i&=f_i(\boldsymbol{x}_i)+g_i(\boldsymbol{x}_i)x_{i+1}+d_i(t),i=1,2,\cdots,n-1 \\
	\dot{x}_n&=f_n(\boldsymbol{x}_n)+g_n(\boldsymbol{x}_n)u+d_n(t)\\
	y&=x_1
\end{aligned}
\right.
\label{eq1_system}
\end{equation}
$$
其中：$\boldsymbol{x_i}=[x_1(t),x_2(t)\cdots x_i(t)]^{\mathsf{T}} \in \mathbb{R}^{n}$代表状态向量；$x_i\in \mathbb{R},i=1,2,\cdots,n-1 $为可测系统状态变量；$u\in \mathbb{R},y\in \mathbb{R}$分别代表系统输入和输出；$f_i()$和$g_i():\mathbb{R}^{n} \mapsto \mathbb{R}$表示已知的$n-i+1$阶可微的非线性向量函数；$d_i(): \mathbb{R}^{+} \mapsto \mathbb{R}$表示干扰项。

取$n=2$；上述方程变为：
$$
\begin{equation}
\left\{
	\begin{aligned}
	\dot{x}_1&=f_1(\boldsymbol{x}_1)+g_i(\boldsymbol{x}_1)x_{2}+d_1(t)\\
	\dot{x}_2&=f_2(\boldsymbol{x}_2)+g_n(\boldsymbol{x}_n)u+d_2(t)\\
	y&=x_1
\end{aligned}
\right.

\end{equation}
$$
取$f_1(\boldsymbol{x}_1)=0,g_i(\boldsymbol{x}_1)=1,d_1(t)=0,f_2(\boldsymbol{x}_2)=f(x_1,t),g_n(\boldsymbol{x}_n)=h,d_2(t)=d(t)$，方程变为简单典型的电机系统。于是这类方程具有一般性，普适性。

控制器设计

系统控制目标使得状态$x_1$收敛到$x_{1d}$，$x_{1d}$的$n$阶导数$x_{1d}^{(n)}$存在。设跟踪误差为：
$$
\begin{equation}
	e=x_1-x_{1d}
\end{equation}
$$
$n$阶系统需要设计$n-1$层嵌套线性滑模面(nested silding mode surface,NSMS)。依次是：
$$
\begin{equation}
\left\{
\begin{aligned}
		s_0&=\dot{e}+c_0e\\
		s_1&=\dot{s}_0+c_1s_0\\
		&\vdots\\ 
		s_{n-2}&=\dot{s}_{n-3}+c_{n-2}s_{n-3}
\end{aligned}
\right.
\end{equation}
$$
其中$c_{i} \in  \mathbb{R}^{+},i =1,2,\cdots,n-2)$为待设计参数。
滑模面$s_{n-2}$关于时间的微分$\dot{s}_{n-2}$：
$$
\begin{equation}
	\dot{s}_{n-2}=\left(\prod \limits_{i=1}^{n}g_i\right)u+{\Theta}_{n-2}+{\Upsilon}_{n-2}
\end{equation}
$$
其中${\Theta}_{n-2}$为已知确定函数，${\Upsilon}_{n-2}$含有干扰的有界多项式，定义为集中干扰项。

于是嵌套滑模控制(nested silding mode control,NSMC)控制律$u$：
$$
\begin{equation}
	u=\left(\prod \limits_{i=1}^{n}g_i\right)^{-1}\left(-{\Theta}_{n-2}-{{\chi}_{n-2}\operatorname{sign}(s)}\right)
	\label{eq31_u}
\end{equation}
$$
其中$\chi_{n-2}\in  \mathbb{R}^{+}$，且$  \chi_{n-2}\geqslant {\Gamma}_{n-2}$

由于上界存在但未知，所以需要设计较大的符号函数增益，但是会造成较 大的抖振现象。于是考虑使用干扰观测器获取干扰的估计值减少控制器抖振。
$$
\begin{equation}
	u=\left(\prod \limits_{i=1}^{n}g_i\right)^{-1}\left(-{\Theta}_{n-2}-\hat{{\Upsilon}}_{n-2}-
	{\rho}
	\operatorname{sigm}(s)-k_1s_{n-2}\right),k_1\in  \mathbb{R}^{+}
	\label{eq55_u_modify}
\end{equation}
$$
其中$\hat{{\Upsilon}}_{n-2}$是集中干扰项${\Upsilon}_{n-2}$的观测值，$\rho$表示$\hat{{\Upsilon}}_{n-2}$的观测误差。

流程图

仿真

。

PMSM转速控制控制系统设计。

标准模型
$$
\begin{align}
\dot{\omega}_{m}&=\frac{3P\lambda_{m} i_{q}}{2J} -\frac{B}{J}\omega_{m}-\frac{T_{L}}{J}\\
&=\chi i_q-\eta\omega_{m}-\gamma T_{L}
\end{align}
$$
其中$\chi=\frac{3P\lambda_{m} }{2J},\eta=\frac{B}{J},\gamma=\frac{1}{J}$。

加入扰动
$$
\begin{align}
\dot{\omega}_{m}&=\frac{3P\left(\lambda_{m}+\Delta \lambda_{m}\right) i_{q}}{2(J+\Delta J)} -\frac{B+\Delta B}{J+\Delta J}\omega_{m}-\frac{T_{L}}{J+\Delta J}\\
&=(\chi+\Delta \chi) i_q-(\eta+\Delta \eta)\omega_{m}-(\gamma+\Delta\gamma) T_{L}\\
&=\chi i_q + a(t)
\end{align}
$$
其中：
$$
\begin{align}
\Delta \chi=\frac{3P\left(\lambda_{m}+\Delta \lambda_{m}\right) i_{q}}{2(J+\Delta J)}-\frac{3P\lambda_{m} }{2J}
\end{align}
$$

$$
\Delta \eta =\frac{B+\Delta B}{J+\Delta J}-\frac{B}{J}
$$

$$
\Delta \gamma=\frac{1}{J+\Delta J}-\frac{1}{J}
$$

$$
a(t)=\Delta \chi i_q-(\eta+\Delta \eta)\omega_{m}-(\gamma+\Delta\gamma) T_{L}
$$

这种近似降低了闭环永磁同步电机系统的性能。接下来，我们尝试有一个更精确的模型参考正交轴电流和速度输出。

上述一阶系统近似表示为：
$$
\dot{\omega}_m=\chi i_{q}+a(t)
$$

$$
s \Omega(s)=\chi I_{q}(s)+A(s)
$$

考虑电流环，电流环控制方程PI控制器
$$
\frac{V_{q}(s)}{I_{q}^{*}(s)-I_{q}(s)}=k_{p}+\frac{k_{i}}{s}
$$
于是
$$
I_{q}(s)=I_{q}^{*}(s)-\frac{V_{q}(s)}{k_{p}+k_{i} / s}
$$

$$
\begin{align}
s \Omega(s)&=\chi I_{q}(s)+A(s)\\
&=\chi (I_{q}^{*}(s)-\frac{V_{q}(s)}{k_{p}+k_{i} / s})+A(s)
\end{align}
$$

两边乘以$s+\frac{k_{i}}{k_{p}}$
$$
\begin{aligned}
\left(s^{2}+\frac{k_{i}}{k_{p}} s\right) \Omega(s)=& \chi\left(s+\frac{k_{i}}{k_{p}}\right) I_{q}^{*}(s)-\frac{\chi}{k_{p}} s V_{q}(s) \\
&+\left(s+\frac{k_{i}}{k_{p}}\right) A(s)
\end{aligned}
$$
为了设计简单，定义：
$$
U(s)=\chi \left(s+\frac{k_{i}}{k_{p}}\right) I_{q}^{*}(s)
$$
则有：
$$
\left(s^{2}+\frac{k_{i}}{k_{p}} s\right) \Omega(s)=U(s)-\frac{\chi}{k_{p}} s V_{q}(s)+\left(s+\frac{k_{i}}{k_{p}}\right) A(s)
$$
拉普拉斯反变换：
$$
\ddot{\omega}=-\frac{k_{i}}{k_{p}} \dot{\omega}+d(t)+u
$$
其中：
$$
d(t)=-\frac{\chi}{k_{p}} \dot{v}_{q}+\dot{a}(t)+\frac{k_{i}}{k_{p}} a(t)
$$
定义状态空间：
$$
\left\{\begin{align}
x_{1}&=\omega_m \\
x_{2}&=\dot\omega_m
\end{align}\right.
$$

$$
\left\{\begin{align}
\dot x_{1}&=x_2 \\
\dot x_{2}&=-\frac{k_{i}}{k_{p}} x_2+u+d(t)
\end{align}\right.
$$

期望转速$x_{1d}=\omega_d$，

跟踪误差$e=\omega_m-\omega_d=x_1-x_{1d}$

根据第一部分，新型滑模面设计为：
$$
s=\dot e_{}+\alpha_{1} e_{}^{\left(m_{1} / n_{1}\right)}+\beta_{1} e_{}^{\left(p_{1} / q_{1}\right)}+\gamma_1 e
$$
根据第二部分，新型趋近律设计为：
$$
\dot{s}=-\alpha_{2} s^{\frac{m_{2}}{n_{2}}}-\beta_{2} s^{\frac{p_{2}}{q_{2}}}-\gamma_2 s -(\sup(d(t))+\delta)\operatorname{sigm}(s)
$$
根据第三部分，基于观测器的新型趋近律：
$$
\dot{s}=-\alpha_{2} s^{\frac{m_{2}}{n_{2}}}-\beta_{2} s^{\frac{p_{2}}{q_{2}}}-\gamma_2 s -\hat d(t)+\delta\operatorname{sigm}(s)
$$
于是控制器设计为：
$$
\begin{align}
\dot s&=\ddot e_{1}+\alpha_{1} (m_1/n_1)e_{1}^{\left(m_{1} / n_{1}-1\right)}e_2+\beta_{1} (p_1/q_1)e_{1}^{\left(p_{1} / q_{1}-1\right)}e_2\\
&=-\frac{k_{i}}{k_{p}} x_2+u+d(t)-\ddot x_{1d}+\alpha_{1} (m_1/n_1)e_{1}^{\left(m_{1} / n_{1}-1\right)}e_2+\beta_{1} (p_1/q_1)e_{1}^{\left(p_{1} / q_{1}-1\right)}e_2
\end{align}
$$
控制输入：$u(t)=u(t)_{eq}+u(t)_{en}$

其中：
$$
\begin{align}
u(t)_{eq}&=-(-\frac{k_{i}}{k_{p}} x_2+\hat d(t)-\ddot x_{1d}+\alpha_1(m_1/n_1)e^{(m_1/n_1-1)}_1e_2+\beta_1(p_1/q_1)e^{(p_1/q_1-1)}_1e_2+\gamma_1  e_2 +\alpha_{2} s^{\frac{m_{2}}{n_{2}}}+\beta_{2} s^{\frac{p_{2}}{q_{2}}}+\gamma_2 s)\\
u(t)_{en}&=-\delta\operatorname{sigm}{s}
\end{align}
$$
假设电机干扰变化律有界，即$|\dot d(t)|$有界，于是可以利用NDO对$d(t)$,进行估计。

仿真图：

