#FROM base
#ARG FUEL_WEB_REQS
#RUN pip install --upgrade pip && \
#    pip install -r $FUEL_WEB_REQS && \
#    pip install --upgrade tox
FROM node:0.12.18

#RUN  echo "deb http://ftp.cz.debian.org/debian/ jessie main\n" > /etc/apt/sources.list \
#  && echo "deb http://ftp.cz.debian.org/debian/ jessie-updates main\n" >> /etc/apt/sources.list \
#  && echo "deb http://security.debian.org jessie/updates main\n" >> /etc/apt/sources.list

ARG TZ
RUN echo "${TZ}" > /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update && \
    apt-get install --yes software-properties-common && \
    apt-get -y update && \
    apt-get -y dist-upgrade && \
    apt-get -y upgrade && \
    apt-get install --yes --reinstall postgresql-client \
                                      openjdk-7-jdk \
                                      python-dev \
                                      python-pip \
                                      libjpeg-dev \
                                      curl \
                                      lsof && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN npm install -g gulp
