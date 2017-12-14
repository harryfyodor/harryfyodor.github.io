关键词检索实践基本系统

关键词检索实践

材料：
关键词检索实践的相关介绍主要有如下：
* kaldi官网介绍（从整体方面介绍了技术的相关使用，但是不够细节，好的地方是给出了一些简单的脚本，告诉你怎样就可以搭建一个系统。当然，相对最全面了
* Kaldi的babel脚本（整个比较乱，因为混杂了很多打分的文件，几乎无法剥离
* babel系统的介绍页面（讲解了整一个系统的方方面面

关键词检索系统的构建步骤
* 生成lattice，n-best的路线
* 进行关键词的数据准备
* 通过lattice建立关键词索引
* 在关键词的索引中进行搜索
* 讲结果写入文件中，统计
extra:
* 基于phone/syllable的关键词检索
* oov的检索

* lattice
:语音识别系统，进行decode生成lattice。对于一般的语音识别来说，就是在这些lattice的备选当中选择最佳的路径作为结果。对于一般的语音识别来说，我们就要这一条最好的路径了。但是对于关键词检索来说，一些备选的词中如果有评分比较高但是不在识别结果中的，也可以当做结果。基于lattice的关键词检索系统也是kaldi中主要的系统。

* 数据准备
根据kaldi上关键词检索的页面，我们需要准备三个文件：第一个文件是关键词列表，列表是我们想要检索的关键，第二个列表是使用的音频文件的相关信息，在脚本当中，其实我们使用的就只是它的时间长度信息而已，第三个是打分文件，这个打分文件比较难准备，需要对每个出现的关键词进行搜索和创建，很繁琐，还好不是必要的。
下面是相关的脚本：
```bash
local/generate_example_kws.sh $data_dir $kws_dir
local/kws_data_prep.sh $lang_dir $data_dir $kws_dir
duration=`feat-to-len scp:/home/harry/kaldi/egs/thchs30/s5/data/mfcc/train/feats.scp  ark,t:- | awk '{x+=$2} END{print x/100;}'`
```
第一个脚本生成了一个列表，随机抽取了里面的一些单词
重点看第二个脚本：第二个脚本生成了一系列的文件，utt_id,keywords.fsts，iv，oov，方便后面的处理。注意其中的lang\_dir。我们使用lang\_dir里面主要两个文件，一个是words文件，一个是lexcion文件。lexicon会对应到词。
第三个获取得到音频文件的总长度，这也是后面要用到的。

* 索引建立
索引的建立需要参考前面的理论介绍。这里也要传入lang\_dir。需要注意的words和lexicon要统一。如果是一遍训练到底的话不会有这样的问题，但是使用其他模型的时候要注意。
```bash
steps/make_index.sh --cmd "$decode_cmd" --acwt 0.1 \
    $kws_dir $lang_dir \
    $decode_dir \
    $decode_dir/$kws_work_dir
```

* 在索引中进行检索
将一个词的lexcion合并到当前的索引当中，选择最短路径，看最后的WFST输出是什么样的的。输出的结果包含了时间的信息作为索引的结果。
相同读音的词也会被检索出来，作为结果。
这一步生成了的文件在exp/kws当中。非常有用的文件。result。格式如下所示。可以看到，已经获得了这些。相关信息。
```bash
steps/search_index.sh --cmd "$decode_cmd" \
        $kws_dir \
        $decode_dir/$kws_work_dir
```

* 写入，统计
接下来就可以自己写脚本统计一下检索的准确程度。我们可以看看等错率曲线，找住最合适的点。

* 实践结果如下所示：


* 基于subword的检索
本质上
创建新的语言模型
生成新的lattice，可以通过检索新生成，也可以通过一个脚本，直接讲lattice从基于word变成基于syll的

* oov的检索
我们需要一个词，实际上是需要这个词的读音。从刚刚的那个示例就可以看得出来。对于字典中没有的词，我们需要使用g2p模型进行创建。
这里我们要用到混淆矩阵。讲相近读音的phone标注出来，其实就是为了把读音近似的词给找出来。proxy，虚拟词。

```bash

#!/bin/bash

. ./path.sh
. ./cmd.sh
. ./utils/parse_options.sh

# configuration
min_lmwt=7
max_lmwt=17
max_states=
skip_scoring=true
lang_dir=data/lang_chain
data_dir=/home/harry/kaldi/egs/thchs30/s5/data/mfcc/train
decode_dir=exp/chain/tdnn/thchs_train
kws_dir=data/kws_train_tri3

stage=0
duration=`feat-to-len scp:/home/harry/kaldi/egs/thchs30/s5/data/mfcc/train/feats.scp  ark,t:- | awk '{x+=$2} END{print x/100;}'`

if [ $stage -le -1 ]; then
    local/generate_example_kws.sh $data_dir $kws_dir
fi

if [ $stage -le 0 ]; then
    # -> input: data/kws/kwlist.xml
    local/kws_data_prep.sh $lang_dir $data_dir $kws_dir
    # -> output: data/kws
fi

if [ $stage -le -1 ]; then
    # -> input: data/kws/kwlist.xml
    local/kws_data_prep_syllables.sh --silence-word "<oov>" $lang_dir $data_dir $lang_dir/lex.words2syllabs.txt $kws_dir 
    # -> output: data/kws
fi

kws_work_dir=kws_tri3_new

if [ $stage -le 2 ]; then
    steps/make_index.sh --cmd "$decode_cmd" --acwt 0.1 \
        $kws_dir $lang_dir \
        $decode_dir \
        $decode_dir/$kws_work_dir
fi

if [ $stage -le 3 ]; then
    steps/search_index.sh --cmd "$decode_cmd" \
        $kws_dir \
        $decode_dir/$kws_work_dir
fi

if [ $stage -le 4 ]; then
    mkdir $decode_dir/$kws_work_dir/folder_result
    cp $decode_dir/$kws_work_dir/result* $decode_dir/$kws_work_dir/folder_result
    gzip -d $decode_dir/$kws_work_dir/folder_result/* 

    awk '{print $2" "$1}' $kws_dir/utter_id > $kws_dir/utter_map

    cat $decode_dir/$kws_work_dir/folder_result/result.* | \
    utils/write_kwslist.pl --flen=0.01 --duration=$duration \
        --normalize=true --map-utter=$kws_dir/utter_map \
        - $decode_dir/$kws_work_dir/kwslist.xml
fi

echo "Done."

```


