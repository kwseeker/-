# adb + tcpdump + wireshark Android抓包

1. 安装[Android平台工具包](https://dl.google.com/android/repository/platform-tools-latest-linux.zip?hl=zh-cn)，包含adb；

2. 手机开启开发者选项并打开USB调试(调整到`传输文件/Android Auto`, 如果是`仅充电`是无法识别设备的)；

3. 查看usb设备；

   ```shell
   $ lsusb
   Bus 001 Device 026: ID 18d1:4ee8 Google Inc. 4
   ```

4. Linux编辑 `/etc/udev/rules.d/51-android.rules `

    ```rules
    SUBSYSTEM=="usb", ATTRS{idVendor}=="18d1", 	ATTRS{idProduct}=="4ee8",MODE="0666",GROUP="plugdev"
    ```

5. Linux编辑 `~/.android/adb_usb.ini`

    ```ini
    # OPPO Find X5 Pro
    0x18d1
    ```

6. 重启adb

    ```shell
    sudo service udev restart  
    sudo adb kill-server
    sudo adb start-server
    sudo adb devices
    ```
    

7. 下载 [tcpdump](https://www.tcpdump.org/release/libpcap-1.10.3.tar.gz) 并传输到Android手机

   官网下载的需要先编译安装，但是因为本地环境版本等问题编译报错，

   选择下载从这个网站下载二进制文件 https://www.androidtcpdump.com/android-tcpdump/downloads

   然后推到Android文件目录

   ```shell
   adb push ~/tool/tcpdump /data/local/tmp/
   ```

8. 连接Android终端

   ```shell
   adb shell
   cd /data/local/tmp
   chmod +x tcpdump
   ```

   然后就可以在Android中启动tcpdump抓包了。

9. 静态抓包

   先使用tcpdump在Android上抓取数据并写入文件，然后将文件推到本地工作站上用Wireshark分析。

   这个不说了，使用起来比较麻烦。

10. 动态抓包

    在本地工作站上通过ssh远程登录Android手机并执行tcpdump抓包命令，输出数据实时发送给Wireshark分析。

    先保障Android和本地工作站在同一网络；

    然后在Android手机上安装SSH Server（这里用SSHDroid）并启动。

    使用SSH还是需要获取ROOT权限，不然无法执行 tcpdump 。

    ```shell
    # SSHDroid 默认端口是 2222
    scp -P 2222 ~/tool/tcpdump root@192.168.31.202:/data/data/berserker.android.apps.sshdroid/home
    ```

    