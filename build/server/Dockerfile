FROM relay-agent-be-base
MAINTAINER agentAPI by jang <jsh2808@naver.com>

# source copy
RUN rm -Rf /app/tomcat9/webapps/ROOT
COPY ./install/ROOT.war /app/tomcat9/webapps/ROOT.war

# ROOT.war ���Ѻ���
RUN chmod 755 /app/tomcat9/webapps/ROOT.war

EXPOSE 9778
ENTRYPOINT ["/usr/sbin/init"]