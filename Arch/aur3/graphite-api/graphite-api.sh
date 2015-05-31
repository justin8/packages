#!/bin/bash

gunicorn -w${workers} graphite_api.app:app -b ${listen_ip}:${port}
