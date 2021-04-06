FROM mariadb:10.3.24
MAINTAINER mariadb by jang <jsh2808@naver.com>

# Timezone
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# package install
RUN apt-get update
RUN apt-get install nano -y
RUN apt-get install vim -y

# database config file
RUN rm -Rf /etc/mysql/my.cnf
COPY my.cnf /etc/mysql/my.cnf

# database table script copy
