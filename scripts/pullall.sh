#!/bin/bash

for r in "$RIGEL_ROOT" "$RIGEL_SIM" "$RIGEL_TARGETCODE" "$RIGEL_CODEGEN"
do
  echo "updating in $r..."
  pushd $r
  git pull
  popd
done
 
