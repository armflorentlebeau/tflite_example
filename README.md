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

## Build - Gihub-hosted

In .github/workflows/build.yml you will find instructions to build the Docker image with the application.

The worflow can be launched manually from the _Actions_ tab and _Build_ > _Run workflow_. The yml file can also be edited to trigger a build for every push or pull request.

## Test - self-hosted

### Add a self-hosted Github actions runner

To run the Test workflow, add a self-hosted runner from the _Settings_ tab of the project _Actions_ > _Runners_ and _Add self-hosted runner_.

In the menu, select _Linux_ as the runner image, and _ARM64_ as the achitecture. Copy and paste the instructions displayed on the target console to install and start the agent.

### Launch on self-hosted runner

In .github/workflows/test.yml you will find instructions to deploy the Docker image on the self-hosted runner, execute and test the application.

When a self-hosted runner is available, the worflow can be launched manually from the _Actions_ tab and _Build_ > _Run workflow_. The yml file can also be edited to trigger a build for every push or pull request. 

# References

- Original TF example code: https://github.com/tensorflow/tensorflow/tree/master/tensorflow/lite/examples/python/
- TFlite example guide: https://www.tensorflow.org/lite/guide/python
- TFlite Docker image example for Aarch64: https://github.com/ARM-software/Tool-Solutions/tree/master/docker/tensorflow-lite-aarch64
