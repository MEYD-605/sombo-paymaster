FROM ghcr.io/foundry-rs/foundry:latest

WORKDIR /app

COPY lib/ lib/
COPY src/ src/
COPY script/ script/
COPY foundry.toml .

RUN forge build

ENTRYPOINT ["forge"]
CMD ["build"]
