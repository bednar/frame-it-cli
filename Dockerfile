#
# Builder image
#
FROM ruby:3.4.4 as builder

# Directories paths as environment variables
ENV APP_HOME=/app
ENV VENDOR_ENV=/app/vendor

# Working directory
WORKDIR $APP_HOME
RUN mkdir $VENDOR_ENV
RUN mkdir $APP_HOME/.bundle

# Copy Gemfile and Gemfile.lock to the working directory
COPY Gemfile Gemfile.lock $APP_HOME/
# Copy .bundle/config to the working directory
COPY .bundle/config $APP_HOME/.bundle

# Install bundler
RUN gem install bundler

# Install dependencies
RUN bundle install

#
# Production image
#
FROM ruby:3.4.4-slim as production

# Install dependencies - imagemagick
RUN apt-get update && \
    apt-get install -y --no-install-recommends imagemagick

# Directories paths as environment variables
ENV APP_HOME=/app
ENV VENDOR_ENV=/app/vendor

# Working directory
WORKDIR $APP_HOME
RUN mkdir $VENDOR_ENV
RUN mkdir $APP_HOME/.bundle

# Install bundler
RUN gem install bundler

# Copy sources from builder image
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/

# Use a non-root user
RUN useradd -m cli && \
    chown cli:cli $VENDOR_ENV
USER cli

# Copy sources from builder image
COPY --from=builder --chown=cli:cli $APP_HOME/Gemfile $APP_HOME/
COPY --from=builder --chown=cli:cli $APP_HOME/Gemfile.lock $APP_HOME/
COPY --from=builder --chown=cli:cli $VENDOR_ENV $VENDOR_ENV
COPY --from=builder --chown=cli:cli $APP_HOME/.bundle $APP_HOME/.bundle

# Disable Fastlane telemetry
ENV FASTLANE_OPT_OUT_USAGE=1

# Install depencies
RUN bundle install

# Download devices frames
RUN bundle exec fastlane frameit download_frames

# Entrypoint
ENTRYPOINT ["bundle", "exec", "fastlane"]
