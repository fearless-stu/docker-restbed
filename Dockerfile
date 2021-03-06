FROM ubuntu as stage1
RUN apt-get -y update && apt-get -y install build-essential libcurl4-gnutls-dev \
  libtinyxml2-dev
RUN echo 'Etc/GMT' > /etc/timezone && ln -s /usr/share/zoneinfo/Etc/GMT /etc/localtime
RUN  apt-get -y install cmake nginx git g++ make openssl
RUN  git clone --recursive https://github.com/corvusoft/restbed.git /src/restbed \
	&&  mkdir -p /src/restbed/build \
	&& cd /src/restbed/build && cmake -DBUILD_SSL=NO .. && make 
RUN cd /src/restbed/build && make DESTDIR=/restbed install 
FROM ubuntu
RUN apt-get -y update && apt-get -y install openssl
COPY --from=stage1 /restbed /restbed
RUN cp -r /restbed/src/restbed/distribution/library/* /usr/lib
RUN cp -r /restbed/src/restbed/distribution/include/* /usr/include
RUN rm -rf /restbed
COPY --from=stage1 /src/restbed/build/test/feature/http_client_async_feature_test_suite /tmp/http_client_async_feature_test_suite
RUN /tmp/http_client_async_feature_test_suite

