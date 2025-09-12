# syntax = docker/dockerfile:1

# Ruby version
ARG RUBY_VERSION=3.2.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Working directory
WORKDIR /rails

# Production environment
ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=development

# ---------------------
# Build Stage
# ---------------------
FROM base as build

# Install dependencies for gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config nodejs yarn

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Copy app code
COPY . .

# Precompile bootsnap code
RUN bundle exec bootsnap precompile app/ lib/

# Precompile assets with dummy secret key
ENV SECRET_KEY_BASE=dummy1234567890dummy1234567890dummy1234567890dummy12 \
    RAILS_ENV=production \
    DISABLE_DATABASE_ENVIRONMENT_CHECK=1

# Temporary database URL for assets precompile
RUN DATABASE_URL=postgresql://user:pass@localhost/db_prod bundle exec rails assets:precompile

# ---------------------
# Final Stage
# ---------------------
FROM base

# Install runtime dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libvips postgresql-client nodejs && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Copy gems and app from build stage
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Create non-root user for runtime
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

# Entrypoint and server
EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]