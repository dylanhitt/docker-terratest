FROM golang:1.18
LABEL maintainer="AustinCloudGuru"

ARG tf_version=1.2.2
ARG uid=1000
ARG gid=1000
ARG user=terratest
ARG group=terratest
ARG terratest_home=/terratest

RUN apt-get update && apt-get install -y gnupg software-properties-common curl \
    && curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - \   
    && apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    && apt-get update \
    && apt-get install terraform=${tf_version} \
    && mkdir -p ${terratest_home}/.aws \
    && chown -R ${uid}:${gid} $terratest_home \
    && groupadd -g ${gid} ${group} \
    && useradd -d "$terratest_home" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

USER ${user}

WORKDIR $GOPATH/src/app/test/
