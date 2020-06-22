#FROM registry.access.redhat.com/jboss-webserver-3/webserver31-tomcat7-openshift
#FROM registry.redhat.io/jboss-webserver-3/webserver31-tomcat7-openshift
#FROM registry.redhat.io/jboss-webserver-3/webserver31-tomcat7-openshift
FROM registry.wspark.com/jboss-webserver-5/webserver52-openjdk11-tomcat9-openshift-rhel7:latest

#FROM tomcat7-base:latest
    
USER root
#USER 185
#RUN useradd -u 185 -G root tomcat

# RUN yum -y update \
# RUN yum -y install openssh-clients.x86_64 
  
ARG TOMCAT_PATH=/opt/jws-5.2/tomcat
#RUN rm -rf ${TOMCAT_PATH}/conf/server.xml
#RUN rm -rf ${TOMCAT_PATH}/conf/catalina.properties
#RUN rm -rf ${TOMCAT_PATH}/conf/web.xml
#ARG TOMCAT_PATH=/usr/local/tomcat/apache-tomcat-7.0.62
   
# Lib
#COPY mysql-connector-java-commercial-5.1.29-bin.jar ${TOMCAT_PATH}/lib/
#COPY postgresql-42.2.9.jar ${TOMCAT_PATH}/lib/
  
# conf
#COPY server.xml ${TOMCAT_PATH}/conf/
#COPY web.xml ${TOMCAT_PATH}/conf/

# for valut
COPY files/vault/tomcat-vault.jar ${TOMCAT_PATH}/lib/
#COPY files/vault/catalina.properties ${TOMCAT_PATH}/conf/
COPY files/vault/vault.properties ${TOMCAT_PATH}/conf/
COPY files/vault/crm.keystore ${TOMCAT_PATH}/conf/
COPY files/vault/VAULT.dat ${TOMCAT_PATH}/conf/



# Direcotry Permission
RUN chmod 777 ${TOMCAT_PATH}/conf ${TOMCAT_PATH}/lib -R \
  && chown -R 185:root ${TOMCAT_PATH}/conf ${TOMCAT_PATH}/lib
     
# App 복사
ADD files/webapps/simple ${TOMCAT_PATH}/webapps/simple
#ADD files/webapps/web ${TOMCAT_PATH}/webapps/web
#ADD files/webapps/web2 ${TOMCAT_PATH}/webapps/web2

# Allow arbitrary
USER 185
  
EXPOSE 8080

# Install Language
RUN apt-get update \
  && apt-get install --reinstall -y locales \
  && sed -i 's/# ko_KR.UTF-8 UTF-8/ko_KR.UTF-8 UTF-8/' /etc/locale.gen \
  && locale-gen ko_KR.UTF-8 \
  && apt-get clean
  
ENV LANG ko_KR.UTF-8
ENV LANGUAGE ko_KR
ENV LC_ALL ko_KR.UTF-8
  
RUN dpkg-reconfigure --frontend noninteractive locales
   
#ENTRYPOINT ["catalina.sh", "run"]
