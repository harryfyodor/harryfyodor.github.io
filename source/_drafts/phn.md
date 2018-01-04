貌似可以完整跑的：
local/search/run_phone_search.sh
local/search/run_syll_search.sh

用来生成train.phn，准备lang.phn
local/syllab/run_phones.sh
local/syllab/run_syllabs.sh

貌似可以用来进行kws数据准备的
local/kws_data_prep_syll

#!/bin/bash

. ~/.nvm/nvm.sh

GIT_REPO=/home/harry/git/blog.git        # 空 Git 仓库的文件夹，触发 hook 时已经存入了内容
TMP_GIT_CLONE=/tmp/hexo                  # 缓存文件夹，存在 /tmp 下可以随意读写
PUBLIC_WWW=/home/harry/harryfyodor/harry-blog                 # 之前创建的 blog 文件夹，用作网站主目录

cd $TMP_GIT_CLONE
rm -rf _config.yml db.json scaffolds public themes package.json source            # 删除缓存的全部内容
git clone $GIT_REPO ${TMP_GIT_CLONE}/main       # 将 Git 仓库被上传的内容写入缓存

cp -rf ${TMP_GIT_CLONE}/main/* ${TMP_GIT_CLONE}
rm -rf ${TMP_GIT_CLONE}/main

hexo g

rm -rf ${PUBLIC_WWW}/*                   # 删除网站主目录全部内容
cp -rf ${TMP_GIT_CLONE}/public/* ${PUBLIC_WWW}  # 将缓存目录所有内容复制到主目录

sudo service nginx restart