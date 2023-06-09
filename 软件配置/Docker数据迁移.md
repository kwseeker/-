# Docker 磁盘空间不足数据迁移

Linux本地环境，Docker默认安装在 /var/lib/docker, 随着使用，数据目录越来越大， 最近发现很多容器起不来，查日志发现都是报告磁盘空间不足，比如 ES、SkyWalking。需要将Docker数据移到另一个更大的磁盘。

迁移方法参考：[docker磁盘空间不足之数据迁移解决方案](https://www.cnblogs.com/gide/p/15957682.html)

注意数据迁移用的 `rsync -avz /var/lib/docker /mydisk/docker/lib/`，`rsync`是一种快速、多功能、可靠且灵活的远程/本地文件复制同步工具，用于在计算机之间同步或备份文件和目录。它使用快速的算法来最小化需要传输的数据，并可以从无连接的数据流断点续传可能失败的传输。`rsync`支持不同的协议用于数据传输，例如：SSH、rsync daemon、plain sockets。在Linux和Unix系统中，`rsync`通常预先安装，可以通过终端命令行使用。
-a选项表示以归档模式复制，包括所有子目录、文件权限和元数据；
-v选项表示详细显示复制进程信息；
-z选项表示使用压缩技术优化传输速度。

