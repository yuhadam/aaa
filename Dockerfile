FROM ubuntu:14.04

ENV HOME /root

RUN apt-get update && apt-get dist-upgrade -y

#basic dependencies

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  apt-utils \
  perl \
  vim \

# JAVA 1.7
RUN  apt-get install -y software-properties-common
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java7-installer
  #apt-get install -y oracle-java8-installer
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
#ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

#Add exe
ADD bwa /exe/
ADD picard.jar /exe/
ADD muTect-1.1.4.jar /exe/
ADD mutect-1.1.7.jar /exe/
ADD annovar /exe/annovar/
ADD samtools /exe/
ADD GenomeAnalysisTK.jar /exe/

#Cleanup the temp dir
RUN rm -rvf /tmp/*

#open ports private only
EXPOSE 8080

# Use baseimage-docker's bash.
CMD ["/bin/bash"]

#Clean up APT when done.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/
