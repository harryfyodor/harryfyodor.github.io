---
title: 关键词检索论文小结
tags: ["语音识别"]
---

### 经典论文

#### Speech recognition with weighted finite-state transducers
这篇论文是介绍语音识别解码器的经典论文。

### Kaldi页面引用的论文

#### Recent development in spoken term detecion: a survey
文章总结了关键词检索面临的挑战和发展的历史。
关键词检索的方法又分为了两种类型：有监督和无监督。两种类型又分别有许多种方法。

有监督检索：
* 基于声学关键词 | 补白模型
* 基于LVCSR | 解码成Lattice之后进行进行处理，比如转化成混淆矩阵
* 基于Subword | Lattice以音节音素为单位，Lattice还可以转化为WFST索引进行搜索
* QBE | oov的词汇，通过g2p工具生成，再通过音素Lattice进行下面的检索
* 基于Event 等等非传统方法

无监督检索：
* 基于帧/段的模板匹配 | 主要的DTW的变种

#### Generating exact lattices in the WFST framework
本文讲解了Kaldi中如何使用HCLG进行解码。
具体算法流程。

#### Using proxies for oov keywords in the keyword search task
Kaldi中使用的解决oov情况的方案。这个方法基于LVCSR以及WFST。oov的单词通过g2p方法生成读音；集内的词直接通过WFST索引检索。虚拟关键词通过音素的混淆矩阵生成，然后通过WFST直接得到关键词的相关位置信息。
（公式）
其中的K指的是代表该oov的FSA；L2指的是g2p生成的oov的lexicon；E指的是音素混淆矩阵。
这样可以得到结果列表，但是误警率比较高。合并上原本的L1可以有改善。

#### Lattice indexing for spoken term detection
Kaldi中使用的进行关键词检索的关键算法。

#### Sequence-discriminative training of deep neural networks
神经网络在声学模型中训练过程中的作用。

### 补充理解的论文

#### Unsupervised spoken keyword spotting via segmental DTW on gaussian posteriorgrams
讲述了SDTW算法进行STD的细节。
* 无监督聚类，不用文本
* 计算求posteriogram
* 动态规划DTW，寻找最优路径；设置R值，让帧之间的偏差不要太大
* 变换起点，变更区域，找到最合适的区域
* 利用起多个keyword样本的数据，找到"平均失真分数”最低

### 国内博士论文

#### 语音关键词检索若干问题研究
#### 基于WFST的语音查询项检索技术研究

### 比较新的论文

### to be continued

开题报告题目：语音关键词检索系统研究
选题的目的语音关键词检索是语音识别的一个子领域，它指的是根据用户输入的查询项，在大量语音资源中快速搜索并返回相关信息的过程。这项技术在安全领域，搜索领域都具有广泛的应用前景。
选题的目的是为了深入理解语音关键词检索领域，熟悉该领域内相关的基本方法和原理，并在此基础上思考如何做出改进。
当前语音关键词检索领域遇到的问题和挑战有：检索的效果需要提高，更快的搜索速度，解决OOV的问题，语音的"变形" (口音问题等)，对应语言资源不足等。
语音关键词识别问题有两种，一种是检索的词在词典当中，一种是集外词。当前较为主流的方法是使用基于LVCSR系统，利用WFST索引进行检索的方法。在当前最常用的语音识别工具集Kaldi中便是使用这种方法。这种方法可以很好地完成检索集内词和集外词的检索任务。
下面对该语音关键词检索方法的系统进行简要介绍：
1. 首先先构建基础的语音识别系统(LVCSR)，然后根据该系统生成出N-best的网格。网格的弧所代表的含义可以选择单词，也可以选择音节或者音素等子词。当需要进行集外词检索的时候便可以使用子词。
2. 利用混淆矩阵，将生成的网格转变成混淆网络。这样做的目的是缩小搜索的空间，提高搜索效率。同样，混淆网络的语音单元也可以根据需要选择单词或者子词。
3. 把混淆网络生成的转化成FSA，在转换成WFST索引。索引的弧的输出使用语音单元的起始时间，结束时间和后验概率。转换的过程包括：预处理进行聚类，构建TFT(Timed Factor Transducer)。
4. 将被检索词转化成FSA，与WFST索引进行合并，寻找最优路径，从而找到关键词的位置。
在上面技术搭建的整体框架上，我准备先搭建一个基础系统，然后再思考如何在当前系统的基础上进行改进。
相关支持条件有：在Kaldi工具集已经实现完成的baseline系统，以及实验室相关的硬件支持。
进度安排：熟悉语音关键词检索领域的相关背景知识；* 了解语音关键词检索常用的方法；* 深入学习语音关键词识别的最主流的方法，基于混淆矩阵，WFST；* 利用Kaldi工具集实现关键词检索baseline系统；* 在baseline系统上研究如何进行改进；* 完成论文的写作。