FROM node:0.10.37

RUN  echo "deb http://ftp.cz.debian.org/debian/ jessie main\n" > /etc/apt/sources.list \
  && echo "deb http://ftp.cz.debian.org/debian/ jessie-updates main\n" >> /etc/apt/sources.list \
  && echo "deb http://security.debian.org jessie/updates main\n" >> /etc/apt/sources.list

ARG TZ
RUN echo "${TZ}" > /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
     ssh \
     sshpass \
     openjdk-7-jre \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && apt-get -y autoremove

RUN npm install -g gulp
