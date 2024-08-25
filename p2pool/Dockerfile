FROM alpine:3.20.2 AS builder

ARG P2POOL_GIT_TAG='PUT_A_TAG_HERE'

RUN apk add --no-cache \
        git \
        cmake \
        make \
        libuv-dev \
        zeromq-dev \
        g++ \
        curl-dev \
        linux-headers

WORKDIR /usr/src

RUN git clone https://github.com/SChernykh/p2pool

WORKDIR /usr/src/p2pool

RUN git checkout ${P2POOL_GIT_TAG} && \
    git submodule update --init --recursive

WORKDIR /usr/src/p2pool/build

RUN cmake .. && \
    make "-j$(nproc)"

# ---

FROM alpine:3.20.2
COPY --from=builder /usr/src/p2pool/build/p2pool /

RUN apk add --no-cache \
    libcurl \
    libuv \ 
    libzmq \
    curl

RUN addgroup -S p2pool -g 1000 && \
    adduser -S -u 1000 -G p2pool -s /sbin/nologin -g "p2pool user" p2pool 
    
RUN mkdir -p /home/p2pool/.p2pool && \
    chown p2pool.p2pool /home/p2pool /home/p2pool/.p2pool
USER p2pool

EXPOSE 3333 37889 37888

VOLUME /home/p2pool/.p2pool

WORKDIR /home/p2pool/.p2pool
ENTRYPOINT ["/p2pool"]