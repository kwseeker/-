# Linux安装Win软件

## wine (不推荐，配置复杂)



## PlayOnLinux

貌似游戏专用的。



## Bottles (推荐)

安装配置：只需要按官方文档一步步安装即可，使用的 flatpak 安装方式。

安装微信等软件：选择创建“Application”（创建一个沙箱环境）；然后修改配置只需要选择更换运行器为GE Wine：wine-ge-proton-8-7；最后选择执行软件安装程序exe。

为支持中文输入，需要配置环境变量：

```
GTK_IM_MODULE: fcitx
LANG: zh_CN.UTF-8
LC_ALL: zh_CN.UTF-8
QT_IM_MODULE: fcitx
XMODIFIERS: @im=fcitx
```

> 参考博客：https://blog.yswtrue.com/yong-bottles/

经测试，使用上面的配置，微信可以正常启动显示；企业微信可以安装成功并启动，但是登录窗口显示不出来；

QQ安装页面都展示不出来。

> Bottles安装后默认只有一个 soda 运行器（这个运行器试过了无法正常启动微信），需要手动下载 wine-ge；
>
> 这里下载有个坑：快捷方式启动的 Bottles，下载运行器会失败，最后查到这是 bottles 的 bug 需要使用 `flatpak run com.usebottles.bottles` 命令行启动 bottles，再尝试下载快的飞起，参考：https://github.com/bottlesdevs/Bottles/issues/2554

