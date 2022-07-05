# TFlite example

This example builds an [image recognition example](https://github.com/tensorflow/tensorflow/tree/master/tensorflow/lite/examples/python/) in a Docker image with TFlite for Arm64 architecture.

Github Actions workflows are used to:
- build the Docker image and store it in the Github container registry
- deploy the application on a Github runner and test the application output

# Local build

To build the Docker image:

```
./build.sh
```

# Local run

Run the image classification example:

```
./run.sh  | tee app.out
```

The application output is saved in the app.out file. This file can be used to check the output.

# Test application output locally

To run the tests, [shell2junit](https://github.com/manolo/shell2junit) is used. To install it:

```
git clone https://github.com/manolo/shell2junit
```

Run the tests:

```
. shell2junit/sh2ju.sh
./test.sh
```

# Worflows

## Build - Github-hosted

In .github/workflows/build.yml you will find instructions to build the Docker image with the application.

The worflow can be launched manually from the _Actions_ tab and _Build_ > _Run workflow_. The yml file can also be edited to trigger a build for every push or pull request.

## Test - self-hosted

### Add a self-hosted Github actions runner

To run the Test workflow, add a self-hosted runner from the _Settings_ tab of the project _Actions_ > _Runners_ and _Add self-hosted runner_.

In the menu, select _Linux_ as the runner image, and _ARM64_ as the achitecture. Copy and paste the instructions displayed on the target console to install and start the agent.

Note: for the agent to start automatically at launch, configure it as a service

```
sudo ./svc.sh install
sudo ./svc.sh start
```

### Launch on self-hosted runner

In .github/workflows/test.yml you will find instructions to deploy the Docker image on the self-hosted runner, execute and test the application.

When a self-hosted runner is available, the worflow can be launched manually from the _Actions_ tab and _Build_ > _Run workflow_. The yml file can also be edited to trigger a build for every push or pull request.

## AVH Launch Test - self-hosted

When an instance has been added as a runner and with the agent configured as a service, it can started automatically on demand with this workflow. This worflow will run the tests and stop the instance when completed.

This workflow requires:

- The ID of the instance configured as a github runner. You can get it from the URL when accessing the device in the AVH interface, e.g. `https://app.avh.arm.com/devices/<ID>/connect`. Save it as a github actions secret called `AVH_ID`.

- The [AVH API token](https://intercom.help/arm-avh/en/articles/6137393-generating-an-avh-api-token). Save it as a github actions secret called `AVH_TOKEN`.

It relies on a CLI bash tool to interact with the AVH API which can be found [here](https://github.com/armflorentlebeau/avhcli).

# References

- [Original TF example code](https://github.com/tensorflow/tensorflow/tree/master/tensorflow/lite/examples/python/)
- [TFlite example guide](https://www.tensorflow.org/lite/guide/python)
- [TFlite Docker image example for Aarch64](https://github.com/ARM-software/Tool-Solutions/tree/master/docker/tensorflow-lite-aarch64)
