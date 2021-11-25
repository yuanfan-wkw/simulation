## 方案一：最原始的方法

### 首先采用纯粹的数学仿真，不带有电力电子器件仿真

也是就不考虑PWM模块的仿真

#### 1 PMSM 数学方程

(推导过程略)，建模过程可以。

电压方程：
$$
\begin{aligned}
&v_{d}=R_{s} i_{d}+L_{d} p i_{d}-\omega_{r} L_{q} i_{q} \\
&v_{q}=R_{s} i_{q}+L_{q} p i_{q}+\omega_{r} L_{d} i_{d}+\omega_{r} \lambda_{m}
\end{aligned}
$$
其中：$v_d,v_q$分别是定子电压的$d-q$轴分量；$i_d,i_q$分别是定子电流的$d-q$轴分量；$R_S$是定子的电阻；$\omega_r$是电角速度；$L_d,L_q$分别是$d-q $轴电感分量；$\lambda_m$代表永磁体磁链。$P$微分算子。

转矩方程：
$$
T_{e}=\frac{3}{2} P\left[\lambda_{m}+\left(L_{d}-L_{q}\right) i_{d}\right] i_{q}
$$
机械方程：
$$
T_{e}=T_{L}+B \omega_{m}+J p \omega_{m}
$$

#### 一种简单的滑模控制

对于表贴式电机，$L_q=L_d=L_s$采用滑模控制,同时采用$i_d=0$的转子磁场定向控制方法，所以需要电流环控制$i_d$,同样的也可加入解耦提高动态特性。

当$i_d=0$
$$
\left\{\begin{array}{l}
\frac{\mathrm{d} i_{q}}{\mathrm{~d} t}=\frac{1}{L_{\mathrm{s}}}\left(-R i_{q}-p_{\mathrm{n}} \lambda_{m} \omega_{{m}}+v_{q}\right) \\
\frac{\mathrm{d} \omega_{{m}}}{\mathrm{d} t}=\frac{1}{J}\left(-T_{\mathrm{L}}+\frac{3 p_{\mathrm{n}} \lambda_{m}}{2} i_{q}\right)
\end{array}\right.
$$
定义状态变量,这里假设参考角速度为$\omega_\mathrm{ref}$为常数，$T_L$导数为0(会发生突变）：
$$
\left\{\begin{array}{l}
x_{1}=\omega_{\mathrm{ref}}-\omega_{{m}} \\
x_{2}=\dot{x}_{1}=-\dot{\omega}_{{m}}
\end{array}\right.
$$

状态方程：
$$
\left\{\begin{array}{l}
\dot{x}_{1}=-\dot{\omega}_{{m}}=\frac{1}{J}\left(T_{\mathrm{L}}-\frac{3 p_{\mathrm{n}} \lambda_{m}}{2} i_{q}\right) \\
\dot{x}_{2}=-\ddot{\omega}_{{m}}=-\frac{3 p_{\mathrm{n}} \lambda_{m}}{2 J} \dot{i}_{q}
\end{array}\right.
$$
定义$u=\dot{i}_q$

于是状态方程为：
$$
\left\{\begin{array}{l}
\dot{x}_{1}=x_2 \\
\dot{x}_{2}=-\frac{3 p_{\mathrm{n}} \lambda_{m}}{2 J} u
\end{array}\right.
$$
滑模面：
$$
s=cx_1+x_2
$$
$c>0$为待设计的参数。

对滑模面微分
$$
\dot s=c\dot{x}_1+\dot x_2=cx_2+\dot x_2=cx_2-\frac{3 p_{\mathrm{n}} \lambda_{m}}{2 J} u
$$
从而获得$q$轴的参考电流为；(参考电流在动态区可能会很大，最要由内环进行控制、限幅)

传统方法：

指数趋近律：
$$
\dot s=-\varepsilon \mathrm{sign}(s)-ks
$$
其中$\varepsilon >0,k>0$为待设计参数
$$
u=\frac{2J}{3p_n\lambda_m}(u_{eq}+u_{en})
$$

$$
u_{eq}=cx_2
$$

$$
u_{en}=\varepsilon \mathrm{sign}(s)+ks
$$

于是$q$轴的参考电流为：
$$
i_{q}^{*}=\frac{2J}{3p_n\lambda_m}\int_{0}^{t}\left[c x_{2}+\varepsilon \operatorname{sgn}(s)+k s\right] \mathrm{d} \tau
$$
问题：模型没有定义具体干扰，所以$\varepsilon$定义没有意义，不过可以提高收敛速率。

参数提升对收敛速度不明显，



对比方法：见smc_new_model


$$

$$
x

#### 2 仿真

##### 2.1表贴式PMSM

参数：

| 参数                  |        |
| --------------------- | ------ |
| $L$/mH                | 6.71   |
| $\lambda_m$/Wb        | 0.175  |
| $R_s$/$\Omega$        | 1.55   |
| $B$/N$\cdot$m$\cdot$s | 0.0003 |
| $J$/kg$\cdot$m$^2$    | 0.0002 |



## 方案二考虑干扰

1.李世华
$$
\dot{\omega}=\frac{K_{t}}{J} i_{q}-\frac{B}{J} \omega-\frac{T_{L}}{J}=\frac{K_{t}}{J} i_{q}^{*}-\frac{B \omega}{J}-\frac{T_{L}}{J}-\frac{K_{t}}{J}\left(i_{q}^{*}-i_{q}\right)=\frac{K_{t}}{J} i_{q}^{*}-d(t)
$$
然后用ESO估计d(t)

2.李世华
$$
\ddot{\omega}=-\frac{k_{i}}{k_{p}} \dot{\omega}+d(t)+u
$$
3.李世华

Design and Implementation of Terminal Sliding
Mode Control Method for PMSM Speed Regulation System

4.2021 河南
$$
\dot{\omega}_{r}=(\chi+\Delta \chi) i_{q}^{*}-(\eta+\Delta \eta) \omega_{r}-(\gamma+\Delta \gamma) T_{L}
$$
5水
$$
\left\{\begin{array}{l}
\lambda_{mo}=\lambda_{m}+\Delta \lambda_{m} \\
J_{{o}}=J+\Delta J \\
B_{{o}}=B+\Delta B
\end{array}\right.
$$
实际是Bo,建模确实B,所以要把干扰考虑进去。
$$
\frac{d \omega_{\mathrm{e}}}{d t}=\frac{1.5 P_{\mathrm{n}}^{2} \psi_{\mathrm{f}}}{J} i_{q}-\frac{P_{\mathrm{n}}}{J} T_{\mathrm{L}}-\frac{B}{J} \omega_{\mathrm{e}}
$$

$$
\dot{\omega}_{\mathrm{e}}=\frac{1.5 P_{\mathrm{n}}^{2}\left(\psi_{f o}+\Delta \psi_{\mathrm{f}}\right)}{J_{0}+\Delta J} i_{q}-\frac{P_{\mathrm{n}}}{J_{0}+\Delta J} T_{\mathrm{L}}-\frac{B_{\mathrm{o}}+\Delta B}{J_{\mathrm{o}}+\Delta J} \omega_{\mathrm{e}}
$$



我的方法：

文章主要3+5：

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

$$
\begin{equation}
 	\dot{\hat{d}}=-\eta \hat{d}+{\eta}(\dot{{x}}_2+\frac{k_{i}}{k_{p}} x_2-u)
 	\label{ndo_1}
 \end{equation}
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
假设电机干扰变化律有界，即$|\dot d(t)|$有界，于是可以利用NDO对d(t),进行估计。



仿真图：

