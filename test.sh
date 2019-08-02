#!/bin/sh
# 100 hits to the metrics endpoint

curl http://localhost:5000/metrics\?foo\=\[1-100\]