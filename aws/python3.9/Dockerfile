# to create the aws lambda layer (lambda platform like)
FROM amazonlinux:latest
# required for python3.9 (build and deploy)

RUN yum -y update && yum -y install gzip zip unzip tar wget yum-utils make gcc openssl-devel bzip2-devel libffi-devel zlib-devel util-linux which
RUN wget https://www.python.org/ftp/python/3.9.12/Python-3.9.12.tgz 
RUN tar -xzf Python-3.9.12.tgz 
RUN cd Python-3.9.12; ./configure --enable-optimizations; make altinstall; cd ..; rm Python-3.9.12.tgz; rm -rf Python-3.9.12
RUN cd "$(dirname $(which python3.9))" && ln -s python3.9 python3 && ln -s pip3.9 pip3

# Pass the CMD
