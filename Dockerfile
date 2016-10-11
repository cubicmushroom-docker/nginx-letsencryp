# Inspiration from http://bit.ly/299ebOK

FROM nginx:1.10

# Add jessie-backports in order to be able to install `certbot`
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list.d/jessie-backports.list

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y certbot -t jessie-backports

ADD sites sites
ADD entrypoints/get-certs get-certs
