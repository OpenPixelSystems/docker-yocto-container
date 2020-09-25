FROM ubuntu:xenial

RUN apt-get update -y

RUN export DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/Europe/Brussels /etc/localtime
RUN apt-get install -y tzdata
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get install -y gawk wget git diffstat unzip texinfo gcc-multilib \
	build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
	xz-utils debianutils iputils-ping libsdl1.2-dev xterm

RUN apt-get install -y autoconf libtool libglib2.0-dev libarchive-dev python-git \
	sed cvs subversion coreutils texi2html docbook-utils python-pysqlite2 \
	help2man make gcc g++ desktop-file-utils libgl1-mesa-dev libglu1-mesa-dev \
	mercurial automake groff curl lzop asciidoc u-boot-tools dos2unix mtd-utils pv \
	libncurses5 libncurses5-dev libncursesw5-dev libelf-dev zlib1g-dev

RUN apt-get install -y vim-gtk3 ctags cscope tmux locales sudo

RUN /usr/sbin/locale-gen en_US.UTF-8


# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/bravl && \
    echo "bravl:x:${uid}:${gid}:Developer,,,:/home/bravl:/bin/bash" >> /etc/passwd && \
    echo "bravl:x:${uid}:" >> /etc/group && \
    echo "bravl ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/bravl && \
    chmod 0440 /etc/sudoers.d/bravl && \
    chown ${uid}:${gid} -R /home/bravl

RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo
RUN chmod a+x /usr/bin/repo

USER bravl
WORKDIR /home/bravl/

RUN git config --global user.email "bram.vlerick@openpixelsystems.org"
RUN git config --global user.email "Bram Vlerick"

RUN sudo update-alternatives --install /usr/local/bin/python python \
	/usr/bin/python 2

RUN sudo update-alternatives --install /usr/local/bin/python python \
	/usr/bin/python3 3

ENV LAN en_US.UFT-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN mkdir mnt
