FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    cmake \
    make \
    gcc \
    g++ \
    pkg-config \
    libdrogon-dev \
    libjsoncpp-dev \
    libcurl4-openssl-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN command -v make && command -v g++ \
    && cmake -S . -B build -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release \
    && cmake --build build --parallel 2

ENV PORT=10000
EXPOSE 10000

CMD ["./build/NithyaMart"]
