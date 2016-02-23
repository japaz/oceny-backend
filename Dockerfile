# Use the barebones version of Ruby 2.2.3.
FROM ruby:2.2.3-slim

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - nodejs: Compile assets
# - libpq-dev: Communicate with postgres through the postgres gem
# - postgresql-client-9.4: In case you want to talk directly to postgres
RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev libsqlite3-dev --fix-missing --no-install-recommends

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ENV INSTALL_PATH /usr/src/app
RUN mkdir -p $INSTALL_PATH

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH

# Ensure gems are cached and only get updated when they change. This will
# drastically increase build times when your gems do not change.
COPY Gemfile $INSTALL_PATH
RUN bundle install

# Copy in the application code from your work station at the current directory
# over to the working directory.
COPY . $INSTALL_PATH

RUN bundle exec rake db:create db:migrate

EXPOSE 3001

# -b 0.0.0.0 to bind in all interfaces
CMD bundle exec rails s -p 3001 -b 0.0.0.0
