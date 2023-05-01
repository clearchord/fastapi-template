#!/bin/bash

RUN_USER=${RUN_USER:-developer}
exec gosu ${RUN_USER} "$@"

