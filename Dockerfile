FROM ruby:2.6.6

ENV BUNDLER_VERSION=2.1.4

RUN apt-get update -y && apt-get install -y apt-transport-https
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -y && apt-get install -y \
    nodejs \
    yarn \
    gcc g++ make\
    vim \
    zlib1g-dev \
    build-essential \
    libssl-dev \
    default-mysql-client \
    git-core \
    cmake \
    libmariadb-dev

RUN gem install bundler -v $BUNDLER_VERSION

WORKDIR /myapp

COPY Gemfile Gemfile.lock ./

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle install

COPY package.json yarn.lock ./

RUN yarn install --check-files
