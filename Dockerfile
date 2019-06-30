FROM ubuntu:18.04 as builder

LABEL author="buzzkillb"

RUN apt-get update && apt-get install -y \
    git \
    wget \
    unzip \
    automake \
    autotools-dev \
    bsdmainutils \
    build-essential \
    libboost-all-dev \
    libqrencode-dev \
    libminiupnpc-dev \
    libevent-dev \
    libssl-dev \
    pkg-config \
    python3 \
    autogen \
    automake \
    libtool \
    make \
    software-properties-common \
    libqt5gui5 \
    libqt5core5a \
    libqt5dbus5 \
    qttools5-dev \
    qttools5-dev-tools \
    libprotobuf-dev \
    protobuf-compiler \
    && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:bitcoin/bitcoin -y && \
    apt-get update && \
    apt-get install --yes libdb4.8-dev libdb4.8++-dev

RUN git clone https://github.com/volta-im/volta-core && \
    cd volta-core && \
    ./autogen.sh && \
    ./configure && \
    make -j4 && \
    make install

# final image
FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    git \
    wget \
    unzip \
    automake \
    autotools-dev \
    bsdmainutils \
    build-essential \
    libboost-all-dev \
    libqrencode-dev \
    libminiupnpc-dev \
    libevent-dev \
    libssl-dev \
    pkg-config \
    python3 \
    autogen \
    automake \
    libtool \
    make \
    software-properties-common \
    libqt5gui5 \
    libqt5core5a \
    libqt5dbus5 \
    qttools5-dev \
    qttools5-dev-tools \
    libprotobuf-dev \
    protobuf-compiler \
    && rm -rf /var/lib/apt/lists/*
    
RUN add-apt-repository ppa:bitcoin/bitcoin -y && \
    apt-get update && \
    apt-get install --yes libdb4.8-dev libdb4.8++-dev

VOLUME /volta

COPY --from=builder /usr/local/bin/volta-qt /usr/local/bin/

ENV DISPLAY=:0
ENV QT_GRAPHICSSYSTEM="native"

CMD ["/usr/local/bin/volta-qt", "-datadir=/volta"]
