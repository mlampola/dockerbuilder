FROM ubuntu
RUN apt-get -y update && \ 
    apt-get -y upgrade && \ 
    apt-get -y install curl && \ 
    apt-get auto-remove && \ 
    rm -rf /var/lib/apt/lists/* 
WORKDIR /app
COPY build.sh .
RUN chmod +x ./build.sh
CMD ["./build.sh"]
