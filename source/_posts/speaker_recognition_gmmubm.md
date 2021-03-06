---
title: 说话人识别#1 GMM-UBM
date: 2018-5-13 00:50:00
tags: ["说话人识别", "语音识别", "机器学习"]
---

本篇文章会介绍说话人识别的传统方法。而说到说话人识别的传统方法，第一步就是进行构建GMM-UBM模型。说话人识别简单来说可以分成两个部分，一个部分是说话人特征的提取，一个部分是判断两个说话人特征是不是属于同一个人。说话人特征的提取格外的重要，对传统方法来说，这个说话人特征是i-vector。而提取i-vector，需要对一个“更大的特征”进行因子分析，排除掉除了说话人相关的特征，保留下与说话人最相关的特征。而GMM-UBM，就是用来提取这个“更大的特征”的模型。

### 什么是GMM-UBM模型

什么是GMM-UBM模型？我们可以这样理解，UBM模型是一个更加普遍的GMM模型。而每一个人，根据自己的说话人特征，对UBM进行调整，成为一个新的独立的GMM模型。为什么不针对每个人直接训练一个GMM模型呢？那是因为我们常常会有很多未标记数据，而较少的个人数据。使用这种GMM-UBM的训练方法，能够很好地利用这些未标记的数据，并且迁移到更具体的人的身上。

训练UBM模型的方法和训练GMM的方法是一致的，都是通过EM算法，不停地更新三组GMM的参数，权重，均值，方差，最后达到收敛。而我们使用的数据是部分个人的，整体的。之后，我们再使用自适应算法，比如MAP算法，比如说MLLR算法，对原本UBM的参数进行自适应调整，结果就是我们对每一个人都适应了一个模型。之后，我们提取这个GMM模型的所有成分的均值信息，拼接起来，就可以得到那个我们需要的”最大的特征“。这个最大的特征就是均值超矢量。


### 有什么自适应算法

我们一般常用的自适应算法主要有MAP算法和MLLR算法两种。下面分别对他们进行简单的介绍。

#### MAP算法

当一个新的数据点来到的时候，我们需要首先确定当前的数据点是属于UBM分布的哪一个分量。然后，我们根据下面的公式对该分布的参数进行响应的更新，更新的公式如下所示:

$$ \tilde{\mu } = \frac{\tau\mu_{0}+\sum_{n}\gamma(n)x_{n}}{\tau+\sum_{n}\gamma(n)} $$

其中，$$\tau $$ 是超参，控制UBM和特定人语音数据之间的平衡。$$\mu \_{0} $$ 是UBM的均值，在之前使用EM算法求得的结果。$$x_{n} $$ 是自适应的新的个人的数据。$$\gamma $$是当前数据特征在当前GMM中成分的概率。

#### MLLR算法

MAP算法有一个缺点，针对每一个数据点来说，它所更新的成分是固定的。而又由于实际中，一个UBM中的成分很多，因此，每次更新到的参数对比之下少太多了。于是，MLLR算法就像通过线性的方法，去训练一个统一的转换模型。
对每一个UBM的成分，对它的均值做一个线性的变换。下面参数$$A$$以及$$b$$就是我们要求解的转换。

$$ \hat{\mu} = A\mu + b $$

我们通过最大化它的似然函数，来求得最优的线性转换。它的似然函数如下所示。
$$ L=\sum_{r}\sum_{n}\gamma_{r}(n)log(K_{r}exp(-\frac{1}{2}(x_{n}-W\eta_{r})\Sigma_{r}^{-1} (x_{n}-W\eta_{r}))) $$
其中
$$\eta = [1\mu^{T} ]^{T} $$
$$ W = [bA]$$

我们对它进行求导数，结果等于0,就可以求出$$W$$。同样的，我们也可以对方差做同样的操作。上面的似然函数如果想要知道是怎么得来的，需要自己查阅相关的文献，这里不展开。

### 小结
这篇博客简单介绍了GMM-UBM的训练过程，通过上面的方法，我们可以得到每一个说话人的一个特定的GMM(通过UBM自适应而来)。我们把GMM的均值拼接，就得到了均值超矢量。之后要做的工作就是使用因子分析在这个特征上面提取说话人特征i-vector。

### reference
[https://www.inf.ed.ac.uk/teaching/courses/asr/2015-16/asr10-adapt.pdf](https://www.inf.ed.ac.uk/teaching/courses/asr/2015-16/asr10-adapt.pdf)

> 本文是说话人识别笔记之一。欢迎阅读，如有疏漏错误，请指正，感谢~
> 1. [说话人识别概述](http://pages.harryfyodor.xyz/2018/05/10/speaker_recognition/)
> 2. [说话人识别GMM-UBM](http://pages.harryfyodor.xyz/2018/05/13/speaker_recognition_gmmubm/)
> 3. [说话人识别i-vector](http://pages.harryfyodor.xyz/2018/05/15/speaker_recognition_ivector/)
> 4. [说话人识别PLDA](http://pages.harryfyodor.xyz/2018/05/15/speaker_recognition_plda/)
