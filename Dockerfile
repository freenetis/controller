FROM python:3-alpine

ENV ANSIBLE_HOST_KEY_CHECKING=False
ENV CONTROLLER_WORKDIR="/controller/"

WORKDIR ${CONTROLLER_WORKDIR}

RUN apk add --update --no-cache openssh-client sshpass

COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY requirements.yml /tmp/
RUN ansible-galaxy install -r /tmp/requirements.yml

COPY . .
COPY ./bin/controller /usr/local/bin

CMD ["sh", "-c", "controller ${CONTROLLER_DEBUG:+\"-d $CONTROLLER_DEBUG\"} ${CONTROLLER_SLEEP:+\"-s $CONTROLLER_SLEEP\"} -i $CONTROLLER_INVENTORY"]
