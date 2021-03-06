#!/bin/bash

# Optional set
#
# $HISTOMICS_SOURCE_FOLDER to the HistomicsUI source repository
# $HISTOMICS_TESTDATA_FOLDER to a location to store data files

# $DIR will be the folder of this script.  See 
# https://stackoverflow.com/questions/59895
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

HISTOMICS_SOURCE_FOLDER="${HISTOMICS_SOURCE_FOLDER:-${DIR}/../../HistomicsUI}"

$DIR/../ansible/deploy_docker.py --mount $HISTOMICS_SOURCE_FOLDER:/opt/HistomicsUI/ --mount ${HISTOMICS_TESTDATA_FOLDER:-~/.histomics_data}:/data/ $@
