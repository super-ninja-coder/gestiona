FROM ruby:2.6.2-alpine3.9

RUN mkdir /app
WORKDIR /app

RUN apk add --update \
    build-base libxml2-dev libxslt-dev libstdc++ tzdata openssl-dev \
    libc-dev linux-headers curl-dev ruby-json bash postgresql-dev postgresql && \
    gem install bundler && \
    rm -rf /var/cache/apk/*

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install -j 8

ADD . /app

EXPOSE 2300

ENTRYPOINT ["bundle", "exec"]
CMD ["hanami", "server", "--host=0.0.0.0", "--port=2300"]
