#!/usr/bin/env bash

echo "=====Linux必要软件安装====="

echo "=====安装vim net-tools unzip wget git maven====="
yum install vim net-tools unzip wget git maven -y

echo "=====安装node14====="
wget https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/v14.15.1/node-v14.15.1-linux-x64.tar.gz

tar xf node-v14.15.1-linux-x64.tar.gz -C /usr/local

mv /usr/local/node-v14.15.1-linux-x64/ /usr/local/node14

echo '
export NODE_HOME=/usr/local/node14
export PATH=$NODE_HOME/bin:$PATH
' >> /etc/bashrc

source /etc/bashrc

ln -s /usr/local/node14/bin/npm /usr/local/bin/
ln -s /usr/local/node14/bin/node /usr/local/bin/

echo "=====node14版本====="
node -v

echo "=====npm 版本====="
npm -v

rm -rf node-v14.15.1-linux-x64
