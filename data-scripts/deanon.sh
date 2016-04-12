#!/bin/bash

NAME=$(echo $1 | awk -F-2016 '{print $1}')

sed -i.orig "s/\(<Identifier>\)${NAME}</\1${1}</g" $1/composite.xml
