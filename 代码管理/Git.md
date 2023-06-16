# [Git](https://git-scm.com/book/zh/v2)

记录不是很常用但是比较有用的使用方法。

还是按照官方文档组织结构。

## [Git Docs](https://git-scm.com/docs)

### Branching and Merging

#### [git worktree](https://git-scm.com/docs/git-worktree)

有一个场景：当前正在某个分支下开发一个需求，突然接到临时特殊需求，需要切换到另一个分支，当前分支写到一半的代码怎么办？使用`git stash`暂存下或临时提交下然后切换分支？其实有更好的选择 `git worktree`。

一个仓库可以开多个工作树（工作区，默认只有一个），每个工作树映射到一个目录，相当于克隆了两套代码，但是这两套代码提交历史却是共享的。使用工作树可以支持开发人员在一套代码上同时开发多个需求（通常一个分支对应一个需求）。

```shell
# 查看工作树列表
git worktree list
# 当前项目目录是 my-project, 在项目根目录下执行下面命令，可以在项目同级目录中创建一个工作树目录，基于v1.0.0检出一个游离的节点（用于临时测试目的）
git worktree add ../my-project-temp v1.0.0                      # 从某个提交ID检出
# 针对上面的场景，可以从临时需求对应的分支上创建一个工作树目录，然后去新的工作树中处理临时需求，当前的工作不受任何影响
git worktree add ../my-project-temp branch-v1.0.0       # 从分支检出
```

## Git Book

### [贮藏与清理](https://git-scm.com/book/zh/v2/Git-工具-贮藏与清理)

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



