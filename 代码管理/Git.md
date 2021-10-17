# [Git](https://git-scm.com/book/zh/v2)

记录不是很常用但是比较有用的使用方法。

还是按照官方文档组织结构。

## 7. Git 工具

### 7.3 [贮藏与清理](https://git-scm.com/book/zh/v2/Git-工具-贮藏与清理)

+ **清理工作目录**

  ```shell
  # 使用方法 & 详情
  git clean -h
  git clean --help
  # 强制删除untracked文件（不包括gitignore中指定的untracked文件）
  git clean -f
  # 强制删除untracked文件和目录（不包括gitignore中指定的untracked文件和目录）
  git clean -fd
  # 强制删除untracked文件和目录，包括gitignore中指定的untrack文件和目录（慎用）
  git clean -xfd
  # 在用上述 git clean 前，建议加上-n或-i参数先看看会删掉哪些文件然后进行删除操作
  git clean -nxfd
  git clean -nf
  git clean -nfd
  ```



