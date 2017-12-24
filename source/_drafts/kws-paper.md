---
title: 近两年的关键词检索论文
date: 
tags: ["语音识别", "关键词检索"]
---

### interspeech2016

#### A Nonparametric Bayesian Approach for QBE 
SOA speech recognition -> data-intensive
low rescource -> discovery of acoustic unit
A Nonparametric Bayesian Approach
类别：QBE
机构：Temple University

#### A discriminative score calibration method
Traing an MLP classirfier，employ the word posterior probability & several novel normalized scores
LSTM-CTC based verification method -> add extra info
类别：Score
机构：清华信息科学与技术实验室

#### Audio word2vec: Audio Segment Representations using Seq-to-Seq Autoencoder
Use vector to describe the Seq phonetic structures
DTW
RNN LSTM
DTW的帧信息使用这个自编码器编出来的vector
类别：DTW,QEB
机构：台湾大学，电子与计算机学院

#### State-Level Spotting and Posterior-based acoustic match for improved QBE
combine feature-based acoustic match
1. acoustic model state seqs used for speech segments
2. DTW feature generated by DNN
3. Logisitic Regression
类别：OOV，DTW
机构：静冈大学

#### Phone Confusions using restricted recognition
Data Sparseness in standard confusion matrices -> capture additional similarities
Enhanced CM -> 每个循环排除一个acoustic model
类别：Phone based，Confused Matrix
机构：University College Dublin，爱尔兰


#### Fusion Strategies -> robust
Robust acoustic features
-> train individual acoustic models
feature combination feature-map combination
类别：Noise-robust
机构：SRI international，Berkeley，CMU etc

#### Generating complementary acoustic model spaces in DNN-based sequence-to-frame DTW scheme for oov
1. DNN，GMM -> seq-to-frame DTW
2. combine -> different subword units and acoustic models
DNN better
类别：OOV，DTW特征
机构：Tsukuba Uni

#### LM Data Augmentation for KWS in Low-Resourced
extend from machine trainslation
character-based rnn -> new word, less oov
类别：LM，data augmentation，OOV
机构：Université Paris–Saclay

#### Multi-task learning and Weighted Cross-entropy for DNN-based KWS
Multi-task: predict the keyword-specific phone states; predict LVCSR senones.
Combine: LVCST-initialization, Multi-task training, CE
类别：DNN
机构：Amazon

#### Update of Multilingual Deep Neural Network for Low-Resource Keyword Search
select enough acoustic conditions
CE
类型：Multilingual DNN，Low resource
机构：新加坡IIR，腾讯

#### RNN-based Phoneme Sequence Estimation using Multiple ASR Systems’ Outputs for STD
Phoneme sequence estimation RNN-based
Reduce ASR errors to obtain good STD results
类型：Phone based
机构：University of Yamanashi

#### Segmented DTW for QBE
fusion of sub-sys
类型：DTW，QBE
机构：University of Coimbra, Portugal

#### Rescoring Hypothesized Detections of Out-of-Vocabulary Keywords Using Subword Samples
Rescoring hypothesized detections -> effective for iv
2 techniques
1. concatenation samples
2. splits hypos detections into segments, estimates the acoustic similarities between segments and the samples
类型：OOV
机构：南洋理工

#### Subspace Detection of DNN Posterior Probabilities via Sparse Representation QBE
subspace detection
DNN
类型：DNN，QBE
机构：Idiap Research Institute

#### Toward High-Performance Language-Independent QBE for MediaEval 2015: Post-Evaluation Analysis
DTW，WFST
train tokenizers handle noisy speech （data augmentation）
SOA
类型：QBE
机构：IIR，南洋理工

#### Unrestricted Vocabulary Keyword Spotting using LSTM-CTC
DL methods -> fixed keyword
phone lattice -> substring matching
类型：DNN
机构：上海交大

#### Unsupervised Bottleneck Features for Low-Resource QBE
DPGMM based labels to DNN
uBNF unsupervised feature learning
类型：feature
机构：IIR，南洋理工

#### Non-Uniform Boosted MCE Training of Deep Neural Networks for Keyword Spotting
non-uniform minimum classification error (MCE) criterion
类型：LVCSR