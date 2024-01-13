#!/bin/bash
set -eux

exec "${HOME}/miniconda3/envs/data/bin/jupyter" notebook \
    'DATA Assessment 2023-24.ipynb'
