FROM python:3.12.1-slim-bookworm
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


RUN set -eux; \
        curl -L  https://github.com/docker/compose/releases/download/$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)/docker-compose-linux-x86_64 -o  /usr/local/bin/docker-compose ; \
        chmod +x /usr/local/bin/docker-compose;


ENTRYPOINT ["/usr/local/bin/ansible-playbook"]
