---
title: 说话人识别#0
date: 2018-5-10 19:10:00
tags: ["说话人识别", "语音识别", "机器学习"]
---

最近毕设的工作接近了尾声，下面就是等待答辩了。在毕业前剩下的这段时间里，我准备开始找点时间看一些有关说话人识别的知识。这里就顺便做一下总结。

说话人识别，顾名思义，就是通过声音来分辨人。苹果的Siri就自带说话人识别的功能，只有注册用户才能够通过“Hey, Siri.”唤醒Siri功能。对于语音识别应用来说，从隐私和实用性角度，说话人识别技术都有着非常重要的作用。

说话人识别技术传统方法的整体流程如下所示：
1. 使用数据训练一个与说话人无关的UBM模型。
2. 使用说话人自适应的算法（MAP或者MLLR）对特定说话人训练GMM，将每个GMM成分的均值组合成一个矢量，这个矢量被称为均值超矢量。
3. 从均值超矢量提取i-vector特征。i-vector的提取算法可以看做是JFA（联合因子分析）的简化版本。
4. 使用LDA或者PLDA鉴别。使用LDA/PLDA将测试语音和训练模型的i-vector特征重新投影之后，对比其cosine距离，就可以打分了。设置阈值，判别是不是同一个人。

或许有人会说，现在是神经网络的时代，为什么不直接上神经网络呢？在知乎上有一个这样的问题：[为什么在说话人识别技术中，PLDA面对神经网络依然坚挺？](https://www.zhihu.com/question/67471632)这是一个有趣且值得关注的问题。在这个问题底下有几个有意思的回答，提到几个点，在这里也做一个归纳。
1. 数据量问题。神经网络对于数据量的要求非常高。Google为什么能够屡屡出一些深度学习方面的成果，比如说话人识别中d-vector，关键词当中的LSTM模型等，其中非常主要的原因就是数据。
2. 分类？深度学习在不少情况下，需要把一个任务直接或者间接地转化成一个分类问题。但是说话人识别任务明显不能当成简单的分类问题，毕竟如果根据分类问题的角度来考虑，网络最后一层的输出节点无法穷尽。
3. Embedding？如果要使用深度学习的方法，一般就是将之转化成编码问题，将当前的数据通过神经网络映射到另一个空间当中。这里需要这种映射能够让同说话人的特征更加接近，不同说话人差异更大。在这个层面上思考是说话人识别与深度学习结合最热门的方向。
4. 自编码？我认为自编码如果能够达到很好的效果，那将是一种“最理想”的方法。但是深度学习在非监督学习上面常常比较难做到令人满意的效果。这一方面的有太大的空间。

因为上面的一些原因，继续深入学习说话人识别传统方法仍然非常重要，非常有意义。但是同时，我们也应该继续密切关注深度学习在其中发挥的作用，与时俱进。毕竟现在一切技术都太容易过时，不时时刻刻追赶，一下就落后了。

针对说话人识别，我还会写一些文章详细介绍上面的传统方法，三五篇左右。希望能够一直更，不要坑（笑）。

5月21日更新：下面是所有笔记的目录。

> [说话人识别概述](http://pages.harryfyodor.xyz/2018/05/10/speaker_recognition/)
> [说话人识别GMM-UBM](http://pages.harryfyodor.xyz/2018/05/13/speaker_recognition_gmmubm/)
> [说话人识别i-vector](http://pages.harryfyodor.xyz/2018/05/15/speaker_recognition_ivector/)
> [说话人识别PLDA](http://pages.harryfyodor.xyz/2018/05/15/speaker_recognition_plda/)

reference:
* [说话人识别整体流程](https://www.zhihu.com/question/63978977)
* [说话人识别相关概念](https://blog.csdn.net/xmu_jupiter/article/details/47209961)
* [GMM+UBM介绍](https://speechlab.sjtu.edu.cn/pages/sw121/homepage/2016/04/28/Code-Based-GMM-UBM-Tutorial/)
* [说话人自适应](https://www.inf.ed.ac.uk/teaching/courses/asr/2015-16/asr10-adapt.pdf)
* [i-vector的提取公式](http://www1.icsi.berkeley.edu/Speech/presentations/AFRL_ICSI_visit2_JFA_tutorial_icsitalk.pdf)