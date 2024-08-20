FROM ubuntu:20.04 as builder

ARG MONERO_GIT_TAG="PUT_A_TAG_HERE"

RUN set -e && \
    apt-get update -q -y --no-install-recommends && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -q -y --no-install-recommends \
        automake \
        autotools-dev \
        bsdmainutils \
        build-essential \
        ca-certificates \
        ccache \
        cmake \
        curl \
        git \
        libtool \
        pkg-config \
        gperf


WORKDIR /src

RUN git clone --branch ${MONERO_GIT_TAG} --depth 1 https://github.com/monero-project/monero  && \
      cd monero && \
      git submodule update --init --recursive && \
      make -j$(nproc) depends target=$(contrib/depends/config.guess)

# ---

FROM ubuntu:20.04

RUN apt-get update -q -y --no-install-recommends && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -q -y --no-install-recommends \
      ca-certificates \
      netcat \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt


RUN groupadd -r monero -g 1000 && \
    adduser --uid 1000 --gid 1000 --system --disabled-password monero && \
	mkdir -p /home/monero/.bitmonero && \
	chown -R monero:monero /home/monero/.bitmonero

USER monero

COPY --from=builder /src/monero/build/*/release/bin /usr/local/bin/

WORKDIR /home/monero

EXPOSE 18080 18081 18083

VOLUME /home/monero/.bitmonero

ENTRYPOINT ["/usr/local/bin/monerod"]