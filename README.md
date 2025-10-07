# Lightweight SuperSONIC deployment with Docker Compose

[SuperSONIC](https://github.com/fastmachinelearning/SuperSONIC) is a server infrastructure designed to implement GPU inference as-a-service in large scientific experiments.
SuperSONIC was originally designed for deployment on Kubernetes clusters, which made its adoption difficult for users with limited Kubernetes expertise and/or without access to a Kubernetes cluster. 

This repository provides a lightweight implementation of the SuperSONIC architecture for a local deployment using [Docker Compose](https://docs.docker.com/compose/). Using the instructions given below, one can launch a SuperSONIC server with the [ParticleNet model](https://cms-ml.github.io/documentation/inference/particlenet.html) loaded, and run an example client workflow against it.


## Pre-requisites

- [**Docker Desktop**](https://docs.docker.com/get-started/introduction/get-docker-desktop) OR 
- [**Docker Engine**](https://docs.docker.com/engine/install) and [**Docker Compose**](https://docs.docker.com/compose/install)

## Installation and running 

1. **Clone the repository:**

    ```
    git clone https://github.com/kondratyevd/supersonic-docker-compose
    cd supersonic-docker-compose
    ```

2. **Launch Docker Compose:**

    ```
    docker compose up
    ```
    This command will use the recipe specified in `compose.yaml` to do the following:
    * Download ParticleNet model from the CMSSW GitHub repository.
    * Download and launch four Docker containers (the containers will be cached and not need to be downloaded on subsequent runs):
        * Triton Inference Server
        * Envoy Proxy - exposes gRPC endpoint for inference requests at `localhost:8801`
        * Prometheus - exposes GUI at `localhost:9090`
        * Grafana - exposes a monitoring dashboard at `localhost:3000`

3. **Open Grafana dashboard** in a web browser at `localhost:3000`.

4. **Run perf-analyzer client:**

    Open a new terminal and execute
    ```
    source run-perf-analyzer.sh
    ```
    This command will download Triton SDK image and run a small Nvidia Performance Analyzer job which will send inference requests for ParticleNet model to evaluate. You can monitor the inference rate and latency in the Grafana dashboard.

5. **Stop the server:**

    Use `Ctl+C` or run `docker compose down` from a separate terminal.


## System Requirements

- **CPU: 4 cores** 
- **RAM: 16 GB** 
- **Storage: 20 GB** or more, depending on particular versions of Triton and Triton SDK images
- if available (but not required): **NVIDIA GPU** 


