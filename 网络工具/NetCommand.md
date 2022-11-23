# Linux网络命令

+ **nsenter**

  可以在指定进程的命令空间中执行一个程序。

  一个最典型的用途就是进入容器的网络命令空间。相当多的容器为了轻量级，是不包含较为基础的命令的，比如说ip address，ping，telnet，ss，tcpdump等等命令，这就给调试容器网络带来相当大的困扰：只能通过docker inspect ContainerID命令获取到容器IP，以及无法测试和其他网络的连通性。**这时就可以使用nsenter命令仅进入该容器的网络命名空间，使用宿主机的命令调试容器网络**。

  命令说明

  ```shell
  nsenter [options] [program [arguments]]
  
  options:
  -t, --target pid：指定被进入命名空间的目标进程的pid
  -m, --mount[=file]：进入mount命令空间。如果指定了file，则进入file的命令空间
  -u, --uts[=file]：进入uts命令空间。如果指定了file，则进入file的命令空间
  -i, --ipc[=file]：进入ipc命令空间。如果指定了file，则进入file的命令空间
  -n, --net[=file]：进入net命令空间。如果指定了file，则进入file的命令空间
  -p, --pid[=file]：进入pid命令空间。如果指定了file，则进入file的命令空间
  -U, --user[=file]：进入user命令空间。如果指定了file，则进入file的命令空间
  -G, --setgid gid：设置运行程序的gid
  -S, --setuid uid：设置运行程序的uid
  -r, --root[=directory]：设置根目录
  -w, --wd[=directory]：设置工作目录
  ```

  比如查看docker容器TCP连接

  ```shell
  docker inspect -f '{{.State.Pid}}'  <containerId>
  # 进入容器进程的net命名空间执行netstat命令
  nsenter -t <containerPid> -n netstat | grep 9002
  # 进入该容器的网络命令空间
  nsenter -t <containerPid> -n
  # 退出该容器的网络命令空间
  exit
  ```

  > 进程的命名空间：Linux的命名空间机制提供了一种资源隔离的解决方案。PID,IPC,Network等系统资源不再是全局性的，而是属于特定的Namespace。Linux Namespace机制为实现基于容器的虚拟化技术提供了很好的基础，LXC（Linux containers）就是利用这一特性实现了资源的隔离。不同Container内的进程属于不同的Namespace，彼此透明，互不干扰。
  >
  > Linux在不断的添加命名空间，目前有：
  >
  > mount：挂载命名空间，使进程有一个独立的挂载文件系统，始于Linux 2.4.19
  > ipc：ipc命名空间，使进程有一个独立的ipc，包括消息队列，共享内存和信号量，始于Linux 2.6.19
  > uts：uts命名空间，使进程有一个独立的hostname和domainname，始于Linux 2.6.19
  > net：network命令空间，使进程有一个独立的网络栈，始于Linux 2.6.24
  > pid：pid命名空间，使进程有一个独立的pid空间，始于Linux 2.6.24
  > user：user命名空间，是进程有一个独立的user空间，始于Linux 2.6.23，结束于Linux 3.8
  > cgroup：cgroup命名空间，使进程有一个独立的cgroup控制组，始于Linux 4.6
  >
  > 查看进程的命名空间：`ll /proc/PID/ns`。

+ **setns**

  clone命令可以用于创建新的命令空间，而**setns则用来让当前线程（单线程即进程）加入一个命名空间**。

+ **netstat**

  ```shell
  usage: netstat [-vWeenNcCF] [<Af>] -r         
  	   netstat {-V|--version|-h|--help}
         netstat [-vWnNcaeol] [<Socket> ...]
         netstat { [-vWeenNac] -i | [-cnNe] -M | -s [-6tuw] }
  
  -r：--route，显示路由表信息
  -g：--groups，显示多重广播功能群组组员名单
  -s：--statistics，按照每个协议来分类进行统计。默认的显示IP、IPv6、ICMP、ICMPv6、TCP、TCPv6、UDP和UDPv6 的统计信息。
  -M：--masquerade，显示网络内存的集群池统计信息
  -v：--verbose，命令显示每个运行中的基于公共数据链路接口的设备驱动程序的统计信息
  -W：--wide，不截断IP地址
  -n：进制使用域名解析功能。链接以数字形式展示(IP地址)，而不是通过主机名或域名形式展示
  -N：--symbolic，解析硬件名称
  -e：--extend，显示额外信息
  -p：--programs，与链接相关程序名和进程的PID
  -t：所有的 tcp 协议的端口
  -x：所有的 unix 协议的端口
  -u：所有的 udp 协议的端口
  -o：--timers，显示计时器
  -c：--continuous，每隔一个固定时间，执行netstat命令
  -l：--listening，显示所有监听的端口
  -a：--all，显示所有链接和监听端口
  -F：--fib，显示转发信息库(默认)
  -C：--cache，显示路由缓存而不是FIB
  -Z：--context，显示套接字的SELinux安全上下文
  ```

  

## 参考

[nsenter命令简单介绍](https://blog.csdn.net/qq_35745940/article/details/119900634)

