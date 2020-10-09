#!/bin/bash

/usr/bin/python3 /home/luis.filho/bin/LuisFilhoCrawlerBOVESPA.py;
/usr/bin/python3 /home/luis.filho/bin/LuisFilhoCrawlerDOLAR.py;
/usr/bin/python3 /home/luis.filho/bin/LuisFilhoCrawlerNASDAQ.py &&
/bin/bash /home/luis.filho/bin/stat.sh

