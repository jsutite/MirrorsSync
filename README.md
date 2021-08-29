# MirrorsSync
ITE MIR189 镜像服务组件

## ITE MIR189 (开源镜像) 同步脚本使用说明

本例中使用 CentOS 7。

### 安装依赖

首先需要安装 `git, rsync, nginx, createrepo` ，其中 `nginx` 需要使用 `EPEL` 源才能下载。

```shell
sudo yum install -y epel-release
sudo yum install -y git rsync nginx createrepo
```

### 配置Nginx

首先需要确认仓库盘的分区。本例中，大分区挂载在 `/home` 下：

```shell
[root@localhost ~]# df -Th
文件系统                类型      容量  已用  可用 已用% 挂载点
devtmpfs                devtmpfs   32G     0   32G    0% /dev
tmpfs                   tmpfs      32G     0   32G    0% /dev/shm
tmpfs                   tmpfs      32G  9.0M   32G    1% /run
tmpfs                   tmpfs      32G     0   32G    0% /sys/fs/cgroup
/dev/mapper/centos-root xfs        50G  2.9G   48G    6% /
/dev/sda1               xfs      1014M  156M  859M   16% /boot
/dev/mapper/centos-home xfs       733G  6.6G  727G    1% /home
tmpfs                   tmpfs     6.3G     0  6.3G    0% /run/user/0
```

接着创建镜像文件夹，本例中在 `/home/mirrors/` 下创建了 `centos` 和 `epel` ：

```
mkdir -pv /home/mirrors/{centos,epel}
```

然后配置 Nginx 。 Nginx 的配置文件是 `/etx/nginx/nginx.conf` ，也可能是在 `/etx/nginx/default.d/` 下或者在 `/etx/nginx/conf.d/` 下。本例在 `/etx/nginx/nginx.conf`：

```
nano /etx/nginx/nginx.conf
```

要修改的地方不外乎四点：

1. `user nginx` 改成 `user root` ;
2. 在 `server {}` 下， `root /var/www/html` 改成 `root /home/mirrors` ;
3. 在 `server {}` 下， 添加
```
        autoindex on;
        autoindex_exact_size on;
        autoindex_localtime on;
```
4. 在 `server {}` 下， 将 `error_page` 注释掉：
```
        #error_page 404 /404.html;
        #location = /404.html {
        #}

	      #error_page 500 502 503 504 /50x.html;
        #location = /50x.html {
        #}
```

最后 `Ctrl+O` `Ctrl+X` 保存退出。

```
systemctl restart nginx
```

重启Nginx服务。

### 配置rsync 和 createrepo

<!--外网连不上，清华源来凑-->

检查源是否可用：

```
rsync --list-only rsync://mirrors.tuna.tsinghua.edu.cn/centos/
rsync --list-only rsync://mirrors.tuna.tsinghua.edu.cn/epel/
```

下载同步脚本并设置自动更新：

```
git clone https://github.com/jsutite/MirrorsSync.git
cd MirrorsSync
sudo chmod 777 sync.sh
crontab -e
```

Crontab中设置每天0点更新：

```
0 0 * * * /root/sync-scripts/sync.sh
```

