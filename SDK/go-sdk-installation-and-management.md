# Go 安装与管理

+ 安装

  参考`go_install_sdk.sh`。

+ 包管理规范

  ```properties
  # sdk 安装目录
  GOROOT=/usr/local/go
  # 本地存放Go项目的目录
  GOPATH=/home/lee/go
  ```

  模块命名规范：`<域名>/<用户名>/<模块名>`，最好自己的模块也这么存，即`kwseeker.top/kwseeker/demo`。

  ```txt
  ➜  go pwd    
  /home/lee/mywork/go
  ➜  go tree -L 3
  .
  ├── github.com
  │   └── github
  │       └── gh-ost
  └── kwseeker.top
      └── kwseeker
          └── demo
  ```
  
  

