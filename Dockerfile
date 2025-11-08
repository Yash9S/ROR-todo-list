# Start your image with a node base image
FROM ruby:3.1

# Install system & linux dependencies used by rails
RUN apt-get update && apt-get install -y build-essential libpq-dev nodejs

# The /app directory should act as the main application directory - have doubt if I want to include /rails over here or should I leave it as /app
WORKDIR /app 

# Copy the app package and package-lock.json file
COPY Gemfile Gemfile.lock ./

# Install the correct Bundler version
RUN gem install bundler -v 2.7.2

# Install ruby gems
RUN bundle _2.7.2_ install

# Copy local directories to the current local directory of our docker image (/app)
COPY . .

# Custom port for the rails app
EXPOSE 9999

# Start the app using rails command
CMD [ "bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "9999" ]