# -*- coding: utf-8 -*-

from os.path import expanduser
import glob
from datetime import datetime

date = datetime.now().strftime("%Y-%m-%d")
print(date)


paths_in = {"nasdaq": "/home/luis.filho/crawler_nasdaq/processados/nasdaq_{}.json/part*".format( date),
        "ibov": "/home/luis.filho/crawler_ibov/processados/ibov_{}.json/part*".format( date)}

for path in paths_in:
    filename = [name for name in glob.glob(paths_in[path])][0]
    with open(filename, 'r+') as file_json:
        data = file_json.read().splitlines()

    with open(filename, 'w') as new_json:
        for line in data:
            new_json.write("{\"index\" : {} }\n")
            new_json.write(line)
            new_json.write("\n")
            
