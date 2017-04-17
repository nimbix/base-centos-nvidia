FROM nvidia/cuda:8.0-cudnn5-devel-centos7
MAINTAINER Nimbix, Inc. <support@nimbix.net>

# base OS
ADD https://github.com/nimbix/image-common/archive/master.zip /tmp/nimbix.zip
WORKDIR /tmp
RUN yum -y install sudo zip unzip && unzip nimbix.zip && rm -f nimbix.zip
RUN /tmp/image-common-master/setup-nimbix.sh
RUN yum -y install module-init-tools xz vim openssh-server libmlx4 libmlx5 iptables infiniband-diags make gcc gcc-c++ glibc-devel curl libibverbs-devel libibverbs librdmacm librdmacm-devel librdmacm-utils libibmad-devel libibmad byacc flex git cmake screen grep && yum clean all

# Nimbix JARVICE emulation
EXPOSE 22
RUN mkdir -p /usr/lib/JARVICE && cp -a /tmp/image-common-master/tools /usr/lib/JARVICE
RUN cp -a /tmp/image-common-master/etc /etc/JARVICE && chmod 755 /etc/JARVICE && rm -rf /tmp/image-common-master
RUN mkdir -m 0755 /data && chown nimbix:nimbix /data

