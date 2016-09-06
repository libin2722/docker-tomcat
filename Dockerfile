#
# MAINTAINER        Terry.Li<libin2722@sohu.com>
# DOCKER-VERSION    1.12.1
#
# Dockerizing TOMCAT: Dockerfile for building tomcat images
#
FROM       daocloud.io/libin2722/jdk:latest
MAINTAINER Terry.Li,<libin2722@sohu.com>

ENV TOMCAT_MAJOR_VERSION 9
ENV TOMCAT_MINOR_VERSION 9.0.0.M10
ENV CATALINA_HOME /opt/tomcat
ENV APP_DIR ${CATALINA_HOME}/webapps/

#ADD docker.repo /etc/yum.repos.d/docker.repo 

#COPY apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz /tmp/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz

RUN yum install -y vim curl wget

RUN curl -O http://mirrors.cnnic.cn/apache/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz

RUN tar -zxf /apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz -C /opt \
    && mv /opt/apache-tomcat* /opt/tomcat 

ENTRYPOINT sh $CATALINA_HOME/bin/startup.sh && tail -f $CATALINA_HOME/logs/catalina.out

EXPOSE 8080 8443

ONBUILD ADD ./webapps/ ${APP_DIR}/ROOT/
