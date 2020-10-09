# -*- coding: utf-8  -*-

import requests
from bs4 import BeautifulSoup as bs
from datetime import datetime
import os

url = 'https://www.investing.com/equities/StocksFilter?index_id=20'
page = requests.get(url=url, headers={'User-Agent': 'Mozilla/5.0'})

soup = bs(page.text, 'lxml')
table = soup.find('table')

output_rows = []
for table_row in table.findAll('tr'):   # Cada Linha
    columns = table_row.findAll('td')   # Cada Célula da Linha
    output_row = []
    for column in columns[1:-1]:
        output_row.append(column.text)
    output_rows.append(output_row)


with open('{}/crawler_nasdaq/nasdaq{}.txt'.format(os.path.join(os.path.dirname(__file__), '..'),
                                                  datetime.now().strftime("_%Y-%m-%d_%H%M%S")), 'w+') as nasdaq_out:

    nasdaq_out.write('name;last_usd;high_usd;low_usd;chg;chg%;vol;time')
    for line in output_rows:
        nasdaq_out.write(';'.join(line))
        nasdaq_out.write('\n')
