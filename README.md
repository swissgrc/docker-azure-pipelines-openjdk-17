# Docker image for running Java applications in an Azure Pipelines container job

<!-- markdownlint-disable MD013 -->
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/swissgrc/docker-azure-pipelines-openjdk-17/blob/main/LICENSE) [![Build](https://img.shields.io/github/actions/workflow/status/swissgrc/docker-azure-pipelines-openjdk-17/publish.yml?branch=develop&style=flat-square)](https://github.com/swissgrc/docker-azure-pipelines-openjdk-17/actions/workflows/publish.yml) [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=swissgrc_docker-azure-pipelines-openjdk-17&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=swissgrc_docker-azure-pipelines-openjdk-17) [![Pulls](https://img.shields.io/docker/pulls/swissgrc/azure-pipelines-openjdk.svg?style=flat-square)](https://hub.docker.com/r/swissgrc/azure-pipelines-openjdk) [![Stars](https://img.shields.io/docker/stars/swissgrc/azure-pipelines-openjdk.svg?style=flat-square)](https://hub.docker.com/r/swissgrc/azure-pipelines-openjdk)
<!-- markdownlint-restore -->

Docker image which provides [Eclipse Temurin OpenJDK] 17 in an [Azure Pipelines container jobs].
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
        container: swissgrc/azure-pipelines-openjdk:17
        environment: smarthotel-dev
        strategy:
          runOnce:
            deploy:
              steps:
                - bash: |
                    java -version
```

### Tags

| Tag         | Description                                                                                   | Base Image                       | OpenJDK   | Size                                                                                                                                |
|-------------|-----------------------------------------------------------------------------------------------|----------------------------------|-----------|-------------------------------------------------------------------------------------------------------------------------------------|
| 17          | Latest stable release (from `main` branch)                                                    | azure-pipelines-dockercli:26.1.1 | 17.0.11.0 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/17?style=flat-square)          |
| 17-unstable | Latest unstable release (from `develop` branch)                                               | azure-pipelines-dockercli:26.1.4 | 17.0.11.0 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/17-unstable?style=flat-square) |
| 17.0.4.0    | [OpenJDK 17.0.4](https://foojay.io/java-17/?tab=component&version=17.0.4&quarter=072022)      | debian:11.3-slim                 | 17.0.4.0  | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/17.0.4.0?style=flat-square)    |
| 17.0.4.1    | [OpenJDK 17.0.4](https://foojay.io/java-17/?tab=component&version=17.0.4&quarter=072022)      | debian:11.5-slim                 | 17.0.4.1  | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/17.0.4.1?style=flat-square)    |
| 17.0.5.0    | [OpenJDK 17.0.5](https://foojay.io/java-17/?tab=component&version=17.0.5&quarter=102022)      | debian:11.6-slim                 | 17.0.5.0  | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/17.0.5.0?style=flat-square)    |
| 17.0.6.0    | [OpenJDK 17.0.6](https://foojay.io/java-17/?tab=component&version=17.0.6&quarter=012023)      | debian:11.6-slim                 | 17.0.6.0  | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/17.0.6.0?style=flat-square)    |
| 17.0.7.0    | [OpenJDK 17.0.7](https://foojay.io/java-17/?version=17.0.7&quarter=042023)                    | debian:11.6-slim                 | 17.0.7.0  | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/17.0.7.0?style=flat-square)    |
| 17.0.8.0    | [OpenJDK 17.0.8](https://foojay.io/java-17/?version=17.0.8&quarter=072023)                    | azure-pipelines-dockercli:24.0.5 | 17.0.8.0  | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/17.0.8.0?style=flat-square)    |
| 17.0.8.1    | [OpenJDK 17.0.8](https://foojay.io/java-17/?version=17.0.8&quarter=072023)                    | azure-pipelines-dockercli:24.0.5 | 17.0.8.1  | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/17.0.8.1?style=flat-square)    |
| 17.0.9.0    | [OpenJDK 17.0.9](https://adoptium.net/temurin/release-notes/?version=jdk-17.0.9+9)            | azure-pipelines-dockercli:24.0.7 | 17.0.9.0  | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/17.0.9.0?style=flat-square)    |
| 17.0.10.0   | [OpenJDK 17.0.10](https://adoptium.net/temurin/release-notes/?version=jdk-17.0.10+7)          | azure-pipelines-dockercli:25.0.3 | 17.0.10.0 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/17.0.10.0?style=flat-square)   |
| 17.0.11.0   | [OpenJDK 17.0.11](https://adoptium.net/temurin/release-notes/?version=jdk-17.0.11+9)          | azure-pipelines-dockercli:26.1.1 | 17.0.11.0 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/17.0.11.0?style=flat-square)   |

### Configuration

These environment variables are supported:

| Environment variable   | Default value        | Description                                                      |
|------------------------|----------------------|------------------------------------------------------------------|
| OPENJDK_VERSION        | `17.0.9.0.0+9`       | Version of Eclipse Temurin OpenJDK installed in the image.       |

[Eclipse Temurin OpenJDK]: https://adoptium.net/temurin/
[Azure Pipelines container jobs]: https://docs.microsoft.com/en-us/azure/devops/pipelines/process/container-phases
