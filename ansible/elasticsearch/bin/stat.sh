#!/bin/bash

cd /home/luis.filho/bin/;
py="/usr/bin/python3"


/bin/bash spark_submit.sh &&
$py elastic/elastic_formater.py &&
/bin/bash elastic/elastic_loader.sh

