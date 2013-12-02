#!/bin/sh
#
# creates a the staging site
#

SITE=~/Downloads/dsa-documents/site
rm -rf ${SITE}
mkdir -p ${SITE}
mvn site site:stage -DstagingDirectory=${SITE} -DtopSiteURL=http://www.thinkingstone.de
firefox /home/mb/Downloads/dsa-documents/site/index.html &