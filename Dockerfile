FROM debian:9

ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386
RUN echo 'Acquire::Retries "3";' > /etc/apt/apt.conf.d/99extraRetries \
	&& echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf.d/99norecommend \
	&& echo 'APT::Get::Install-Suggests "false";' >> /etc/apt/apt.conf.d/99norecommend \
	&& apt-get update \
    && apt-get install -y \
        build-essential \
        ca-certificates \
        lsb-release \
        python-dev \
        python3-dev \
		python3-pip \
		python-pip \
		python3-setuptools \
		pkg-config \
		python-setuptools \
  		cython \
		libssl-dev \
		default-jdk \
		build-essential ccache git libncurses5:i386 libstdc++6:i386 libgtk2.0-0:i386 libpangox-1.0-0:i386 libpangoxft-1.0-0:i386 libidn11:i386 \
		zlib1g-dev \
        sudo \
        vim \
		unzip \
		file \
    && dpkg-reconfigure ccache

RUN groupadd -r test && useradd -mg test test \
    && echo test ALL=NOPASSWD: ALL >> /etc/sudoers

USER test

ENV PATH=/home/test/.local/bin:/usr/lib/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN mkdir /home/test/.ccache
RUN pip3 install --user -U pip
RUN pip install --user -U pip
# RUN pip3 install --user https://github.com/kivy/buildozer/archive/master.zip
RUN git clone https://github.com/kivy/buildozer /home/test/buildozer
# RUN python3 /home/test/buildozer/setup.py build
RUN pip install --user -e /home/test/buildozer
WORKDIR /home/test/project
CMD buildozer android debug
