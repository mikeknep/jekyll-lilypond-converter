#/bin/bash
set -e

lily -dbackend=svg $1
mv $2 images/
rm $1
