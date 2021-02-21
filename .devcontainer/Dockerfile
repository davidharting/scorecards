ARG VARIANT=3
FROM mcr.microsoft.com/vscode/devcontainers/ruby:0-${VARIANT}

# Node setup
ARG NODE_VERSION="lts/*"
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"

# Add heroku CLI
RUN curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

# OS-level dependencies
RUN apt-get update
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install --no-install-recommends postgresql-client-11 imagemagick

