<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/BlindGarret/no-ip">
    <img src="images/logo.png" alt="Logo" width="300">
  </a>

  <p align="center">
    Helm Repository Values for DDNS Updater For home System
    <br />
    <a href="https://github.com/BlindGarret/no-ip/issues">Report Bug</a> |
    <a href="https://github.com/BlindGarret/no-ip/issues">Request Feature</a>
  </p>
</p>

### Built With

* [Kubernetes](https://kubernetes.io/)
* [Docker](https://www.docker.com/)
* [Helm](https://helm.sh/)
* [MySQL](https://www.mysql.com/)
* [No-IP](https://hub.docker.com/r/coppit/no-ip)

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

Requires a functional K8s cluster with admin access.

### Installation

1. Create the namespace
   ```sh
   kubectl create namespace no-ip
   ```
2. Add Helm Repo
   ```sh
   helm repo add rts http://helm-repository
   ```
2. Install the chart
   ```sh
   helm upgrade --install --wait no-ip rts/sdhc -f values.yaml -n no-ip --version ~1.3
   ```


<!-- CONTACT -->
## Contact

Project Link: [https://github.com/BlindGarret/no-ip](https://github.com/BlindGarret/no-ip)
