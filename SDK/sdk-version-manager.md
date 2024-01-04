# SDK 版本管理器

适用于JDK的目前有三个：

+ **[Jenv](https://www.jenv.be/)**

  仅用于Java版本管理；

  可以为项目（jenv local）单独设置Java版本，不过现在IDE都支持选择JDK版本了；

  貌似不支持搜索安装JDK。

+ **[SDKMAN](https://sdkman.io/)**

  支持多种语言；

  跨平台；

  支持搜索安装JDK。

+ **[Jabba](https://github.com/shyiko/jabba)**

  支持多种语言；

  跨平台；

  支持搜索安装JDK。



## Jabba

个人倾向于用 Jabba。

安装后会修改bash配置文件，会插入

```
[ -s "/home/arvin/.jabba/jabba.sh" ] && source "/home/arvin/.jabba/jabba.sh"
```

即如果此文件存在就在当前环境下执行 jabba.sh。

```shell
export JABBA_HOME="$HOME/.jabba"

jabba() {
    local fd3=$(mktemp /tmp/jabba-fd3.XXXXXX)
    (JABBA_SHELL_INTEGRATION=ON $HOME/.jabba/bin/jabba "$@" 3>| ${fd3})
    local exit_code=$?
    eval $(cat ${fd3})
    rm -f ${fd3}
    return ${exit_code}
}

if [ ! -z "$(jabba alias default)" ]; then
    jabba use default
fi
```

从上面Shell文件可以看到电脑每次重启后会先查看有没有指定默认版本，有才会启用默认版本，否则不会做任何事，即**需要配置默认别名的值 `jabba alias default xxx`**。

**常用命令**：

```shell
# 默认会安装最新版本
curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash && . ~/.jabba/jabba.sh
# 查询 openjdk
jabba ls-remote | grep openjdk
jabba install openjdk@1.11.0
jabba install openjdk@1.17.0
# 查看本地已安装的SDK, 默认安装到 ~/.jabba/jdk
jabba ls
# 指定默认版本（很重要，不指定的话重启后之前执行的jabba use会失效）
jabba alias default openjdk@1.17.0
# 查看默认版本
jabba alias default
# 选择使用的版本, $JAVA_HOME也会被修改,但是 $JRE_HOME不会被修改
jabba use default
echo $JAVA_HOME
#/home/arvin/.jabba/jdk/openjdk@1.17.0
echo $JRE_HOME    
#/usr/lib/jvm/default-java/jre，还是之前的值

# 也可以在不同的仓库中创建.jabbarc指定此仓库中使用的Java版本
echo "openjdk@1.15.0" > .jabbarc
```

