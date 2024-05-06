# Create the build container to compile the hello world program
FROM ekidd/rust-musl-builder as builder
ENV USER root
ENV RUST_BACKTRACE=full
ENV RUSTUP_INIT_SKIP_PATH_CHECK=yes
WORKDIR /app
COPY . .
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
    sh -s -- --default-toolchain nightly -y
RUN rustup component add rust-src
RUN cargo rustc --release -- -C link-arg=-nostartfiles
RUN chmod +x /app/target/release/dotnet_os

# # Create the execution container by copying the compiled hello world to it and running it
# FROM scratch
# COPY --from=builder /app/target/release/dotnet_os /
# CMD ["/dotnet_os"]
