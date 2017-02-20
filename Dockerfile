FROM alpine:3.5
MAINTAINER Sebastien LANGOUREAUX (linuxworkgroup@hotmail.com)

# Set environment
ENV SCHEDULER_VOLUME=/opt/scheduler \
    SCHEDULER_ARCHIVE=/opt/scheduler.tgz

# Add files
ADD root /
RUN cd ${SCHEDULER_VOLUME} && \
    tar czvf ${SCHEDULER_ARCHIVE} * && \
    rm -rf ${SCHEDULER_VOLUME}/*


VOLUME ["${SCHEDULER_VOLUME}"]
ENTRYPOINT "/docker-entrypoint.sh"
