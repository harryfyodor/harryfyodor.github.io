---
title: 说话人识别#2 i-vector
date: 2018-5-15 14:19:00
tags: ["说话人识别", "语音识别", "机器学习"]
---

> 本文是说话人识别笔记之一。欢迎阅读，如有疏漏错误，请指正，感谢~
> [说话人识别概述](http://pages.harryfyodor.xyz/2018/05/10/speaker_recognition/)
> [说话人识别GMM-UBM](http://pages.harryfyodor.xyz/2018/05/13/speaker_recognition_gmmubm/)
> [说话人识别i-vector](http://pages.harryfyodor.xyz/2018/05/15/speaker_recognition_ivector/)
> [说话人识别PLDA](http://pages.harryfyodor.xyz/2018/05/15/speaker_recognition_plda/)

在前面的那篇博客当中，我们使用GMM-UBM的方法提取了一个均值超矢量。这个特征里面包含了很多的信息，包括一些与说话人无关的信息，比如说语言的信息，信道的信息。因此，直接使用这个特征进行判别是不完美的。提取说话人特征的方法，其实就是希望能够从这个特征当中，提取出一些只与说话人相关的特征。联合因子分析就是一个将特征分解的常用方法。

### 1. 联合因子分析
使用联合因子分析，我们一般假设一个均值超矢量包含了以下一些成分的信息：与说话人无关的信息，只与说话人有关的信息，信道的信息，残差项的信息。用公式来表示如下所示：

$$ s = m + Vy + Ux + Dz$$

* $$s$$是对应说话人的GMM均值超矢量，需要分解的对象。
* $$m$$是说话人无关的信息，这里是UBM的均值超矢量。
* $$V$$是本征语音信号矩阵，可以看做是一种转换
* $$y$$是说话人因子，假设其先验分布为标准正态分布
* $$V$$是本征信道信号矩阵，可以看做是一种转换
* $$x$$是信道因子，假设其先验分布为标准正态分布
* $$D$$是残差矩阵，为对角阵
* $$z$$是说话人相关的残差因子，假设其先验分布为标准正态分布

使用JFA方法，就是训练V，U，D矩阵，然后用这些信息计算y，x，z的数值。y是主要的说话人特征，是后面需要用到用来判别的特征。JFA方法需要估计三个矩阵，计算量上是比较大的。在此基础之上，i-vector方法能够相对来说达到更高的效率。

### 2. i-vector的提取
i-vector，是identity-vector，意思就是表示说话人身份的矩阵。听闻提出这个概念的时候iphone刚刚开始火起来，因此作者就起了这么个名字。i-vector的提取方法本质上也是一种因子分析的方法，但是它和JFA的不同之处在于，它假设信道当中也有很多说话人相关的特征，因此不需要单独提取出来。简单地假设特征由与说话人有关，与说话人相关组成即可。
$$ s = m + Ty$$

s和m与上面定义相同，T也可以看做是一个转换矩阵，y则是需要提取的特征i-vector。可以我们训练的目的就是得到T矩阵，方便我们提取i-vector特征。
下面介绍i-vector提取中，最重要的就是T矩阵的求解。这里我们对它的求解流程进行简单的介绍。对它的推导的介绍在这里就不展开了。

#### 2.1 求解计算统计量
对于每一个说话人的语音特征，我们做一个统计量的计算。一般而言需要计算零阶统计量，一阶统计量，（当然也可以加入二阶统计量，但是非必须）。

$$N_{c}(s)=\sum_{t\in s}\gamma_{t}(c)$$

对说话人s的每一个语音特征，计算该特征在GMM上对应成分的概率，累积。

$$F_{c}(s)=\sum_{t\in s}\gamma_{t}(c)Y_{t}$$

在零阶统计量的基础上，乘上该时间点的相关特征值。

#### 2.2 统计量的中心化

$$\tilde{F}_{c}(s)=F_{c}(s)-N_{c}(s)m_{c}$$
使用UBM的对应均值$$m_{c}$$和零阶统计量中心化一阶统计量。

#### 2.3 将统计量拓展称为矩阵

$$NN(s) = \begin{bmatrix}
N_{1}(s)*I &  & \\ 
 &  ...& \\ 
 &  & N_{c}(s)*I
\end{bmatrix}$$

其中I是单位矩阵。

$$FF(s)=\begin{bmatrix}
\tilde{F}_{1}(s)\\ 
...\\ 
\tilde{F}_{c}(s)
\end{bmatrix}$$

#### 2.4 初始化说话人因子y

最开始使用随机数来初始化矩阵T：

$$ I_{T}(s)=I+T^{*}*\Sigma^{-1}*NN(s)*T $$

y的后验分布是高斯，而我们需要的特征值实质上就是y的期望：

$$ y(s)\sim Normal(I_{T}^{-1}(s)*T^{*}*\Sigma^{-1}*FF(s),I_{T}^{-1}(s)) $$
$$ \bar{y}(s)=E[y(s)]=I_{T}^{-1}(s)*T^{*}*\Sigma^{-1}*FF(s)$$

#### 2.5 计算T矩阵

把领阶统计量乘上y(t)的方差：

$$A_{c}=\sum_{s}N_{c}(s)l_{T}^{-1}(s)$$

$$M=\sum_{s}FF(s)*(I_{T}^{-1}(s)*T^{*}*\Sigma^{-1}*FF(s))^{*}$$

计算T矩阵：

$$T = \begin{bmatrix}
T_{1}\\ 
..\\ 
T_{c}
\end{bmatrix}= \begin{bmatrix}
A_{1}^{-1}*M_{1}\\ 
...\\ 
A_{c}^{-1}*M_{c}
\end{bmatrix}$$

我们得到了T矩阵，就能够再此估计说话人因子y，然后又可以计算T矩阵，之后又是T矩阵......经过几个迭代之后，我们就能够获得一个很好的T矩阵。有了T矩阵，计算y矩阵就非常简单了。这样我们就能够得到我们需要的说话人特征i-vector了。

其中值得注意的一点是：这个T矩阵从另一个方面来说，也完成了一个特征降维的工作。超均值矢量是一个非常大的向量，降维对于后期计算的效率的提高也很有帮助。

以上就是i-vector的提取的相关方法。

### reference:
* [http://www1.icsi.berkeley.edu/Speech/presentations/AFRL_ICSI_visit2_JFA_tutorial_icsitalk.pdf](http://www1.icsi.berkeley.edu/Speech/presentations/AFRL_ICSI_visit2_JFA_tutorial_icsitalk.pdf)
* [https://blog.csdn.net/xmu_jupiter/article/details/47209961](https://blog.csdn.net/xmu_jupiter/article/details/47209961)
