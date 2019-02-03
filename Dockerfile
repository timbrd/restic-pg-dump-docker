FROM restic/restic:0.9.3

RUN apk update \
    && apk upgrade \
    && apk add \
        bash \
        postgresql-client \
        tini \
    && rm -rf /var/cache/apk/*

ENV DOCKERIZE_VERSION=0.5.0
RUN wget -nv -O - "https://github.com/jwilder/dockerize/releases/download/v${DOCKERIZE_VERSION}/dockerize-linux-amd64-v${DOCKERIZE_VERSION}.tar.gz" | tar -xz -C /usr/local/bin/ -f -

ENV PATH="$PATH:/opt/restic-pg-dump/bin"

ENTRYPOINT ["/sbin/tini", "--", "entrypoint.sh"]
CMD ["crond.sh"]

WORKDIR /opt/restic-pg-dump/
COPY . /opt/restic-pg-dump/
