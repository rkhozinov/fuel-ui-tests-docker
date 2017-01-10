FROM node:0.12.18

RUN  echo "deb http://ftp.cz.debian.org/debian/ jessie main\n" > /etc/apt/sources.list \
  && echo "deb http://ftp.cz.debian.org/debian/ jessie-updates main\n" >> /etc/apt/sources.list \
  && echo "deb http://security.debian.org jessie/updates main\n" >> /etc/apt/sources.list

ARG TZ
RUN echo "${TZ}" > /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

RUN cd /usr/local && \
    wget http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/46.0.1/linux-x86_64/en-US/firefox-46.0.1.tar.bz2 && \
    tar xjf firefox-46.0.1.tar.bz2 && \
    ln -s /usr/local/firefox/firefox /usr/bin/firefox

RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
     ssh \
     sshpass \
     openjdk-7-jre \
     libgtk-3-dev \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && apt-get -y autoremove

RUN npm install -g gulp
