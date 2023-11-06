FROM httpd:2.4
ARG MAINTAINER="Pratim Chaudhuri <pratim@chaudhuri.me>"
ARG WORK_DIRECTORY="./build"
LABEL maintainer=${MAINTAINER}
COPY ${WORK_DIRECTORY}/bundle.tar.gz /usr/local/apache2/htdocs/bundle.tar.gz
