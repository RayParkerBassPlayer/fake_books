FROM ruby:2.6.0

COPY . /fake_books
COPY ./id_rsa ~/.ssh
COPY ./id_rsa.pub ~/.ssh

WORKDIR /fake_books

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nodejs imagemagick vim

ENV RAILS_ENV test
ENV PG_HOST postgres
ENV PG_USER postgres
ENV PG_PASSWORD password

CMD git pull
RUN bundle

CMD bundle
CMD rake db:setup
CMD rspec .

