FROM alpine:3.20.2 AS builder

ARG XMRIG_VERSION='v6.22.0'

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

WORKDIR /usr/src
RUN git clone --branch ${XMRIG_VERSION} --depth 1 https://github.com/xmrig/xmrig.git && \
    mkdir xmrig/build && \
    cd xmrig/build && \
    cmake .. && \
    make -j$(nproc)

# ---

FROM alpine:3.20.2

LABEL owner="Jorge Castro"
LABEL maintainer="nikey_es@yahoo.es"

RUN apk add --no-cache \
    libuv \
    libressl \
    hwloc-dev

RUN addgroup -S xmrig -g 1000 && \
    adduser -S -u 1000 -G xmrig -s /sbin/nologin -g "xmrig user" xmrig  
USER xmrig

COPY --from=builder --chown=xmrig:xmrig /usr/src/xmrig/build/xmrig /usr/local/bin/xmrig

WORKDIR /usr/local/bin/
ENTRYPOINT ["xmrig"]