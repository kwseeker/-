# 工作(Job)管理

参考: [**第十七章、程序管理与 SELinux 初探**](http://cn.linux.vbird.org/linux_basic/0440processcontrol.php)

这部分很常用，但是之前没有清晰的认识；所以这里补充下。

+ **前景&背景（后台）**

  一个shell窗口同时只能执行一个前景程序，为了可以同时工作多个shell程序，可以把shell程序丢到后台中执行（就是通过在执行命令尾部加 &）；

  程序放到后台中执行的话会分配一个**工作号码(job number)**, 并展示 **进程ID(PID)**。

  放到后台中执行的进程是无法被 **Ctrl + C** 杀死的（**SIGINT** 信号对后台进程无效）。

  但是仍然可能被**SIGHUP**杀死，进场需要退出shell终端也能继续运行，就需要使用 **nohup** 命令执行。

  nohup 意思是忽略 SIGHUP 信号。

  | 信号    | 说明                                                         |
  | ------- | ------------------------------------------------------------ |
  | SIGINT  | 发送给**前台进程组**中的所有进程。常用于**终止正在运行的程序**，一般由 `CTRL+C` 组合键触发 |
  | SIGTSTP | 发送给**前台进程组**中的所有进程，常用于**挂起并暂停一个进程**，一般由 `CTRL+Z` 组合键触发 |
  | SIGHUP  | 当用户退出 Shell 时，由该 Shell 开启的所有进程都会接收到这个信号，默认动作为**终止进程** |

  后台运行的进程还是默认把 **stdout** **stderr** 输出到shell窗口，日志很妨碍用户在窗口做其他操作。

  需要把输出重定向，比如：

  ```shell
  tar -zpcvf /tmp/etc.tar.gz /etc > /tmp/log.txt 2>&1 &
  ```

  `2>&1` 这里的**2就是表示错误输出 stderr**（比如脚本执行错误返回的信息），**0代表标准输入 stdin** ，**1代表标准输出 stdout**。

  这个片段表示将错误输出重定向到标准输出；注意区分 `2>1`这个指将错误输出重定向到一个名为1的文件（档案）。

  再看下tar那行命令的意思：将标准输出重定向到文件，再将错误输出重定向到标准输出，最终标准输出、错误输出都会被输出到文件，还窗口一个清净的世界。

  有时一点都不在乎输出的是什么就可以先把标准输出重定向到 /dev/null （不管往/dev/null输出什么都会被直接丢弃）, 再把错误输出定向到标准输出。

  ```shell
  ./some_bin > /dev/null 2>&1
  ```

+ **背景进程工作状态**

  + **暂停**(suspended)

    vi编辑一个文件编了一半，需要退出查些资料；这时不需要真退出，只需要 CTRL + Z 挂起（注意**需要在命令模式下才有效**）；这时vi进入后台 suspended 状态(不同系统可能不一样)，查完资料可以 jobs -l 查询工作编号，然后用 fg (foreground) 恢复挂起的工作到前台继续执行。

    工作编号后的“+”标识默认选中（直接 fg可恢复），相对的是“-” （fg %job_number）。

    ```shell
    job -l
    fg
    fg %1
    ```

    如果想让挂起的工作在后台继续执行，可以用 bg ;

    ```shell
    job -l
    bg
    bg %1
    ```

  + **运行中**（continued）

+ **kill 信号**

  可以 kill -l / -L 查看有哪些信号，详细 man 7 signal 。

  ```shell
  ~ sudo kill -L
  # -L 不知为何需要root权限才会展示
   1 HUP      2 INT      3 QUIT     4 ILL      5 TRAP     6 ABRT     7 BUS
   8 FPE      9 KILL    10 USR1    11 SEGV    12 USR2    13 PIPE    14 ALRM
  15 TERM    16 STKFLT  17 CHLD    18 CONT    19 STOP    20 TSTP    21 TTIN
  22 TTOU    23 URG     24 XCPU    25 XFSZ    26 VTALRM  27 PROF    28 WINCH
  29 POLL    30 PWR     31 SYS 
  ```

  常用的几种

  ```
  Signal     Value     Action   Comment
  ──────────────────────────────────────────────────────────────────────
  SIGHUP        1       Term    Hangup detected on controlling terminal or death of controlling process
  SIGINT        2       Term    Interrupt from keyboard
  SIGQUIT       3       Core    Quit from keyboard
  SIGILL        4       Core    Illegal Instruction
  SIGABRT       6       Core    Abort signal from abort(3)
  SIGFPE        8       Core    Floating-point exception
  SIGKILL       9       Term    Kill signal
  SIGSEGV      11       Core    Invalid memory reference
  SIGPIPE      13       Term    Broken pipe: write to pipe with no readers; see pipe(7)
  SIGALRM      14       Term    Timer signal from alarm(2)
  SIGTERM      15       Term    Termination signal
  SIGUSR1   30,10,16    Term    User-defined signal 1
  SIGUSR2   31,12,17    Term    User-defined signal 2
  SIGCHLD   20,17,18    Ign     Child stopped or terminated
  SIGCONT   19,18,25    Cont    Continue if stopped
  SIGSTOP   17,19,23    Stop    Stop process
  SIGTSTP   18,20,24    Stop    Stop typed at terminal
  SIGTTIN   21,21,26    Stop    Terminal input for background process
  SIGTTOU   22,22,27    Stop    Terminal output for background process
  
  HUP     1    如果想要更改配置而不需停止并重新启动服务，请使用该命令。在对配置文件作必要的更改后，
  					发出该命令以动态更新服务配置。
  					根据约定，当您发送一个挂起信号（信号 1 或 HUP）时，
  					大多数服务器进程（所有常用的进程）都会进行复位操作并重新加载它们的配置文件。
  INT       2    （同 Ctrl + C）是当用户键入<Control-C>时由终端驱动程序发送的信号。
  					这是一个终止当前操作的请求，如果捕获了这个信号，一些简单的程序应该退出，或者允许自给被终止，
  					这也是程序没有捕获到这个信号时的默认处理方法。拥有命令行或者输入模式的那些程序应该停止它们
  					在做的事情，清除状态，并等待用户的再次输入。
  QUIT    3    退出（同 Ctrl + \）
  TERM    15    终止
  					是请求彻底终止某项执行操作，它期望接收进程清除自给的状态并退出。
  KILL      9    强制终止
  CONT   18    继续（与STOP相反， fg/bg命令）
  STOP    19    暂停（同 Ctrl + Z）
  ```

  

  

