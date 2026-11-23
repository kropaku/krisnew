FROM python:3.12-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends chromium fonts-wqy-zenhei ca-certificates \
 && rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 1000 user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH \
    MUSE2API_HOST=0.0.0.0 \
    MUSE2API_PORT=10000 \
    HOST=0.0.0.0 \
    PORT=10000 \
    MUSE2API_NO_SANDBOX=1 \
    MUSE2API_DATA_DIR=/home/user/app/data \
    MUSE2API_CHROMIUM_PATH=/usr/bin/chromium

WORKDIR $HOME/app

COPY --chown=user:user pyproject.toml README.md ./
COPY --chown=user:user src ./src
RUN pip install --no-cache-dir .

RUN mkdir -p /home/user/app/data && chown -R user:user /home/user
USER user

EXPOSE 10000
CMD ["muse2api"]
