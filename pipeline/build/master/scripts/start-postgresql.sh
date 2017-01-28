#!/usr/bin/env bash

service postgresql start
tail -f /var/log/postgresql/*.log