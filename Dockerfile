FROM alpine:3.5
MAINTAINER Sebastien LANGOUREAUX (linuxworkgroup@hotmail.com)

# Set environment
ENV SCHEDULER_VOLUME=/opt/scheduler \
    SCHEDULER_ARCHIVE=/opt/scheduler.tgz

# Add files
ADD root /
RUN cd ${SCHEDULER_VOLUME} && \
    mkdir -p ${SCHEDULER_VOLUME}/conf ${SCHEDULER_VOLUME}/confd/etc/conf.d && \
    tar czvf ${SCHEDULER_ARCHIVE} * && \
    rm -rf ${SCHEDULER_VOLUME}/* && \
    chmod +x /docker-entrypoint.sh


VOLUME ["${SCHEDULER_VOLUME}"]
ENTRYPOINT "/docker-entrypoint.sh"
