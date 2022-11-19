#!/bin/sh
gunicorn --chdir app main:app --preload -w 2 --threads 2 -b 0.0.0.0:8000
