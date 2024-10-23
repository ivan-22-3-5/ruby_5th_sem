ARG RUBY_VERSION=3.3.5
FROM ruby:$RUBY_VERSION

WORKDIR /rails

ENV RAILS_ENV="development"

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libvips sqlite3 && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

ENTRYPOINT ["./bin/docker-entrypoint"]

CMD ["rails", "server", "-b", "0.0.0.0"]
