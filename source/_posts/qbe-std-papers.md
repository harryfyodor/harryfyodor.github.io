---
title: 关键词检索QbE-STD论文笔记
date: 2018-1-4 13:12:00
tags: ["语音识别", "关键词检索"]
---

常用QbE-STD有以下的几个步骤：
* 训练phone decoder
* 统计测试数据每一帧属于每一个phone分布的概率，生成Posteriorgram
phone posteriorgrams
Gaussian posteriorgrams
如果资源不丰富，可以使用其他语言来训练
* 使用DTW，计算距离
non-segmental DTW

### before 2015

#### USE OF ARTICULATORY BOTTLE-NECK FEATURES FOR QUERY-BY-EXAMPLE SPOKEN TERM DETECTION IN LOW RESOURCE SCENARIOS
使用articulatory BN features的高斯Posteriorgrams，对比phone BN features有更好的效果。BN features在多语言LVCSR中有很好的效果。Articulatory Speech Recognition在识别带噪声的语音时有更好的效果。
新加了一些分支，训练多层分支感知器。得到一些AR特征。
使用了non-segmental DTW。
对比了AR-CP，AR-BN，FDLP，FDLP + AR-CP/BN，其中 FDLP + AR-BN 效果最好。
对比了FDLP + AR-BN/PH-BN，其中 FDLP + AR-BN 效果最好。
用网络训练多层感知器，来确定分支特征（23）。用分支特征训练BN特征（13），加上FDLP（39）。

年份：2014
Database：MediaEval 2012 data, subset of Lwazi database
Toolkits：没有提及。
效果：ATWV 0.492
启发: 可以从训练特征入手，如果能做出更好的phone decoder就能得出更好的效果。可以结合不同的特征。特征可以用神经网络提取。

#### Unsupervised Spoken-Term Detection with Spoken Queries Using Segment-based Dynamic Time Warping
关注于检索项也是语音的情况，即无监督检索。
不使用frame-based feature vectors，使用自己分片段的DTW。使用segment-based DTW。
自己分segment的方法是聚类，最小化loss。Hierarchical agglomerative clustering。
Segment-based DTW的时候，小的分段会形成一个更高层的分段（超分段），然后超分段自行匹配。

年份：2010
Database：Mandarin broadcast news 自己的特征
Toolkits: 没有提及
效果：MAP 31.9% CPU time reduced 65.4%
启发：花样聚类，减少运算。基于DTW的改进方法。

#### Unsupervised Query-by-Example Spoken Term Detection using Bag of Acoustic Words and Non-Segmental Dynamic Time Warping
使用Bag of Acoustic Words (BoAW) index，使用NS-DTW。
在传统系统上增加上索引。
Robust indexing and retrieval techniques, along with a very efficient Non-Segmental DTW algorithm。
BoW在文字检索中常用。
N-gram indexing and Retrieval

年份：2014
Database：MediaEval 2012 data
Toolkits: 没有提及
效果：MTWV 0.3755
启发：可以借鉴文本检索的方法。对这方面了解比较少，还需要再去看。

#### Spoken Term Detection with Robust Multilingual Phone Recognition
使用PNCC特征。这种特征的抗噪性更好。
多语言的phone decoder。
对比了PNCC和MFCC。
使用了DTW。

年份：2014
Database：MediaEval 2014 data
效果：使用了normalized cross entropy cost，不好比较
启发：总结特征。文章很短。

#### Query-by-Example Spoken Term Detection using Frequency Domain Linear Prediction and Non-Segmental Dynamic Time Warping
使用了FDLP特征训练模型，得到Gaussian posteriorgrams。
使用了FNS-DTW，去除了冗余信息，速度更快，有性能损失。
较为详细地介绍了各种特征的提取。LPCC, MFCC, PLP, FDLP。
介绍了GMM的简单训练过程，介绍了NS-DTW，对比了S-DTW。

年份：2012
Database：MediaEval 2012
效果：MTWV 0.399 dev
启发：这篇文章写得比较细致全面，介绍了各种DTW和特征，后面可以参考。使用的方法比较传统，唯一有亮点的就是FNS-DTW。

