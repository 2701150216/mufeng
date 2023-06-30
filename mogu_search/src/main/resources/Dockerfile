FROM registry.cn-beijing.aliyuncs.com/mufeng_blog/jdk:8-alpine
VOLUME /tmp
ADD mogu_search-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-Xms256m","-Xmx256m","-jar","/app.jar"]
