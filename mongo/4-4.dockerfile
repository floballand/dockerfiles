FROM mongo:4.4-focal
LABEL Florian BALLANDREAU <fballandreau@inope-k.com>
RUN apt update -y --no-install-recommends \
  && apt install -y unzip curl python3 python3-pip groff less make apt-utils coreutils gettext util-linux jq unzip zip
ARG DEBIAN_FRONTEND=noninteractive


# COPY content

CMD ["/bin/bash"]
