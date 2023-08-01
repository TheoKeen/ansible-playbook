FROM python:3.11.4-slim-bookworm
MAINTAINER Theo@keennews.nl

RUN set -eux; \
        apt-get update; \
        apt-get install -y --no-install-recommends \
                ca-certificates \
                curl \
                sshpass \
                openssh-client \
                rsync \
                git \
                jq \
                bind9-utils \
        ; \
        rm -rf /var/lib/apt/lists/*


COPY requirements.txt ./
RUN set -eux; \
        curl https://bootstrap.pypa.io/get-pip.py | python3 - ;\
        pip install --no-cache-dir -r requirements.txt;\
        rm requirements.txt;

COPY collections.yml ./
RUN set -eux; \
        ansible-galaxy collection install -r collections.yml; \
        rm collections.yml;


ENTRYPOINT ["/usr/local/bin/ansible-playbook"]
