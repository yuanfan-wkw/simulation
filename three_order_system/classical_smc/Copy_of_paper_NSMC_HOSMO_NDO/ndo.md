# 仿真

### 1 系统方程

$$
\left\{\begin{align}\dot{ {x}}_{1}&= {x}_{2}+d_{1} \\ \dot{ {x}}_{2}&={x}_{3}+d_{2} \\ \dot{ {x}}_{3}&= {x}_{1}  {x}_{2}  {x}_{3}+ {x}_{1} \sin  {x}_{1}+5 u+F+d_{3} \\  {y}&={x}_{1}\end{align}\right.
$$

### 2 嵌套滑模 NSMC

跟踪误差：
$$
e=x_1-x_{1d}
$$
嵌套滑模面，$c_0,c_1$为待设计参数：
$$
s_0=\dot{e}+c_0e
$$

$$
s_1=\dot{s}_0+c_1s_0
$$

嵌套滑模面展开：
$$
\begin{align}
s_0&=\dot{e}+c_0e\\
&=(\dot x_1-\dot x_{1d})+c_0(x_1-x_{1d})\\
&=(x_2+d_1-\dot{x}_{1d})+c_0(x_1-x_{1d})
\end{align}
$$

$$
\begin{align}
s_1&=\dot{s}_0+c_1s_0\\
&=(\dot x_2+\dot d_1-\ddot x_{1d})+c_0(x_2+d_1-\dot x_{1d})+c_1(x_2+d_1-\dot x_{1d})+c_0c_1(x_1-x_{1d})\\
&=(x_3+d_2+\dot d_1-\ddot x_{1d})+(c_0+c_1)(x_2+d_1-\dot x_{1d})+c_0c_1(x_1-x_{1d})
\end{align}
$$



计算$s_1$的导数：
$$
\begin{align}
\dot s_1&=\dot x_3+\dot d_2+\ddot d_1-\dddot x_{1d}+(c_0+c_1)(\dot x_2 +\dot d_1 -\ddot x_{1d})+c_0c_1(\dot x_1 -\dot x_{1d})\\
&=x_1x_2x_3+x_1\sin(x_1)+5u+F+d_3+\dot d_2+\ddot d_1-\dddot x_{1d}+(c_0+c_1)(\dot x_2 +\dot d_1 -\ddot x_{1d})+c_0c_1(\dot x_1 -\dot x_{1d})
\end{align}
$$
这里可以不展开$\dot x_2,\dot x_1$ ，可以减少计算量。但是需要引入微分器计算$\dot x_2,\dot x_1$。因为只假设状态可测。如果不采用微分器需要展开。

展开上式：
$$
\begin{align}
\dot s_1&=\dot x_3+\dot d_2+\ddot d_1-\dddot x_{1d}+(c_0+c_1)(\dot x_2 +\dot d_1 -\ddot x_{1d})+c_0c_1(\dot x_1 -\dot x_{1d})\\
&=x_1x_2x_3+x_1\sin(x_1)+5u+F+d_3+\dot d_2+\ddot d_1-\dddot x_{1d}+(c_0+c_1)(\dot x_2 +\dot d_1 -\ddot x_{1d})+c_0c_1(\dot x_1 -\dot x_{1d})\\
&=x_1x_2x_3+x_1\sin(x_1)+5u+F+d_3+\dot d_2+\ddot d_1-\dddot x_{1d}+(c_0+c_1)(x_3+d_2 +\dot d_1 -\ddot x_{1d})+c_0c_1(x_2 + d_1 -\dot x_{1d})\\
&=x_1x_2x_3+x_1\sin(x_1)+5u-\dddot x_{1d}+(c_0+c_1)(x_3 -\ddot x_{1d})+c_0c_1(x_2  -\dot x_{1d})+c_0c_1d_1+(c_0+c_1)\dot{d}_1+\ddot d_1\\&\quad +(c_0+c_1)d_2+\dot d_2+d_3
\end{align}
$$
采用经典滑模控制，也就是等速趋近律。
$$
\dot {s}_1=-\varepsilon \text{sign}(s_1)
$$

$$
u=u_{eq}+u_{en}
$$
其中$u_{eq}$：
$$
u_{eq}=-\frac{1}{5}(x_1x_2x_3+x_1\sin(x_1)+F-\dddot x_{1d}+(c_0+c_1)(x_3 -\ddot x_{1d})+c_0c_1(x_2  -\dot x_{1d}))
$$
$u_{en}$
$$
u_{en}=-\frac{1}{5}\left(\sup\{\left| c_0c_1d_1+(c_0+c_1)\dot{d}_1+\ddot d_1+(c_0+c_1)d_2+\dot d_2+d_3\right|\}+\delta\right)\text{sign}(s_1)
$$
其中$\delta >0,\delta \in \bold{R}$

根据假设可知干扰导数上界存在，仿真采用干扰导数上确界。如果不采用上确界而采用上界，仿真的抖振会更大。

注：$F=0.01x_2e^{-0.5x_1}$是建模误差，这个误差有精确的数学表达，所以$F$不能被理解为内部干扰。
$$
\begin{align}
 &\sup\{\left| c_0c_1d_1+(c_0+c_1)\dot{d}_1+\ddot d_1+(c_0+c_1)d_2+\dot d_2+d_3\right|\}\\
&\leqslant \sup{|c_0c_1d_1|}+\sup |(c_0+c_1)\dot{d}_1|+\sup |\ddot d_1|+\sup |(c_0+c_1)d_2|+\sup|\dot{d}_2|+\sup|d_3|\\
&\leqslant c_0c_1\sup|d_1|+(c_0+c_1)\sup|\dot{d}_1|+\sup |\ddot d_1|+(c_0+c_1)\sup |d_2|+\sup|\dot{d}_2|+\sup|d_3|\\

\end{align}
$$
计算干扰及其导数上界，再次说明这里的上界是理想值，实际会比这个大。

其中：
$$
d_{1}=0.5 \sin 2 t+\sin t
$$
于是有：
$$
\begin{align}
\sup|d_1|&=\max|d_1|=\frac{3}{2}\\
\dot{d}_1&=\cos(2t)+\cos(t)\\
\sup|\dot{d}_1|&=\max|\dot{d}_1|=2\\
\ddot{d}_1&=-2\sin(2t)-\sin(t)\\
\sup|\ddot{d}_1|&=\max|\ddot{d}_1|=3\\
\end{align}
$$
其中：
$$
d_{2}=t \mathrm{e}^{-0.5 t}
$$

$$
\begin{align}
\dot{d}_2&=e^{-0.5t}-0.5te^{-0.5t}=(1-0.5t)e^{-0.5t}\\
\sup|{d}_2|&=\max|{d}_2|= d_2(2)=2e^{-1}\\
\ddot{d}_2&=-0.5(2-0.5t)e^{-0.5t}\\
\sup|\dot{d}_2|&=\max|\dot{d}_2|=1\\
\end{align}
$$

其中：
$$
\begin{align}
d_3&=0.8\sin(t)\\
\end{align}
$$

$$
\sup|{d}_3|&=\max|{d}_3|= 0.8\\
$$

$$
\begin{align}
 &\sup\{\left| c_0c_1d_1+(c_0+c_1)\dot{d}_1+\ddot d_1+(c_0+c_1)d_2+\dot d_2+d_3\right|\}\\
&\leqslant \sup{|c_0c_1d_1|}+\sup |(c_0+c_1)\dot{d}_1|+\sup |\ddot d_1|+\sup |(c_0+c_1)d_2|+\sup|\dot{d}_2|+\sup|d_3|\\
&\leqslant c_0c_1\sup|d_1|+(c_0+c_1)\sup|\dot{d}_1|+\sup |\ddot d_1|+(c_0+c_1)\sup |d_2|+\sup|\dot{d}_2|+\sup|d_3|\\
&=\frac{3}{2}c_0c_1+2(c_0+c_1)+3+2e^{-1}(c_0+c_1)+1+0.8\\
&=\frac{3}{2}c_0c_1+(2+2e^{-1})(c_0+c_1)+4.8
\end{align}
$$

取$\delta=0.1$,则有：
$$
u_{en}=-\frac{1}{5}(\frac{3}{2}c_0c_1+(2+2e^{-1})(c_0+c_1)+4.9)
$$

##### 2.1 分别设置$c_0=c_1=10,c_0=c_1=1$,仿真





### 3 NSMC+HOSMO+NDO


$$
\Upsilon =c_0c_1d_1+(c_0+c_1)\dot{d}_1+\ddot d_1 +(c_0+c_1)d_2+\dot d_2+d_3
$$

##### 3.1 HOSMO间接得到干扰补偿项

$$
\hat\Upsilon =c_0c_1\hat{d}_1+(c_0+c_1)\hat{\dot{d}}_1+\hat{\ddot d}_1 +(c_0+c_1)\hat d_2+\hat{\dot d}_2+\hat{d}_3
$$

##### 3.2 控制器设计

$$
u_{eq}=-\frac{1}{5}(x_1x_2x_3+x_1\sin(x_1)+F-\dddot x_{1d}+(c_0+c_1)(x_3 -\ddot x_{1d})+c_0c_1(x_2  -\dot x_{1d})+\hat\Upsilon)
$$

$$
u_{en}=-\frac{1}{5}\delta\text{sign}(s_1)
$$

同样的取$\delta=0.1$

### 1 ndo设计

系统方程最后一个公式：
$$
\dot{x}_3=x_1x_2x_3+x_1 \sin(x_1)+5u+F+d_3
$$
NDO被设计为：
$$
\dot{\hat{d}}_n=-\eta \hat{d_n}+\eta(\dot{x}_3-x_1x_2x_3-x_1 \sin(x_1)-5u-F)
$$
