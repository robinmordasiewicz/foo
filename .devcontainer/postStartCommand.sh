#!/bin/bash
#

echo '' > /tmp/mkdocs.tmp
source /opt/conda/etc/profile.d/conda.sh

conda activate mkdocs
nohup bash -c 'mkdocs serve&' > /tmp/mkdocs.tmp

