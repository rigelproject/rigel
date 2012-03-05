################################################################################
# rigel.bashrc
################################################################################
# this file sets up most of the required environment for running the Rigel
#
# Notes: This bashrc requires you to add ...
#
################################################################################


################################################################################
# PATH
################################################################################
# start over with base path established in bash_profile
if [ -d ${RIGEL_ROOT} ]; then

  # check for required env vars
  RIGEL_REQUIRED=(RIGEL_BUILD, RIGEL_INSTALL, RIGEL_CODEGEN, RIGEL_TARGETCODE, RIGEL_SIM)
  for v in "$RIGEL_REQUIRED"
  do
    if [ -z $(eval echo \$v) ]; then
      echo "ERROR: $v does not exist!"
      exit
    fi
  done

  # add Rigel stuff for PATH
  export PATH=${PATH}:${RIGEL_BUILD}/sim/rigel-sim
  export PATH=${PATH}:${RIGEL_INSTALL}/host
  export PATH=${PATH}:${RIGEL_INSTALL}/host/bin

  ################################################################################
  # Rigel Libs
  ################################################################################
  export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${RIGEL_INSTALL}/host/i686-pc-linux-gnu/mips/lib
  export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${RIGEL_INSTALL}/host/lib
  # add 64-bit lib paths
  export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${RIGEL_INSTALL}/host/x86_64-unknown-linux-gnu/mips/lib
  ################################################################################
  

else
  echo ".bashrc: $RIGEL_ROOT does not exist on this machine!"
fi
