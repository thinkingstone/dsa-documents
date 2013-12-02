#!/bin/sh

# sample
#
# ~/workspaces/dsa-documents/GIT/heldendokumenta5/src/main/scripts/toimage.sh ~/workspaces/dsa-documents/GIT/heldendokumenta5/src/intermediate/document/Heldendokument.pdf ~/workspaces/dsa-documents/GIT/heldendokumenta5/src/site/resources/images/document/Heldendokument 80
#

FILENAME=$1
DESTINATION=$2
SIZE=$3
echo Filename: ${FILENAME}
echo Destination: ${DESTINATION}
echo Size: ${SIZE}

DENSITY=$((${SIZE} * 4))
echo Density: ${DENSITY}

convert -density ${DENSITY} ${FILENAME} -depth 8 -resize 25% ${DESTINATION}-%02d.png
