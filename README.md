# ansible-playbook

[![Build and Deploy](https://github.com/TheoKeen/ansible-playbook/actions/workflows/docker-image.yml/badge.svg)](https://github.com/TheoKeen/ansible-playbook/actions/workflows/docker-image.yml)

Docker container for ansible-playbook.
Can be used to run ansible playbooks without installing ansible.

The following command creates an alias for ansible-playbook on linux.
`echo 'alias ansible-playbook="docker run -ti --rm --workdir $PWD -v $PWD:$PWD -v $(readlink -f $SSH_AUTH_SOCK):/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent theokeen/ansible-playbook"' >> .bashrc` 

