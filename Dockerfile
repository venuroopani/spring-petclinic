FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/mitesh51/spring-petclinic

FROM maven:3.6.3-jdk-8 as build
WORKDIR /app
COPY --from=clone /app/spring-petclinic /app
RUN mvn dependency:go-offline
#RUN mvn package


