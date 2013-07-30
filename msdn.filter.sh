#!/bin/bash

url=$1; shift;
set -x
lynx -dump $url | sed -n -e '/Rate this topic/, /Did you find this helpful/p'
set +x
