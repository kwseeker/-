#!/bin/bash
# 注意默认下载go1.17.2.linux-amd64.tar.gz到用户根目录$HOME/downloads文件夹下，
# 安装在/usr/local/go，修改环境配置$HOME/.profile

# set -x

EXPORT_PATH="export PATH=/usr/local/go/bin:\$PATH"
PROFILE_PATH=$HOME/.profile
# echo $EXPORT_PATH

# wget -P $HOME/downloads/ https://golang.org/dl/go1.17.2.linux-amd64.tar.gz
# cd $HOME/downloads/
# rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.2.linux-amd64.tar.gz

if ! grep "$EXPORT_PATH" $PROFILE_PATH > /dev/null
then
    echo "Modify .profile ..."
    sed -i '$a # go sdk' $PROFILE_PATH
    sed -i '$a '"$EXPORT_PATH" $PROFILE_PATH
    source $PROFILE_PATH
else
   echo "Didn't modify .profile, already exist ..."
fi

go version
