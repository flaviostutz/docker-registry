FROM registry:2.7.1

RUN apk add --update \
    bash \
    procps \
    && rm -rf /var/cache/apk/*

ENV REGISTRY_STORAGE_DELETE_ENABLED true

#Minute Hour Day Month Day_of_the_Week 
ENV CLEANUP_CRON 15 3 * * 6

ADD /cleanup.sh /
ADD /startup.sh /
ADD /async-cmd.sh /

ENTRYPOINT [ "/bin/sh", "-C" ]
CMD [ "/startup.sh" ]
