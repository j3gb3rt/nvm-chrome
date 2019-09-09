FROM ubuntu:18.04

RUN cat /etc/apt/sources.list \
    && echo \
      "deb mirror://mirrors.ubuntu.com/mirrors.txt bionic main restricted universe multiverse\n" \
      "deb mirror://mirrors.ubuntu.com/mirrors.txt bionic-updates main restricted universe multiverse\n" \
      "deb mirror://mirrors.ubuntu.com/mirrors.txt bionic-backports main restricted universe multiverse\n" \
      "deb mirror://mirrors.ubuntu.com/mirrors.txt bionic-security main restricted universe multiverse\n \
      $(cat /etc/apt/sources.list)" > /etc/apt/sources.list \
    && cat /etc/apt/sources.list \
    && apt update \
    && apt install -y --no-install-recommends \
    ca-certificates \
    chromium-browser \
    curl \
    git \
    libatk-bridge2.0-0 \
    libgconf-2-4 \
    && rm -rf /var/lib/apt/lists/*

RUN addgroup --system buildusers \
    && adduser --system --ingroup buildusers builduser --shell /bin/bash

WORKDIR /home/builduser
USER builduser

RUN touch .bashrc \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

RUN bash -c "source .bashrc \
    && nvm install 10 \
    && nvm install-latest-npm \
    && nvm install 12 \
    && nvm install-latest-npm \
    && nvm use 10"

ENV CHROME_BIN /usr/bin/chromium
