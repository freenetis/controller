FROM python:3-alpine

ENV ANSIBLE_HOST_KEY_CHECKING=False
ENV CONTROLLER_WORKDIR="/controller/"

WORKDIR ${CONTROLLER_WORKDIR}

RUN apk add --update --no-cache openssh-client

COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY requirements.yml /tmp/
RUN ansible-galaxy install -r /tmp/requirements.yml

COPY ./playbooks/ ./playbooks/
COPY ./bin/controller /usr/local/bin


CMD ["sh", "-c", "controller ${CONTROLLER_SLEEP:+\"-s$CONTROLLER_SLEEP\"} -p $CONTROLLER_PLAYBOOK"]
