---
title: WFST详解#1
date: 2017-11-8 23:34:00
tags: ["语音识别"]
---

WFST操作有基本操作和更高级的算法。本篇文章主要讲基本操作。

### 基本操作

下面的基本操作需要熟悉。在网上有一个很好的slides可以作为学习的参考。它有很多例子，可以直观地了解每一个算法运行的结果怎么样。这里的算法比较简单，看一下公式和图例基本就能了解清楚。在这篇短文中，我会直接slides的截图放出来。

slides的地址在这里：http://openfst.cs.nyu.edu/twiki/pub/FST/FstHltTutorial/tutorial_part1.pdf

这里挑选几个比较重要的基本操作，简单讲讲。

#### Kleene closure
这个算法的作用是讲WFST变成一个闭环。具体做法是新建一个起点的状态，指向原本的起点状态。这里我们就新建了一个转移。这里之后，我们再新建一个转移，从终止状态指向原本的起始状态。在这里还要进行一下权重的调整：新的初始状态不再带权重，而讲权重放到新的转移（指向原本的起点状态）上；从终止状态指向原本起点的转移上，我们讲权重设置为终止状态的权重。

<img src="closure.png" style="margin-left:50%;transform: translateX(-50%);">

#### Union
这一个算法讲两个WFST联合起来。联合的方式如下：创建一个新的节点作为起点，然后从这个起点出发，创建两个转移，指向原本的两个WFST的起点。

<img src="union.png" style="margin-left:50%;transform: translateX(-50%);">

#### Concatentation
Concatentation算法的作用是讲一个WFST接在另一个WFST的末尾。第一个WFST的终止权重自然而然转换成了新转移的权重。

<img src="concatenation.png" style="margin-left:50%;transform: translateX(-50%);">

#### Inversion
翻转操作非常重要，在语音识别解码器构建以及解码中都会用到。操作很简单，就是把转移上面的输入和输出翻转过来。操作之后，就能通过原本的输出输入，通过原本的输入输出。一个大写字母变成小写字母的WFST就会被转换成小写到大写。

<img src="inversion.png" style="margin-left:50%;transform: translateX(-50%);">

#### Reversal
这个算法讲整一个WFST逆转过来。我们新建一个新的起点，指向终止状态。整一个WFST的转移方向都反过来。

<img src="reversal.png" style="margin-left:50%;transform: translateX(-50%);">

#### Projection
这一个步骤，我们讲WFST的输出都抛弃掉。我们的WFST这里就变成了WFA。

<img src="projection.png" style="margin-left:50%;transform: translateX(-50%);">

### 其他重要算法
有关WFST有一些非常重要的算法，这些算法可以大致分为两类：合成(Composition)和优化(Optimization)。优化算法又包括：Determinization，-Removal，Weight-pushing， Minimization。关于这些算法我也写了一些相关的入门文章，可以参考。