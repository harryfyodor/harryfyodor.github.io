---
title: 机器学习 | Logistics Regression
date: 2017-10-16 23:34:00
tags: ["机器学习"]
---

本篇博客的主要内容是`Logistics Regression`，算是一篇个人笔记。这里的类别为两类。

### 算法类别：
* 有监督
* 分类的方法（这里仅作分成两类的分析）

### 直观理解
把一组数据x与权重进行相乘，结果再通过一个sigmoid函数。效果就是，一个线性的函数被“强制”拉到0和1之间。把这里的0和1当成是两种分类，那通过上面的操作之后，数据就非常自然地被分成了两类。靠近1的一类，和靠近0的一类。

sigmoid函数的形式如下：
(公式)

### 最大似然函数与LMS
为了使用数据来进行分类。这里有两种方法可以进行操作：第一种是构建最大似然函数，然后通过训练参数，使得该函数的函数值最大。这里运用到了信息论的相关知识，但也可以直观理解。理解的方法如下：当函数估计是1的时候，结果也是1，或者估计是0，结果也是0，这两种情况发生的时候，该函数会更大。所以，目标就是尽量使得这个函数变大。

最大似然公式如下：

第二种是构建损失函数，通过训练参数，使函数值变小。这里使用LMS的方法。有点类似方差。当估计的和真实的相差越小，估计得越好。

损失函数估计如下：


### 更新方法
梯度下降，用于最小化损失函数。

公式如下：

梯度上升，用于最大化似然函数

公式如下：

可以直观去理解：计算出的梯度代表了方向，而前面的alpha代表了步长。通过不停迭代，函数不停地往让自己更小或者更大的方向前进。从而达到想要的效果。

（随机梯度）

除此之外，最大化似然函数还可以使用牛顿法。牛顿法的核心在于，让近似直线不停靠近0点。通过迭代，靠近f(x)的0点。此时，如果把似然函数的导数函数当成f(x)，就可以找到似然函数导数0点值从而找到函数的极值。





机器学习的相关学习方法

原本打算实现所有的方法，但是发现比较繁琐，而且很多时候会纠结于没有必要的事情上
