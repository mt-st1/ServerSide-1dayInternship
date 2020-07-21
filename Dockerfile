FROM ruby:2.6.5
ENV LANG C.UTF-8
RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
    libpq-dev \  
    vim \      
    nodejs \
    fonts-vlgothic
WORKDIR /app
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install
ADD . .
