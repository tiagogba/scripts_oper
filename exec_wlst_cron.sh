#!/bin/bash

# ************* Setting the Environment ***********************
DOMAIN_HOME="/opt/bea/wlserver_10.0/server"
. ${DOMAIN_HOME}/bin/setWLSEnv.sh $*

echo "Environment has been set....."

# ************* Changing the directory where all the related files are needed ***********************
cd /home/motion/scripts_python

echo "Calling the PYTHON script....."

# ************* Calling the WLST script  *****************
java weblogic.WLST script.py