需要实现的时候可以过来看这一篇文章。

#### Sparse Modeling of Posterior Exemplars for Keyword Detection
Sparse representation。
采用一种新的模板匹配方式。把关键词检索问题看成是测试样例子空间的分类问题。分类为背景和关键词。
进行dictionary learning。

年份：2015
Database：Numbers’95
启发：没有完全看明白，类似一种维度下降的方法。场景可能比较局限。可以学习一下Sparse representation。

#### PHONETIC UNIT SELECTION FOR CROSS-LINGUAL QUERY-BY-EXAMPLE SPOKEN TERM DETECTION
关注多语言的关键词，phone unit是否和目标语言匹配。
使用了subsequence DTW。距离相关度公式。cost的计算。
定义一个Relevance量：这一个量计算每一个音素单位的相关度，通过他们对cost的贡献程度来算。然后抛弃那些相关度最小的音素。
选择一个相关phone unit的方法。

年份：2015
Database：Albayzin 2014
工具：各种phone decoder
启发：1. 距离上可以搞一点小文章。很多文章都是这么做的。2. 在Posteriorgram上搞。

#### MEMORY EFFICIENT SUBSEQUENCE DTW FOR QUERY-BY-EXAMPLE SPOKEN TERM DETECTION
改进Subsequence DTW。更快，更小。
S-DTW在音乐上常用。提出Memory Efficient S-DTW。
S-DTW：固定起点，增长，看cost最小值。
两点改进：
1. trackback更方便
2. 归一化
附带伪代码，可以参考

年份：2013年
Database：Mediaeval 2012 SWS
效果：0.235MTWV增长，速度25%增长
启发：在DTW传统的方法本身想一些改进的地方。音乐上面的DTW可能可以找点参考。

#### Intrinsic Spectral Analysis Based on Temporal Context Features for Query-by-Example Spoken Term Detection
intrinsic spectral analysis (ISA) features 替代 Gaussian posteriorgrams
Laplacian eigenmaps / use temporal context information
非监督学习的方法

（不是非常懂）

年份：2014年
Database：TIMIT
效果：高于baseline 13.5%
启发：想着怎么用新的方法搞特征。比如autoencoder。

#### DOUBLE-LAYER NEIGHBORHOOD GRAPH BASED SIMILARITY SEARCH FOR FAST QUERY-BY-EXAMPLE SPOKEN TERM DETECTION
graph-based similarity search method
双层图，下层图用聚类。点是Posteriorgram，线是DTW相似度
kNN的方法，找出当前点距离最近的集合
对比了 Ordinary GSS 和 DLG based GSS。双层，更快。
图上用BFS寻找路径。

年份：2015年
Database：MIT lecture corpus
效果：快
启发：很新奇...转换成图的计算方法

#### Distinctive Feature Based Representation of Speech for Query-by-Example Spoken Term Detection
和之前的多层感知器有点相似，变成多分类问题。
binary distinctive features 替代原本的 Posteriorgram
Segmental DTW
双层SVM二分类，至少可以分成四类，然后就可以走一个分支
最终都是通过一定手段获得Posteriorgram（不是很懂这里计算概率的方法）
间接的方法

年份：2015年
Database：TIMIT
效果：EER 5.32
启发：多层感知器可以，那么多层SVM可以吗？多层LR可以吗？如果真的是多分类，用神经网络可以吗(考虑长度不一致)?

#### AN ACOUSTIC SEGMENT MODELING APPROACH TO QUERY-BY-EXAMPLE SPOKEN TERM DETECTION
无监督聚类的方法 ASM
ASM + HMM 代替 Gaussian Posteriorgram
步骤：
1. 初始化划分
2. 聚类，打标签
3. HMM训练，不停自己decode

年份：2012
Database：Fisher Corpus
工具：BUT-style [15] English (EN) phoneme recognizer，he Hungarian phoneme recognizer
启发：可以考虑怎样改进当前的Posteriorgram

### interspeech

### icassp