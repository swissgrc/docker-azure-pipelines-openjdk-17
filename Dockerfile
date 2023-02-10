# Base image containing dependencies used in builder and final image
FROM debian:11.6-slim AS base

# Make sure to fail due to an error at any stage in shell pipes
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# renovate: datasource=repology depName=debian_11/ca-certificates versioning=loose
ENV CACERTIFICATES_VERSION=20210119

RUN apt-get update -y && \
  # Install necessary dependencies
  apt-get install -y --no-install-recommends ca-certificates=${CACERTIFICATES_VERSION} && \
  # Clean up
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*


# Builder image
FROM base AS build

# Make sure to fail due to an error at any stage in shell pipes
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# renovate: datasource=repology depName=debian_11/curl versioning=loose
ENV CURL_VERSION=7.74.0-1.3+deb11u5
# renovate: datasource=repology depName=debian_11/lsb-release versioning=loose
ENV LSBRELEASE_VERSION=11.1.0
# renovate: datasource=repology depName=debian_11/gnupg2 versioning=loose
ENV GNUPG_VERSION=2.2.27-2+deb11u2

RUN apt-get update -y && \
  # Install necessary dependencies
  apt-get install -y --no-install-recommends curl=${CURL_VERSION} lsb-release=${LSBRELEASE_VERSION} gnupg=${GNUPG_VERSION} && \
  # Add Dockers public key
  mkdir -p /etc/apt/keyrings && \
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
  # Add Dockers APT repository to the list of sources
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
  # Add Eclipse Adoptium public key
  curl -fsSL https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc && \
  # Add Eclipse Adoptium APT repository to the list of sources
  echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list > /dev/null


# Final image
FROM base AS final

LABEL org.opencontainers.image.vendor="Swiss GRC AG"
LABEL org.opencontainers.image.authors="Swiss GRC AG <opensource@swissgrc.com>"
LABEL org.opencontainers.image.title="azure-pipelines-openjdk"
LABEL org.opencontainers.image.documentation="https://github.com/swissgrc/docker-azure-pipelines-openjdk"

# Make sure to fail due to an error at any stage in shell pipes
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /
COPY --from=build /etc/apt/keyrings/ /etc/apt/keyrings
COPY --from=build /etc/apt/sources.list.d/ /etc/apt/sources.list.d

# Install Docker CLI

# renovate: datasource=github-tags depName=docker/cli extractVersion=^v(?<version>.*)$
ENV DOCKERCLI_VERSION=23.0.1

# Install Docker CLI
RUN apt-get update -y && \
  apt-get install -y --no-install-recommends docker-ce-cli=5:${DOCKERCLI_VERSION}~3-0~debian-bullseye && \
  # Clean up
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  # Smoke test
  docker --version

# Install OpenJDK

# renovate: datasource=adoptium-java depName=java-jdk versioning=loose
ENV OPENJDK_VERSION=17.0.6.0.0+10

# Install OpenJDK
RUN apt-get update -y && \
  apt-get install -y --no-install-recommends temurin-17-jdk=${OPENJDK_VERSION} && \
  # Clean up
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  # Smoke test
  java -version
