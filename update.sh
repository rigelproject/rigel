#!/usr/bin/env bash

################################################################################
# This rebuilds the compiler, binutils, simulator, libraries, and benchmarks
#
# Use the "FULL" option to rebuild the compiler and binutils
#
################################################################################

if [ $# -ne 0 ]
then
	UPDATE_TYPE=$1;
else
	UPDATE_TYPE="regular";
fi

THREADS=${RIGEL_MAKE_PAR:-4}
echo "Using $THREADS threads"

echo "========== Running Rigel Update ==========";
echo "========== NOT Performing git pull (do it yourself!) =============";
#git pull

# onlr rebuild compilers and binutils on a FULL
if [ $UPDATE_TYPE == "FULL" ]
then
  echo "Peforming Full Update"
  echo "========== Building Compiler ============="
  pushd $RIGEL_CODEGEN/llvm-2.8 >/dev/null
  ./build.sh
  popd >/dev/null
  echo "========== Building Binutils... ======================"
  pushd $RIGEL_CODEGEN/binutils-2.18 >/dev/null
  ./build.sh
  popd >/dev/null
fi

echo "========== Rebuilding Target Libraries =========";
pushd $RIGEL_TARGETCODE/lib >/dev/null
if [ $UPDATE_TYPE == "FULL" ]
then
  make clean -s
  ./build.sh
else
  make -j${THREADS} -s
	make install -s
fi
popd >/dev/null

#only rebuild this on a FULL
if [ $UPDATE_TYPE == "FULL" ]
then
  echo "========== Building RandomLib ===========";
  $RIGEL_SIM/RandomLib-1.3/build.sh
fi

echo "========== Building RigelSim ===========";
pushd $RIGEL_SIM/rigel-sim >/dev/null
if [ $UPDATE_TYPE == "FULL" ] 
then
  ./build.sh
else
  make -j${THREADS} -s
	make install
fi
popd >/dev/null

echo "========== Building Benchmarks ==========";
pushd $RIGEL_TARGETCODE/src/benchmarks >/dev/null
make -j${THREADS} -s
popd >/dev/null
  
echo "========== update complete ==========";
echo "(success is not guaranteed)"

