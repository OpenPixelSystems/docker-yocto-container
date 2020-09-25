#!/bin/bash

docker run -it --rm -h docker-env --net=host --env="DISPLAY" --volume="$HOME/Code:/home/bravl/mnt/" ops-yocto:xenial /bin/bash
