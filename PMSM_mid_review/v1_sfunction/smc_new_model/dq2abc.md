### $d-q$ 同步旋转坐标系到$ABC$自然坐标系变换

#### 推导过程

1.Clark变换

$ABC$和$\alpha-\beta$坐标系之间的变换

$ABC$到$\alpha-\beta$坐标系
$$
\left[\begin{array}{lll}
f_{\alpha} & f_{\beta} & f_{0}
\end{array}\right]^{\mathrm{T}}=\boldsymbol{T}_{3 \mathrm{~s} / 2 \mathrm{~s}}\left[\begin{array}{lll}
f_{A} & f_{B} & f_{C}
\end{array}\right]^{\mathrm{T}}
$$
$\boldsymbol{T}_{3 \mathrm{~s} / 2 \mathrm{~s}}$表示旋转矩阵，为了化为齐次的变成$3\times3$的方阵
$$
\boldsymbol{T}_{3 \mathrm{~s} / 2 \mathrm{~s}}=\frac{2}{3}\left[\begin{array}{ccc}
1 & -\frac{1}{2} & -\frac{1}{2} \\
0 & \frac{\sqrt{3}}{2} & -\frac{\sqrt{3}}{2} \\
\frac{\sqrt{2}}{2} & \frac{\sqrt{2}}{2} & \frac{\sqrt{2}}{2}
\end{array}\right]
$$

2. Park变换

$\alpha-\beta$到$d-q$坐标系
$$
\left[\begin{array}{ll}
f_{d} & f_{q}
\end{array}\right]^{\mathrm{T}}=\boldsymbol{T}_{2 \mathrm{~s} / 2 \mathrm{r}}\left[\begin{array}{ll}
f_{\alpha} & f_{\beta}
\end{array}\right]^{\mathrm{T}}
$$

$$
\boldsymbol{T}_{2 \mathrm{~s} / 2 \mathrm{r}}=\left[\begin{array}{rr}
\cos \theta_{\mathrm{e}} & \sin \theta_{\mathrm{e}} \\
-\sin \theta_{\mathrm{e}} & \cos \theta_{\mathrm{e}}
\end{array}\right]
$$

通过1.2可以计算出$ABC$到$d-q$的关系