FROM python:3-alpine

ARG WORKDIR=/controller/

WORKDIR $CONTROLLER

COPY requirements.txt .

RUN apk add --no-cache openssh && pip install --no-cache-dir -r requirements.txt

COPY . .

ENV ANSIBLE_HOST_KEY_CHECKING=False

VOLUME $WORKDIR/env/
VOLUME $WORKDIR/inventory/
VOLUME $WORKDIR/artifacts/

CMD ansible-runner run $WORKDIR -r ${CONTROLLER_ROLE} --hosts ${CONTROLLER_HOSTS}
