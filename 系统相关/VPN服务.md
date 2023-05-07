# VPN服务搭建

代理服务商：https://okgg.top

[V2rayA在linux 下安装使用教程](https://zhuanlan.zhihu.com/p/414998586) (安装指令已经过时，主要参考里面使用V2RayA的教程)

[V2rayA手册](https://v2raya.org/docs/manual/transparent-proxy/)

## Linux + V2rayA

本机环境：Linux Mint 18

官方安装文档：https://v2raya.org/docs/prologue/installation/debian/ （如果本地已经有VPN的话，直接执行脚本就行）

如果本地VPN已经罢工，脚本中下载资源可能失败，需要先把V2ray内核和V2rayA的软件包下载下来。

```shell
# 安装 V2ray 内核
sudo bash < <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)
sudo bash < <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-dat-release.sh)
# 如果上面执行失败，先尝试下载
wget https://github.com/v2fly/v2ray-core/releases/download/v5.4.1/v2ray-linux-64.zip
# 移除 V2Ray
# sudo bash < <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh) --remove

# 安装 V2rayA
# 下载 v2rayA 并安装，https://github.com/v2rayA/v2rayA/releases
wget https://github.com/v2rayA/v2rayA/releases/download/v2.0.5/installer_debian_amd64_2.0.5.deb
# 启动 v2rayA
sudo systemctl start v2raya.service
# 设置开机自动启动
sudo systemctl enable v2raya.service

# 安装并启动后参考前面的使用教程配置即可
# 配置“透明代理”推荐使用“大陆白名单”，这种模式估计只有被墙的地址才会被代理
```

> Bash 中，`<<`，`<<<` 和 `< <` 都是输入重定向的方式，用于将一个命令的输出作为另一个命令的输入。
>
> - `<<` 为 Here Document，表示将一个文本块作为输入传递给命令。这个文本块以`<或者其他结束标记开始，以结束标记（比如`EOF`）结束。例如：
>
>   ```bash
>   $ cat <<EOF
>   > hello world
>   > EOF
>   ```
>
>   输出结果为：
>
>   ```bash
>   hello world
>   ```
>
> - `<<<` 为 Here String，表示将一个字符串作为输入传递给命令。这个字符串可以用单引号或者双引号括起来。例如：
>
>   ```bash
>   $ cat <<< "hello world"
>   ```
>
>   输出结果为：
>
>   ```bash
>   hello world
>   ```
>
> - `< <` 为 Process Substitution，可以将指定命令的输出作为文件名传递给另一个命令。例如：
>
>   ```bash
>   $ sort < <(echo -e "4\n2\n1\n3")
>   ```
>
>   输出结果为：
>
>   ```bash
>   1
>   2
>   3
>   4
>   ```
>
> 需要注意的是，`<<` 和 `<<<` 可以用于任何命令，而 `< <` 一般只有在需要将命令输出作为文件名时才会使用。同时，在使用 `<<<` 时需要注意，如果输入字符串中包含空格、变量等需要进行扩展的内容，则需要使用双引号括起来，否则可能会出现解析错误等问题。