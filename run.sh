#!/bin/bash

docker run -it --rm -h docker-env --net=host --env="DISPLAY" --volume="$HOME/:/home/bravl/" ops-yocto:latest /bin/bash
