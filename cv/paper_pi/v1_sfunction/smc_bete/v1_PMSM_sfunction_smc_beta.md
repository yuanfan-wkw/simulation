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



