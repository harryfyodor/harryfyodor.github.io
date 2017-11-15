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