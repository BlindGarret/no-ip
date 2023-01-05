<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/rts-core/ersys-backend">
    <img src="images/logo.png" alt="Logo" height="120">
  </a>

  <p align="center">
    No-ip Update Tool
    <br />
    <a href="https://github.com/rts-core/ersys-backend/issues">Report Bug</a> |
    <a href="https://github.com/rts-core/ersys-backend/issues">Request Feature</a>
  </p>
</p>

### Built With

* [Bash](https://www.gnu.org/software/bash/)
* [Expect](https://linux.die.net/man/1/expect)
* [Kubernetes](https://kubernetes.io/)
* [Kustomize](https://kustomize.io/)
* [Docker](https://www.docker.com/)

<!-- GETTING STARTED -->
## Introduction
This is just a simple wrapper around running the no-ip.com updater tool for automatically keeping your dynamic ip up to date with there system. Its setup to run in a docker container for deployment with both a simple docker-compose and a kustomize deployment written to be used out of the box.

## Parameters Required for all build paths
| VariableName      | Description                                       | Notes                                     |
| ----------------- | -----------------                                 | ---------                                 |
| NOIP_USER         | The username for the no-ip account to be used.    |                                           |
| NOIP_PASS         | The password for the no-ip account to be used.    | Treated as an opaque secret in Kustomize  |
| NOIP_DOMAINS      | A list of domains/groups to update.               | Comma delimited                           | 
| NOIP_INTERVAL     | The interval at which the system will update.     | Example 10m or 30h or 2d. Minimum 5m      | 


## Getting Started
To get a local copy up and running there are a couple of paths:

### Docker

For docker all we need to do is run the current image is

```sh
docker run --name no-ip \
-e "NOIP_USER=<<Username>>" \
-e "NOIP_PASS=<<Password>>" \
-e "NOIP_DOMAINS=<<Comma delimited domains/groups>>" \
-e "NOIP_INTERVAL=<<Interval (30m for example, min 5m)>>" \
lroe/no-ip:1.1
```
Just replace the placeholder for the environment variables and it should function as is.

### Docker-Compose

Included is also a docker compose file. The compose file is actually targeted to build the docker image locally rather than pull from the hub, which makes it an ideal way to develop and iterate if you want to fork and change how the tool works.

To run the docker image just modify the environment variables in the file ./docker-compose.yaml to match your credentials and run the command

```sh
docker-compose up --build
```

The --build parameter can be left off if you're not currently developing on the image. It just ensures the image rebuilds for each fresh run.

### Kustomize

If your interesting in standing this up in a kubernetes stack, I've also included a quick kustomize setup for that. These directions will assume you're using kube 1.14+, if not you'll have to use the kustomize cli directly instead of kubectl commands as listed below.

#### Environment Vars
To get this build going just go into the production overlay in ./kube/overlays/prod. You'll find two files, with the first being the env_vars.yaml. Go ahead and replace the values of the env_vars there. 

#### Password
You'll note that the password isn't there. This is because we're keeping it in a kube secret instead. Assuming you don't have your own method you prefer for setting up your secrets via some sort of vault system you're currently leveraging, I've added a standard secret generator to the kustomization.yaml file in this overlay. Just replace the value there in plaintext and it will do the creation for you.

If you do have your own methodology for secret generation, just modify the overlay to point to your proper secret.

#### Deploying
Now that the variables are set, it's just a matter of running

```sh
kubectl apply -k ./kube/overlays/prod
```