FROM dockerfile/ubuntu
MAINTAINER Medy Belmokhtar <medy.belmokhtar@gmail.com>

RUN mkdir /medy
RUN mkdir /medy/apps
RUN mkdir /medy/myApp

# Prerequisites
RUN apt-get update &&\ 
  apt-get install -y software-properties-common wget subversion

# Install curl with ssl support
#
RUN (wget -O - http://www.magicermine.com/demos/curl/curl/curl-7.30.0.ermine.tar.bz2 | bunzip2 -c - | tar xf -) && \
  mv curl-7.30.0.ermine/curl.ermine /bin/curl && \
  rm -Rf curl-7.30.0.ermine

# Install jdk
#
RUN (curl -s -k -L -C - -b "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25-linux-x64.tar.gz | tar xfz -) && \
  mv jdk1.8.0_25 /medy/apps/jdk1.8.0_25

ENV JAVA_HOME /medy/apps/jdk1.8.0_25
ENV PATH $PATH:$JAVA_HOME/bin

# Install maven 3.1.1
#
RUN wget -q -O - http://apache.crihan.fr/dist/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz | tar xzf - -C /
RUN mv /apache-maven-3.1.1 /medy/apps/apache-maven-3.1.1
ENV PATH $PATH:/medy/apps/apache-maven-3.1.1/bin

ADD . /medy/myApp

WORKDIR /medy/myApp

CMD ["/bin/bash"]