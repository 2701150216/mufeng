FROM registry.cn-beijing.aliyuncs.com/mufeng_blog/jdk:8-alpine
VOLUME /tmp
ADD mogu_admin-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8082", "-Xms256m","-Xmx256m","-jar","/app.jar"]
