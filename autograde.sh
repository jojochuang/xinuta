#!/bin/bash

mkdir submit503
cd submit503
cp ~cs503/submit503/lab5-part2/* .
../uncompress.sh
../grader.sh
