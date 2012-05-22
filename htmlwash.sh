#!/bin/sh

sed -e 's/align="center"/style="text-align: center"/g' -e 's,Skrifter av <a href="/authors.[^>]*>[^>]*>,,g'

