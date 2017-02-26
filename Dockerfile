FROM nimlang/nim:latest
RUN apt-get update
RUN apt-get install -y python
RUN git clone https://github.com/nsf/termbox.git
RUN cd termbox && ./waf configure --prefix=/usr
RUN cd termbox && ./waf
RUN cd termbox && ./waf install
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN nimble build -y --debug
