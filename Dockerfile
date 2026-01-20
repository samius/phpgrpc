FROM unit:1.34.2-php8.3

# Install build and runtime dependencies
RUN apt-get update && apt-get install -y \
    autoconf build-essential pkg-config libssl-dev zlib1g-dev git \
 && pecl install grpc \
 && docker-php-ext-enable grpc \
 && apt-get purge -y autoconf build-essential pkg-config git \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*