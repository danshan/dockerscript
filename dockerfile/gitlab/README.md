# GitLab Docker Build Script

该 Dockerfile 将在 [Ubuntu 14.04](https://github.com/danshan/dockerscript/tree/master/dockerfile/ubuntu) 上构建基于 Docker container 的 [GitLab 6.4](http://www.gitlab.com/) 服务.

## Installation

跟着下面的教程去下载或构建 GitLab.

### Step 0: Install Docker

[按照此步骤](http://www.docker.io/gettingstarted/#h_installation) 安装 docker 服务.

### Step 1: Pull Or Build GitLab

Docker 安装并运行后, 通过任意一种方式都可以按照好 GitLab.

**Pull From Docker Index:**

    docker pull danshan/gitlab

**Build It Yourself**

    git clone https://github.com/danshan/dockerscript.git
    cd dockerscript/gitlab
    docker build -t gitlab .

由于 GitLab 有很多的依赖包, 不管是 pull 还是通过 Dockerfile 构建, 都会消耗不少时间. 相比而言, 可能 pull 会相对快一点点.

### Step 2: Configure GitLab

如果你是通过 pull 的方式获取了 GitLab 镜像, 而没有 clone GitHab的代码库, 现在需要按照下面的步骤做一些简单的配置.
代码库中 config/ 文件夹包含了一些在创建新的 container instance 前你需要修改的配置文件.

* **gitlab.yml**: 修改 host 字段与你创建的 GitLab instance 一致. 
配置文件中 *Advanced settings* 下面, 修改 *ssh_port* 的配置, 去配置 GitLab Shell 中的 GitLab 寄主机 和容器的 22 端口的映射端口. 
如果你使用了一个非标准的端口而没有配置这个, 你讲无法通过 git/ssh url 去 commit 变更.
同样, 其它的一些修改, 比如 LDAP 的配置等, 都是在这个文件进行配置.
* **database.yml**: 在 *production* section, 去为 GitLab 的 MySQL 数据库去配置 password.
* **nginx**: 替换 YOUR_SERVER_FQDN 为你的 GitLab instance 的 hostname. 同样, 这个文件可以用来配置一些其他的信息, 如 SSL/TLS 等配置.

另外, 可以通过修改 **firstrun.sh** 中的 mysqlRoot 变量去配置 MySQL 的 root 用户的 password.

### Step 3: Create A New Container Instance

此次构建通过使用 Docker 的特性去将寄主机的目录和容器中的目录做映射. 这样做是为了实现将用户的个性化配置在第一次容器启动时插入到容器中.
另外, 由于数据是保存在容器之外的, 它允许用户将这这些文件夹保存在更高速的存储介质, 如SSD, 以获取更高的性能.

创建 Container instance, 运行下面的命令:

    cd /path/to/gitlab-docker

下面, 如果你是通过 pull 的方式获取的 docker image, 执行这个命令:

    docker run -d -v /path/to/gitlab-docker:/srv/gitlab -name gitlab crashsystems/gitlab-docker

或者, 如果你是自己 build 的镜像, 执行这个命令:

    docker run -d -v /path/to/gitlab-docker:/srv/gitlab -name gitlab gitlab

*/path/to/gitlab-docker* 表示在 Docker 寄主机中 git clone 时创建的文件夹, 它将包含 GitLab instance 的数据. 
请确认在运行 container 前, 将它移动到了一个期望的位置.
同样, 第一次启动 container 将比较耗时, 因为 firstrun.sh 脚本会将被调用去完成很多初始化的任务.

##### Default username and password
GitLab 会在配置时创建 admin 的帐号, 你可以通过它登录 GitLab:

    admin@local.host
    5iveL!fe

## Experimental: GitLab update via container rebuild

如果需要在这个构建的基础上去更新 GitLab 服务, 流程如下所示:

1. 从 Docker index 服务器去更新该脚本的最新版本, 或者 git pull 代码库后重新构建. 
2. 停止当前运行的 instance, 并通过 docker rm 去移除它.
3. 在 gitlab-docker/ 文件夹中, 执行 *git checkout firstrun.sh* 去复原 firstrun.sh 脚本.
4. 修改 firstrun.sh, 并删除标题为 "Delete this section if restoring data from previous build." section. 使用任意的新版本数据库迁移代码去替换这一段.
5. 重新执行上文 installation instructions 中的 step 3.

注意, 这个步骤还在测试中, 关于数据库的迁移还没有测试, 因此任何时间你需要做升级操作前, [做好备份](https://github.com/gitlabhq/gitlabhq/blob/master/doc/raketasks/backup_restore.md).
