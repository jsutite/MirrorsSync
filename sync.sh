#!/bin/bash

#/usr/bin/rsync -avz rsync://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/ /home/mirrors/ubuntu-releases && /usr/bin/createrepo /home/mirrors/ubuntu-releases
#/usr/bin/rsync -avz rsync://mirrors.tuna.tsinghua.edu.cn/kali-images/ /home/mirrors/kali-images && /usr/bin/createrepo /home/mirrors/kali-images
/usr/bin/rsync -avz rsync://mirrors.tuna.tsinghua.edu.cn/centos/ /home/mirrors/centos && /usr/bin/createrepo /home/mirrors/centos
/usr/bin/rsync -avz rsync://mirrors.tuna.tsinghua.edu.cn/epel/ /home/mirrors/epel && /usr/bin/createrepo /home/mirrors/epel
