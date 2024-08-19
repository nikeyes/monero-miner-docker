FROM alpine:3.20.2 AS builder

ARG MONERO_GIT_TAG="PUT_A_TAG_HERE"

RUN apk add --no-cache \
      autoconf \
      automake \
      boost-dev \
      ccache \
      cmake \
      curl \
      g++ \
      gettext \
      git \
      gtest-dev \
      libsodium-dev \
      libtool \
      libunwind-dev \
      make \
      openpgm-dev \
      openssl-dev \
      patch \
      perl \
      pkgconf \
      unbound-dev \
      zeromq-dev \
      linux-headers

WORKDIR /src

RUN git clone --branch ${MONERO_GIT_TAG} --depth 1 https://github.com/monero-project/monero  && \
      cd monero && \
      git submodule update --init --recursive && \
      make -j$(nproc) depends target=$(contrib/depends/config.guess)

# ---

FROM alpine:3.20.2 

RUN addgroup -g 1000 -S monero && \
      adduser -u 1000 -G monero -S -D -H monero && \
      mkdir -p /home/monero/.bitmonero && \
      chown -R monero:monero /home/monero/.bitmonero
  
USER monero

COPY --from=builder --chown=monero:monero /src/monero/build/*/release/bin /usr/local/bin/

RUN apk add --no-cache \
      ca-certificates \
      netcat-openbsd

WORKDIR /home/monero

EXPOSE 18080 18081 18083
VOLUME /home/monero/.bitmonero

ENTRYPOINT ["/usr/local/bin/monerod"]