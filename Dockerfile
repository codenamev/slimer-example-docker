FROM ruby:3.0
RUN apt-get update -qq && apt-get install -y postgresql-client redis-tools
WORKDIR /slimer
COPY Gemfile /slimer/Gemfile
COPY Gemfile.lock /slimer/Gemfile.lock
RUN bundle install
COPY . /slimer

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 6660

# Start the main process
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
