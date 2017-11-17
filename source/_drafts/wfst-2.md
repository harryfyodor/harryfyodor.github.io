---
title: WFST详解#1
date: 2017-11-8 23:34:00
tags: ["语音识别"]
---

WFST操作有基本操作和更高级的算法。本篇文章主要讲基本操作，以及高级算法的框架。

### 基本操作

下面的基本操作需要熟悉。每一个操作有一条公式和一幅图用于加深理解。

Kleene closure

Union

Concatentation

Inverse

Reversal

Projection

### 高级操作
有关WFST有一些非常重要的算法，这些算法可以大致分为两类：合成(Composition)和优化(Optimization)。
优化算法又包括：
* Determinization
* zeol-Removal
* Weight-pushing
* Minimization