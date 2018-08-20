FROM jruby:9.0.5.0

WORKDIR /usr/src/app

RUN apt-get update
RUN apt-get install -y git

COPY Gemfile* /usr/src/app/

RUN bundle install

COPY . /usr/src/app/

CMD ["rails", "s", "-b", "0.0.0.0"]
