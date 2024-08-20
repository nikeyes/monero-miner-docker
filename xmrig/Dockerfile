FROM alpine:3.20.2 AS builder

ARG XMRIG_GIT_TAG='PUT_A_TAG_HERE'
WORKDIR /miner

RUN apk add --no-cache \ 
    git \ 
    make \ 
    cmake \ 
    libstdc++ \ 
    gcc \ 
    g++ \ 
    libuv-dev \ 
    openssl-dev \ 
    hwloc-dev
    
WORKDIR /src

RUN git clone --branch ${XMRIG_GIT_TAG} --depth 1 https://github.com/xmrig/xmrig.git
    
WORKDIR /src/xmrig/build

RUN cmake .. && \
    make "-j$(nproc)"

FROM alpine:3.20.2
LABEL owner="Jorge Castro"
LABEL maintainer="nikey_es@yahoo.es"

RUN apk update && apk add --no-cache \
    libuv \
    libressl \
    hwloc-dev

RUN addgroup -S xmrig -g 1000 && \
    adduser -S -u 1000 -G xmrig -s /sbin/nologin -g "xmrig user" xmrig  
USER xmrig

WORKDIR /xmr
COPY --from=builder --chown=xmrig:xmrig /miner/xmrig/build/xmrig /xmr

ENV WALLET=DEFAULT_WALLET
ENV POOL=DEFAULT_POOL
ENV PASS=DEFAULT_PASS
ENV DONATE_LEVEL=DEFAULT_DONATE_LEVEL

CMD ["sh", "-c", "./xmrig --url=$POOL --donate-level=$DONATE_LEVEL --user=$WALLET --pass=$PASS -k --algo=rx/0 --coin=monero"]