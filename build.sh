#!/usr/bin/env bash

docker buildx build --platform arm64 -t tflite -f Dockerfile .
