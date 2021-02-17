#!/bin/sh
#
# A script to prepare the STATE directories
#
# 0. Source directory and its version
# -----------------------------------
#
VERSION=''
#VERSION='5.6.8'
if [ -z ${VERSION} ];
then
STATE_SRC='state'
else
STATE_SRC='state-'${VERSION}
fi
ROOT_DIR=~teac21/STATE
SRC_DIR=${ROOT_DIR}/src/${STATE_SRC}
GNCPP_DIR=${ROOT_DIR}/gncpp
#
# 1. STATE source directory
# -------------------------
#
mkdir -p STATE/src
#
cd STATE
#
cd src; ln -s $SRC_DIR state; cd ..
#
# 2. GNCPP directory
# ------------------
#
ln -s ${GNCPP_DIR}
#
# 3. Example directory
# --------------------
#
git clone https://github.com/ikuhamada/state-examples.git examples
#
# Add a path to the utility directory
# -----------------------------------
#
echo "export PATH=${PATH}:${SRC_DIR}/util/bin" >> ~/.bashrc; source ~/.bashrc
#
#####################
# End of the script #
#####################
