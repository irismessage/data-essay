#!/bin/bash
set -eux

exec "${HOME}/miniconda3/envs/data/bin/jupyter" nbconvert \
    --to='HTML' \
    'DATA Assessment 2023-24.ipynb'
