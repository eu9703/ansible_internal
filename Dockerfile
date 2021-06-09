FROM alpine

RUN \
  apk add \
    openssh-client \
    python3 \
    python3-dev \
    alpine-sdk autoconf automake libtool \
    py3-boto \
    py3-dateutil \
    py3-httplib2 \
    py3-jinja2 \
    py3-wheel \
    py3-paramiko \
    py3-pip \
    py3-setuptools \
    py3-yaml \
    tar && \
  pip3 install --upgrade pip python3-keyczar ansible && \
  rm -rf /var/cache/apk/*

RUN mkdir /etc/ansible/ /ansible
RUN echo "[local]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts

RUN mkdir -p /ansible/playbooks
WORKDIR /ansible/playbooks

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PATH /ansible/bin:$PATH
ENV PYTHONPATH /ansible/lib
#ENV PYTHONPATH /usr/bin/python3

ENTRYPOINT ["ansible-playbook"]
