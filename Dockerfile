FROM ruby:3.4.2

WORKDIR /code
COPY . /code
RUN bundle install

EXPOSE 3001

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "3001"]