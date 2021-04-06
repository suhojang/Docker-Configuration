FROM centos:centos7
MAINTAINER agentAPI by jang <jsh2808@naver.com>

# Timezone
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# file copy
COPY ./install/jdk1.8.0_241/ /app/jdk1.8.0_241/
COPY ./install/tomcat9/ /app/tomcat9/
COPY ./install/tomcat9.service /usr/lib/systemd/system/
COPY ./install/systemd_config.sh /app/systemd_config.sh