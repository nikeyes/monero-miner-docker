    FROM alpine:3.20.2 AS builder

ARG XMRIG_VERSION='v6.22.0'
WORKDIR /miner

RUN apk update && apk add --no-cache \ 
    git \ 
    make \ 
    cmake \ 
    libstdc++ \ 
    gcc \ 
    g++ \ 
    libuv-dev \ 
    openssl-dev \ 
    hwloc-dev
    
RUN git clone https://github.com/xmrig/xmrig && \
    cd xmrig && \
    git checkout ${XMRIG_VERSION}

RUN mkdir xmrig/build

RUN cd xmrig/build && \
    cmake .. && \
    make -j$(nproc)


FROM alpine:3.20.2
LABEL owner="Jorge Castro"
LABEL maintainer="nikey_es@yahoo.es"

RUN apk update && apk add --no-cache \
    libuv \
    libressl \
    hwloc-dev

WORKDIR /xmr
COPY --from=builder /miner/xmrig/build/xmrig /xmr

ENV WALLET=49NzKLonRimMhGnEiLNeZMTRFhNaVpPHoDrBUKiUsiDDXqXa6rbx7kagHQUNvEF8CfGjMD8KmKjBb7L6ZaEcRV9p5EZb32f
ENV POOL=pool.supportxmr.com:3333
ENV PASS=LocalDocker
ENV DONATE_LEVEL=1

CMD ["sh", "-c", "./xmrig --url=$POOL --donate-level=$DONATE_LEVEL --user=$WALLET --pass=$PASS -k --algo=rx/0 --coin=monero"]
