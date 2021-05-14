ARG PG_MAJOR
ARG PG_VERSION
FROM postgres:$PG_VERSION
RUN sed -i -e"s/^#log_min_duration_statement = -1.*$/log_min_duration_statement = 10/" "/usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample" && \
    apt-get -yqq update && \
    apt-get -yqq --no-install-recommends install curl build-essential ca-certificates postgresql-server-dev-$PG_MAJOR && \
    curl -L https://github.com/HypoPG/hypopg/archive/1.2.0.tar.gz | tar xz && \
    cd "hypopg-1.2.0" && \
    make && \
    make install