FROM debian:jessie

ENV DEBIAN_FRONTEND=noninteractive
# prerequisites
RUN apt-get update && \
    apt-get install -y apt-utils wget \
    build-essential cmake bison flex libpcap-dev pkg-config \
    libglib2.0-dev libgpgme11-dev uuid-dev \
    sqlfairy xmltoman doxygen libssh-dev libksba-dev libldap2-dev \
    libsqlite3-dev libmicrohttpd-dev libxml2-dev libxslt1-dev \
    xsltproc clang rsync rpm nsis alien sqlite3 libhiredis-dev libgcrypt11-dev \
    libgnutls28-dev redis-server texlive-latex-base \
    texlive-latex-recommended \
    socat vim python-pip git nmap \
    postgresql-contrib postgresql-server-dev-9.4

ENV OV_LIB_SRC=openvas-libraries-8.0.8
ENV OV_LIB=$OV_LIB_SRC.tar.gz
ENV OV_LIB_URL=http://wald.intevation.org/frs/download.php/2351/$OV_LIB

ENV OV_SCN_SRC=openvas-scanner-5.0.7
ENV OV_SCN=$OV_SCN_SRC.tar.gz
ENV OV_SCN_URL=http://wald.intevation.org/frs/download.php/2367/$OV_SCN

ENV OV_MGR_SRC=openvas-manager-6.0.9
ENV OV_MGR=$OV_MGR_SRC.tar.gz
ENV OV_MGR_URL=http://wald.intevation.org/frs/download.php/2359/$OV_MGR

ENV OV_GSA_SRC=greenbone-security-assistant-6.0.11
ENV OV_GSA=$OV_GSA_SRC.tar.gz
ENV OV_GSA_URL=http://wald.intevation.org/frs/download.php/2363/$OV_GSA

ENV OV_CLI_SRC=openvas-cli-1.4.5
ENV OV_CLI=$OV_CLI_SRC.tar.gz
ENV OV_CLI_URL=http://wald.intevation.org/frs/download.php/2397/$OV_CLI

# ENV OV_SMB_SRC=openvas-smb-1.0.2
# ENV OV_SMB=$OV_SMB_SRC.tar.gz
# ENV OV_SMB_URL=http://wald.intevation.org/frs/download.php/2377/$OV_SMB

RUN mkdir /openvas-src && \
    cd /openvas-src && \
        wget $OV_CLI_URL && \
        wget $OV_GSA_URL && \
        wget $OV_LIB_URL && \
        wget $OV_MGR_URL && \
        wget $OV_SCN_URL && \
        tar xvf $OV_CLI && \
        tar xvf $OV_GSA && \
        tar xvf $OV_LIB && \
        tar xvf $OV_MGR && \
        tar xvf $OV_SCN 

RUN cd /openvas-src/$OV_LIB_SRC && cmake . && make && make doc && make install && \
    cd /openvas-src/$OV_CLI_SRC && cmake . && make && make doc && make install && \
    cd /openvas-src/$OV_GSA_SRC && cmake . && make && make doc && make install && \
    cd /openvas-src/$OV_SCN_SRC && cmake . && make && make doc && make install

RUN cd /openvas-src/$OV_MGR_SRC && cmake -DBACKEND=POSTGRESQL . && make && make doc && make install
 
RUN mkdir -p /scripts
ADD scripts/*.sh /scripts/
RUN bash /scripts/setup-postgresql.sh

CMD /bin/bash
