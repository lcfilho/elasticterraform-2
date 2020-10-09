#!/bin/bash

dt=$(date '+%Y-%m-%d');
title="BOLSA_";
name="${title}${dt}";
out=$(date '+%Y-%m-%d_%H%M%S')

rm /home/luis.filho/crawler_nasdaq/nasdaq*;

rm /home/luis.filho/crawler_ibov/ibov*;

zip -rm /home/luis.filho/crawler_dolar/processados/dolar_$out.zip /home/luis.filho/crawler_dolar/dolar_$dt*


for file in /home/luis.filho/crawler_nasdaq/processados/nasdaq_$dt.json/part*; do
	add="@$file"
	echo "Indexando o arquivo: $add"
	curl -X POST localhost:9200/$name/doc/_bulk -H "Content-Type: application/x-ndjson" --data-binary $add
done


zip -rm /home/luis.filho/crawler_nasdaq/indexados/nasdaq_$out.zip /home/luis.filho/crawler_nasdaq/processados/nasdaq_$dt.json/



for file in /home/luis.filho/crawler_ibov/processados/ibov_$dt.json/part*; do
        add="@$file"
        echo "Indexando o arquivo: $add"
        curl -X POST localhost:9200/$name/doc/_bulk -H "Content-Type: application/x-ndjson" --data-binary $add
done


zip -rm /home/luis.filho/crawler_ibov/indexados/ibov_$out.zip /home/luis.filho/crawler_ibov/processados/ibov_$dt.json/



curl -X POST "localhost:9200/_aliases" -H 'Content-Type: application/json' -d  '{"actions":{ "add":{"index":"'"$name"'","alias":"BOLSA"}}}'

