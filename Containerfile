FROM docker.io/library/ubuntu:jammy

ENV TARGET_USER=testuser

USER root

RUN apt -y update && \
    apt -y install \
        curl \
        dumb-init \
        language-pack-ja \
        locales \
        sudo \
        tzdata \
        vim \
        wget \
    && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8 && \
    adduser --gecos "" --disabled-login "${TARGET_USER}" && \
    echo "${TARGET_USER}:${TARGET_USER}" | chpasswd && \
    SUDOERS_FILE="/etc/sudoers.d/${TARGET_USER}" && \
    echo "${TARGET_USER} ALL=(ALL) NOPASSWD: ALL" > "${SUDOERS_FILE}" && \
    chmod 440 "${SUDOERS_FILE}"

ENV LANG ja_JP.utf8

USER "${TARGET_USER}"

WORKDIR "/home/${TARGET_USER}"

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
