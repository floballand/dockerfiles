# AWS-CLI
FROM debian:bookworm-slim as awscliv2
LABEL Florian BALLANDREAU <fballandreau@inope-k.com>
ENV CLI_VERSION=2.15.11
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update -y --no-install-recommends \
  && apt install -y unzip curl
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-$CLI_VERSION.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install --bin-dir /aws-cli-bin/ \
  && rm awscliv2.zip


# AWS-SAM-CLI
FROM debian:bookworm-slim as samcli
ENV SAM_VERSION=1.115.0
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update -y --no-install-recommends \
  && apt install -y unzip curl
RUN curl -L "https://github.com/aws/aws-sam-cli/releases/download/v$SAM_VERSION/aws-sam-cli-linux-x86_64.zip" -o "sam-installation.zip" \
  && unzip sam-installation.zip -d sam-installation \
  && ./sam-installation/install \
  && rm sam-installation.zip

# AWS FINAL STAGE (NODE + DOCKER)
FROM python:3.12-slim-bookworm

#ENV SERVERLESS_VERSION=2.57.0
ENV NODEJS_VERSION=20
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update -y \
  && apt install -y --no-install-recommends \
  unzip curl groff less make apt-utils coreutils gettext util-linux jq git zip

RUN curl -fsSL https://deb.nodesource.com/setup_$NODEJS_VERSION.x | bash - \
&& apt-get install -y --no-install-recommends nodejs \
&& apt-mark hold nodejs 
#keep the serverlessF version managed by npm
#&& npm install -g serverless@$SERVERLESS_VERSION

RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

RUN apt clean && apt autopurge && rm -rf /var/lib/apt/lists/* && npm cache clean --force && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false

COPY --from=awscliv2 /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=awscliv2 /aws-cli-bin/ /usr/local/bin/

COPY --from=samcli /usr/local/aws-sam-cli/ /usr/local/aws-sam-cli/
COPY --from=samcli /usr/local/bin /usr/local/bin

CMD ["bash"]
