# CROSS-COMPILATION ARM 64 BITS ON x86_64


FROM debian:bullseye-slim
LABEL Florian BALLANDREAU <fballandreau@inope-k.com>
  
# Install build base
RUN apt update
RUN apt-get install -y gcc make gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu
# create ALIAS for cross-compilation tools to avoid conflicts with the host tools
RUN alias gcc='aarch64-linux-gnu-gcc'
RUN alias make='make -j 4'
RUN alias ld='aarch64-linux-gnu-ld'
RUN alias ar='aarch64-linux-gnu-ar'

# DEFINE ARGUEMENT INPUT and OUPTUT
ENV tool="gcc"

# Define the working directory
WORKDIR /app


# Command to run compilation when starting the container with the argument
# how to run : docker run -i --rm -v "$(pwd)/.:/data" <image> /data/t.c -o /data/t.o
ENTRYPOINT ["gcc"]
CMD ["/bin/bash"]
