FROM alpine:3.9
MAINTAINER Anders Pitman (tapitman11@gmail.com)

ENV SAMTOOLS_VERSION 1.9
ENV HTSLIB_VERSION 1.9

RUN apk update && \
        apk add build-base && \
        apk add zlib-dev && \
        apk add bzip2-dev && \
        apk add xz-dev && \
        apk add curl-dev && \
        wget -q https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 && \
        tar xjvf samtools-${SAMTOOLS_VERSION}.tar.bz2 && \
        cd samtools-${SAMTOOLS_VERSION} && \
        ./configure --without-curses && \
        make -j8 && \
        mv samtools /usr/bin && \
        cd .. && \
        rm -rf samtools-${SAMTOOLS_VERSION}* && \
        apk del build-base && \
        apk del zlib-dev && \
        apk del bzip2-dev && \
        apk del xz-dev && \
        apk del curl-dev && \
        apk add libbz2 && \
        apk add xz && \
        apk add libcurl && \
        rm -rf /var/cache/apk/*

ENTRYPOINT ["samtools"]
