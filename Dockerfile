FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install build-essential libjpeg-dev git autoconf automake libtool autoconf-archive pkg-config libjpeg8-dev zlib1g-dev libpng-dev wget cmake -y

RUN wget http://www.leptonica.org/source/leptonica-1.74.4.tar.gz \
    && tar -zxvf leptonica-1.74.4.tar.gz \
    && cd leptonica-1.74.4 \
    && ./configure \
    && make \
    && make install \
    && ldconfig \
    && cd ..

RUN git clone https://github.com/tesseract-ocr/tesseract.git \
    && cd tesseract \
    && git checkout tags/4.00.00alpha \
    && sed -i "603s/isnan/std::isnan/" ./lstm/lstmrecognizer.cpp \
    && mkdir build && cd build && cmake .. && cd ..\
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && ldconfig \
    && cd ..

RUN git clone https://github.com/tesseract-ocr/tessdata.git
RUN cd tessdata && git checkout 3a94ddd47be01fd897cbe31f05cbd2301454cf8a && cd ..

RUN mkdir /usr/src/app
WORKDIR /usr/src/app
COPY ./CMakeLists.txt /usr/src/app
COPY ./main.cpp /usr/src/app
COPY ./foxanddog.jpg /usr/src/app
RUN cmake ./ && make

CMD ["./alpha_demo"]