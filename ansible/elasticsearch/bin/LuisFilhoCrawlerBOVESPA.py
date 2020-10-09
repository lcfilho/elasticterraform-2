# -*- coding: utf-8  -*-

import requests
from bs4 import BeautifulSoup as bs
from datetime import datetime
import os

url = 'https://www.investing.com/equities/StocksFilter?index_id=17920'
page = requests.get(url=url, headers={'User-Agent': 'Mozilla/5.0'})

soup = bs(page.text, 'lxml')
table = soup.find('table')

output_rows = []
for table_row in table.findAll('tr'):   
    columns = table_row.findAll('td')  
    output_row = []
    for column in columns[1:-1]:
        output_row.append(column.text)
    output_rows.append(output_row)


with open('{}/crawler_ibov/ibov{}.txt'.format(os.path.join(os.path.dirname(__file__),
                                                          '..'), datetime.now().strftime("_%Y-%m-%d_%H%M%S")), 'w+') as ibov_out:

    ibov_out.write('name;last_rs;high_rs;low_rs;chg;chg%;vol;time')
    for line in output_rows:
        ibov_out.write(';'.join(line))
        ibov_out.write('\n')
