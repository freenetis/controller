FROM python:3-alpine

ENV CONTROLLER_WORKDIR="/controller/"

WORKDIR ${CONTROLLER_WORKDIR}

COPY requirements.txt .

RUN apk add --no-cache openssh && pip install --no-cache-dir -r requirements.txt

COPY . .

ENV ANSIBLE_HOST_KEY_CHECKING=False

VOLUME ${CONTROLLER_WORKDIR}/env/
VOLUME ${CONTROLLER_WORKDIR}/inventory/
VOLUME ${CONTROLLER_WORKDIR}/artifacts/

RUN echo ${CONTROLLER_WORKDIR}

CMD ansible-runner run ${CONTROLLER_WORKDIR} -r ${CONTROLLER_ROLE} --hosts ${CONTROLLER_HOSTS}
