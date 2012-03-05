#!/usr/bin/env bash

################################################################################
# install.sh
################################################################################

echo "[RIGEL INSTALLER] Running Rigel Installer script"

MAKE=${MAKE:-make}
THREADS=${RIGEL_MAKE_PAR:-4}

echo "[RIGEL INSTALLER] Checking Status of RIGEL_ROOT Env Variable"
if [ -z $RIGEL_ROOT ]
then
  export RIGEL_ROOT=${PWD}
  echo "[RIGEL INSTALLER] RIGEL_ROOT var not defined, assuming current location ('${RIGEL_ROOT}')"
else
  echo "[RIGEL INSTALLER] Using your current value for RIGEL_ROOT, '${RIGEL_ROOT}'"
fi

: ${RIGEL_BUILD:=${RIGEL_ROOT}/build}
: ${RIGEL_INSTALL:=${RIGEL_ROOT}/install}
: ${RIGEL_CODEGEN:=${RIGEL_ROOT}/codegen}
: ${RIGEL_TARGETCODE:=${RIGEL_ROOT}/targetcode}
: ${RIGEL_SIM:=${RIGEL_ROOT}/sim}

export RIGEL_BUILD
export RIGEL_INSTALL
export RIGEL_CODEGEN
export RIGEL_TARGETCODE
export RIGEL_SIM

echo "[RIGEL INSTALLER] Building binutils"
$RIGEL_CODEGEN/binutils-2.18/build.sh

# Setup environment variables, PATH, LD_LIBRARY_PATH
source ${RIGEL_ROOT}/scripts/bash/rigel.bashrc

echo "[RIGEL INSTALLER] Building LLVM and Clang 2.8)"
$RIGEL_CODEGEN/llvm-2.8/build.sh

echo "[RIGEL INSTALLER] Installing Rigel target headers"
$MAKE -C $RIGEL_TARGETCODE/include install

echo "[RIGEL INSTALLER] Building Rigel target libraries"
$RIGEL_TARGETCODE/lib/build.sh

echo "[RIGEL INSTALLER] Building benchmarks"
$MAKE -C $RIGEL_TARGETCODE/src/benchmarks -j${THREADS}

echo "[RIGEL INSTALLER] Building RandomLib"
$RIGEL_SIM/RandomLib-1.3/build.sh

echo "[RIGEL INSTALLER] Building RigelSim"
pushd $RIGEL_SIM/rigel-sim >/dev/null
./build.sh
popd >/dev/null
  
echo "[RIGEL INSTALLER] Install Complete!"
echo ""
echo "[RIGEL INSTALLER] Add the following to your .bashrc or equivalent, replacing things like <THIS>:"
cat <<EOF
export RIGEL_ROOT=${RIGEL_ROOT}
export RIGEL_SIM=\${RIGEL_ROOT}/sim
export RIGEL_TARGETCODE=\${RIGEL_ROOT}/targetcode
export RIGEL_CODEGEN=\${RIGEL_ROOT}codegen
export RIGEL_INSTALL=\${RIGEL_ROOT}/install
export RIGEL_BUILD=\${RIGEL_ROOT}/build
export RIGEL_MAKE_PAR=<REPLACE ME WITH DESIRED BUILD PARALLELISM>
export LD_LIBRARY_PATH=\${LD_LIBRARY_PATH}:\${RIGEL_INSTALL}/host/x86_64-unknown-linux-gnu/mips/lib
export LD_LIBRARY_PATH=\${LD_LIBRARY_PATH}:\${RIGEL_INSTALL}/host/lib
export PATH=\${PATH}:\${RIGEL_INSTALL}/host/bin
EOF
