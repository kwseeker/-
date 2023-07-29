# Linux 桌面入口文件（.desktop）

位置： `/usr/share/applications/*.desktop`

## GoLand

```properties
[Desktop Entry]
Version=1.0
Type=Application
Name=GoLand
Icon=/opt/goland/bin/goland.svg
Exec="/opt/goland/bin/goland.sh" %f
Comment=Go IDE
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-goland
```

## drawio

新版本都是AppImage软件包，这种格式类似MacOS的软件包，不过不用挂载复制，可以直接运行，但是貌似Linux桌面系统对这种格式的软件支持的不好（并没有特定放这种软件的目录且不能自动识别快捷方式并通过快捷方式启动）还需要手动解压并创建快捷方式。

```shell
cd /opt/drawio
sudo ./drawio-x86_64-21.6.5.AppImage --appimage-extract
chmod -R a+rx squashfs-root
cp squashfs-root/drawio.desktop /usr/share/applications
```

修改desktop

```properties
[Desktop Entry]
Name=drawio
Exec=/opt/drawio/squashfs-root/AppRun
Terminal=false
Type=Application
Icon=/opt/drawio/squashfs-root/drawio.png
StartupWMClass=drawio
X-AppImage-Version=21.6.5
Comment=draw.io desktop
MimeType=application/vnd.jgraph.mxfile;application/vnd.visio;
Categories=Graphics;
```

