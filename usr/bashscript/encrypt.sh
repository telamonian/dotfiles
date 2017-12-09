#!/usr/bin/env bash
openssl enc -in $1 -aes-256-cbc -pass stdin > $2
