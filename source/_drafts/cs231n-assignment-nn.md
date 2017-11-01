---
title: cs231n作业小结——神经网络
tags: ["深度学习"]
---

本文结合standford著名的cs231n课程的Assignment，做一个简单的个人小结。

### 结构
cs231n的Assignment2将神经网络的代码结构化，总结成了几个步骤：初始化神经网络，前向传播求得loss，反向传播更新参数偏导数，更新参数。Pytorch等神经网络框架也是使用的这一种结构。
#### Initialization
在训练神经网路之前需要先确定神经网络的结构。确定了神经网络的结构之后需要初始化训练参数。
#### loss

#### update
gradient descent

### 层
#### FC层
##### forward
##### backward

#### ReLU层
##### forward
##### backward

### 损失
#### SVM层
##### forward
##### backward

#### Softmax层
##### forward
##### backward

### 更新
反向求导之后，需要对当前的参数值进行更新。传统的SGD更新有以下缺点：
* 有些方向更新快，有些慢的时候，总体更新效果不好。
* Local minima或者Saddle point的出现。
* Mini-batch可能会有较大的噪声。
因此需要有一些改变，来解决上面的问题。
#### SGD
```python
w -= learning_rate * dw
```
#### SGD + Momentum
Intuition: 增加一点上一个步骤的变化方向影响，以免当前步骤过多影响更新方向。
```python
v = momentum * v - learning_rate * dw
next_w = w + v
```
#### RMSProp
Intuition: 有的方向变化大，有的变化小，可通过除以一个平方再开根的值进行平衡。
```python
cache = decay_rate * cache + (1 - decay_rate) * dx ** 2
next_x = x - learning_rate * dx / (np.sqrt(cache) + epsilon)
```
#### Adam
Intuition: 结合了上面两个更新方法的优点。一般而言这个效果最好。
```python
m = beta1 * m + (1 - beta1) * dx
v = beta2 * v + (1 - beta2) * (dx ** 2)
next_x = x - learning_rate * m / (np.sqrt(v) + epsilon)
```

### 改进
#### Regulization
L1，L2

#### batch normalization
加的位置，增加了训练的参数，有什么用，推荐文章
##### forward
##### backward

#### dropout
随机抛弃一些神经元
train时期，test时期
##### forward
##### backward
