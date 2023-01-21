FROM nginx
RUN yum update
RUN yum upgrade -y
RUN yum install curl  
WORKDIR /devops
COPY . .
ENTRYPOINT [ "service" ] ["ngix", "start"]
EXPOSE 80
