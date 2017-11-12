---
title: 三音素模型
date: 2017-11-8 23:34:00
tags: ["语音识别"]
---

* 背景

状态代表音素

优点

三个状态代表音素，包含一些上下文的信息，

声音之间互相影响

增加了更多的细节，让语音能够更好表示

* 种类

Triphone

Word internal 词内分，词和词更加分散

Cross-word triphone 

* 问题

太多的参数需要去训练，triphones的数目太多了

* 问题的解决

参数共享

state clustering

CART

二叉树

最大似然 阈值