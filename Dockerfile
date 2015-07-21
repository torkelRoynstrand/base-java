FROM phusion/baseimage:0.9.17
MAINTAINER David J. M. Karlsen <david@davidkarlsen.com>

#avoid interactive dialouges from apt:
ENV DEBIAN_FRONTEND noninteractive

#add repo and update:
RUN add-apt-repository ppa:webupd8team/java && apt-get update && apt-get -y dist-upgrade

#make sure future images are always updated:
ONBUILD apt-get update && apt-get -y dist-upgrade

#install java8:
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && apt-get -y install oracle-java8-installer
#needs to be installed after JDK:
RUN apt-get -y install oracle-java8-unlimited-jce-policy

#set java8 default:
RUN apt-get install oracle-java8-set-default

#clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
