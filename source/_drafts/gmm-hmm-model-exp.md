---
title: GMM-HMM模型（Kaldi实践篇）
tags: ["语音识别"]
---

总述

train mono

gmm-init-mono

compile-train-graphs

align-equal-compiled

gmm-est



#### Log Domain防止Underflow
在BW算法的实现过程中，有可能遇到下面的underflow的问题。比方说前向算法的这个公式：

因为所有的概率的部分都小于1，随着时间的累加，输出值会变得很小，甚至发生下溢的状况。为了避免这一种情况，我们的累加可以使用Log对数的累加来替代。具体的数学推导在这里就不详述了。
#### Pruning
前向算法虽然比起全部遍历来说复杂度减少了不少，但是这仍然是一个很高的数值（TN^2）。我们可以采用剪裁的方法，每一次累加只选择最高的几位。维特比算法的也可以用类似的方法，寻找路径的计算量会小不少。

1. 把训练的语音信号使用MFCC特征表示出来
2. 把一串一串的模板帧通过K-means方法进行聚类
3. 对参数进行初始化，进行EM算法的计算
4. 获得模型
（图）

结合K-means
多语音的HMM
GMM的HMM