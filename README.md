# Docker image for running Java applications in an Azure Pipelines container job

<!-- markdownlint-disable MD013 -->
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/swissgrc/docker-azure-pipelines-openjdk/blob/main/LICENSE) [![Build](https://img.shields.io/github/workflow/status/swissgrc/docker-azure-pipelines-openjdk/Build/develop?style=flat-square)](https://github.com/swissgrc/docker-azure-pipelines-openjdk/actions/workflows/publish.yml) [![Pulls](https://img.shields.io/docker/pulls/swissgrc/azure-pipelines-openjdk.svg?style=flat-square)](https://hub.docker.com/r/swissgrc/azure-pipelines-openjdk) [![Stars](https://img.shields.io/docker/stars/swissgrc/azure-pipelines-openjdk.svg?style=flat-square)](https://hub.docker.com/r/swissgrc/azure-pipelines-openjdk)
<!-- markdownlint-restore -->

Docker image which provides [Eclipse Temurin OpenJDK] in an [Azure Pipelines container jobs].
The image contains also Docker CLI to access Docker engine on the agent.

## Usage

This image can be used to run Java applications in [Azure Pipelines container jobs].

### Azure Pipelines Container Job

To use the image in an Azure Pipelines Container Job, add one of the following example tasks and use it with the `container` property.

The following example shows the container used for a deployment step which shows .NET version:

```yaml
  - stage: deploy
    jobs:
      - deployment: runJava
        container: swissgrc/azure-pipelines-openjdk:latest
        environment: smarthotel-dev
        strategy:
          runOnce:
            deploy:
              steps:
                - bash: |
                    java -version
```

### Tags

| Tag        | Description                                                                                   | Base Image       | Docker CLI | OpenJDK  | Size                                                                                                                             |
|------------|-----------------------------------------------------------------------------------------------|------------------|------------|----------|----------------------------------------------------------------------------------------------------------------------------------|
| latest     | Latest stable release (from `main` branch)                                                    | debian:11.3-slim | 20.10.17   | 17.0.4.0 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/latest?style=flat-square)   |
| unstable   | Latest unstable release (from `develop` branch)                                               | debian:11.5-slim | 20.10.21   | 17.0.4.1 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/unstable?style=flat-square) |
| 17.0.4.0   | [OpenJDK 17.0.4](https://foojay.io/java-17/?tab=component&version=17.0.4&quarter=072022)      | debian:11.3-slim | 20.10.17   | 17.0.4.0 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/17.0.4.0?style=flat-square) |

### Configuration

These environment variables are supported:

| Environment variable   | Default value        | Description                                                      |
|------------------------|----------------------|------------------------------------------------------------------|
| DOCKERCLI_VERSION      | `20.10.21`           | Version of Docker CLI installed in the image.                    |
| OPENJDK_VERSION        | `17.0.4.0.0+8`       | Version of Eclipse Temurin OpenJDK installed in the image.       |
| CACERTIFICATES_VERSION | `20210119`           | Version of `ca-certificates` package used to install components. |
| CURL_VERSION           | `7.74.0-1.3+deb11u3` | Version of `curl` package used to install components.            |
| LSBRELEASE_VERSION     | `11.1.0`             | Version of `lsb-release` package used to install components.     |
| GNUPG_VERSION          | `2.2.27-2+deb11u2`   | Version of `gnupg` package used to install components.           |

[Eclipse Temurin OpenJDK]: https://adoptium.net/temurin/
[Azure Pipelines container jobs]: https://docs.microsoft.com/en-us/azure/devops/pipelines/process/container-phases
