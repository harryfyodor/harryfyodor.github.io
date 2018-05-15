---
title: 说话人识别#3
date: 2018-5-15 21:49:00
tags: ["说话人识别", "语音识别", "机器学习"]
---

上一篇博客讲述了如何从均值超矢量中提取i-vector特征的方法。提取i-vector的方法是联合因子分子JFA的一种简化方式。它假设了，在信道空间当中存在着与说话人相关的特征，因此在分析的时候不做直接的区分。获得i-vector之后，就要对i-vector进行分类判别。

分类的方法有很多，我们可以使用SVM，也可以使用更主流的PLDA。本篇博客主要简单介绍PLDA方法。这个方法也是人脸识别中非常经典的分类器。

### PLDA算法
在i-vector提取的时候，假设信道的信息中包含了说话人的信息。而PLDA方法，则需要对这个i-vector中的信道信息进行分离。PLDA方法的基本公式如下所示：

$$\omega_{ij} = u + Vy_{i} + Ux_{ij} + z_{ij}$$

u是i-vector的均值，y是与说话人相关的信息，x和z是与语音信道和噪声相关的信息。V和U代表说话人类间空间和类内空间。

我们可以看到，这个方法本质上也是一个JFA方法。要得到其中的V和U两个矩阵，我们使用的方法也是EM算法。在这里不再进行深入叙述。

因此，说话人识别传统方法中使用了两个因子分析：一开始通过因子分析，从GMM-UBM均值超矢量中提取i-vector；之后再用因子分析，从i-vector特征中提取和说话人特征。这个特征是更加纯粹的，只与说话人识别的特征。

### 如何识别
得到了PLDA说话人特征，接下来就是判断是否两个特征是否属于同一个的任务。我们保留每一个注册语音的说话人特征。然后对于每一个测试语音i-vector特征，

简单来说，我们可以使用余弦距离：

$$Score(\omega_{tar}, \omega_{test}) = \frac{<\omega_{tar}, \omega_{test}>}{||\omega_{tar}||||\omega_{test}||}$$

我们也可以使用特征似然度计算得分，u是i-vector的均值，其中$$\Sigma_{lol}=VV_{*}+D^{-1}$$，$$\Sigma_{ac}=VV_{*}$$：

$$Score=log\frac{p(\omega_{1},\omega_{2}|\theta_{tar})}{p(\omega_{1},\omega_{2}|\theta_{non})}=logN(\begin{bmatrix}
\omega_{1}\\ 
\omega_{2}
\end{bmatrix};\begin{bmatrix}
u\\ 
u
\end{bmatrix},\begin{bmatrix}
\Sigma_{lol} & \Sigma_{ac}\\ 
\Sigma_{ac} & \Sigma_{lol}
\end{bmatrix}) - logN(\begin{bmatrix}
\omega_{1}\\ 
\omega_{2}
\end{bmatrix};\begin{bmatrix}
u\\ 
u
\end{bmatrix},\begin{bmatrix}
\Sigma_{lol} & 0\\ 
0 & \Sigma_{lol}
\end{bmatrix})$$

### reference
《基于i-vector和PLDA的说话人确认方法》