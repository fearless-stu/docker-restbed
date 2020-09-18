FROM ubuntu
RUN apt-get -y update
RUN apt-get -y install build-essential libcurl4-gnutls-dev librestbed-dev \
  libtinyxml2-dev
RUN echo 'Etc/GMT' > /etc/timezone && ln -s /usr/share/zoneinfo/Etc/GMT /etc/localtime
RUN  apt-get -y install cmake nginx git g++ make openssl
RUN  git clone --recursive https://github.com/corvusoft/restbed.git /src/restbed
RUN  mkdir -p /src/restbed/build
RUN  cd /src/restbed/build && cmake -DBUILD_SSL=NO .. && make
