FROM ruby:2.6.5
ENV LANG C.UTF-8
RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
    libpq-dev \  
    vim \      
    nodejs \
    fonts-vlgothic
# Install kakasi
RUN cd /tmp && \
    wget http://kakasi.namazu.org/stable/kakasi-2.3.6.tar.gz && \
    tar xvzf kakasi-2.3.6.tar.gz && \
    cd /tmp/kakasi-2.3.6 && \
    ./configure && \
    make && \
    make install && \
    make clean && \
    rm /tmp/kakasi-2.3.6.tar.gz
WORKDIR /app
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install
ADD . .
