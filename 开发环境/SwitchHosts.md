# SwitchHosts

一款用于管理和切换 Host 配置信息的工具；可以根据项目或环境分别配置 Host 映射信息，开启某个配置会将这个配置中的Host映射信息添加到系统 Hosts 中，即添加到 /etc/hosts。

很方便用于解决本地启动的应用访问docker容器中的中间件时，无法将以容器名命名Host转换为IP的问题，（这个原因是因为本地无法使用 Docker 容器中内置的 DNS 服务，只能手动修改 /etc/hosts），SwitchHosts 可以方便的对 Hosts 配置进行管理，可以实现一键切换。

SwitchHosts Linux 系统下是 AppImage 文件，虽然可以直接运行但是还是想将其加入系统应用列表；

可以通过 AppImageLauncher安装 AppImage:

```shell
# 先装AppImageLauncher
sudo add-apt-repository ppa:appimagelauncher-team/stable
sudo apt-get update
apt install appimagelauncher
# AppImageLauncher安装 SwitchHosts 的AppImage
AppImageLauncher /home/arvin/bin/SwitchHosts/SwitchHosts_linux_x86_64_4.2.0.6105.AppImage
```

