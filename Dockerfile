#
# Builder image
#
FROM ruby:3.1.5 as builder

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
FROM ruby:3.1.5-slim as production

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

# Install depencies
RUN bundle install

# Entrypoint
ENTRYPOINT ["bundle", "exec", "fastlane"]
