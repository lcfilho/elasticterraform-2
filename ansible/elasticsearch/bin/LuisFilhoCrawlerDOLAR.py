# -*- codinf: utf-8 -*-

import requests
from bs4 import BeautifulSoup as bs
from datetime import datetime
import os

url = 'https://m.investing.com/currencies/usd-brl'
page = requests.get(url, headers={'User-Agent': 'Mozilla/5.0'})

soup = bs(page.text, 'lxml')

currency = soup.find('div', class_="cryptoCurrentDataMain")
currency = currency.find('h1').text.strip()

value = soup.find('div', class_='quotesBoxTop').find('span').text.strip()

diffs = soup.select('.quotesBoxTop i')
change, perc = [data.text.strip() for data in diffs]

timestamp = soup.find('div', class_='pairTimestamp').text.strip()

with open('{}/crawler_dolar/dolar{}.txt'.format(os.path.join(os.path.dirname(__file__), '..'),
                                                datetime.now().strftime("_%Y-%m-%d_%H%M%S")), 'w+') as dolar_out:
    dolar_out.write('currency;value;chance;perc;timestamp\n')
    dolar_out.write("{};{};{};{};{}".format(currency, value, change, perc, timestamp))
    dolar_out.write('\n')

