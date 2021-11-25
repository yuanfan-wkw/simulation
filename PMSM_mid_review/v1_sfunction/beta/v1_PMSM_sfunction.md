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
其中：$v_d,v_q$分别是定子电压的$d-q$轴分量；$i_d,i_q$分别是定子电流的$d-q$轴分量；$R_S$是定子的电阻；$\omega_r$是电角速度；$L_d,L_q$分别是$d-q $轴电感分量；$\lambda_m$代表永磁体磁链。$p$微分算子。

转矩方程：
$$
T_{e}=\frac{3}{2} P\left[\lambda_{m}+\left(L_{d}-L_{q}\right) i_{d}\right] i_{q}
$$
机械方程：
$$
T_{e}=T_{L}+B \omega_{m}+J p \omega_{m}
$$

其中$T_L$是电磁转矩，$B$是粘滞系数,$J$是转动惯量。


#### 2 仿真

##### 2.1表贴式PMSM,没有电流环解耦

参数：

| 参数                  |        |
| --------------------- | ------ |
| $L$/mH                | 6.71   |
| $\lambda_m$/Wb        | 0.175  |
| $R_s$/$\Omega$        | 1.55   |
| $B$/N$\cdot$m$\cdot$s | 0.0003 |
| $J$/kg$\cdot$m$^2$    | 0.0002 |



