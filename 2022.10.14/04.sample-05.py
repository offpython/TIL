from email import header
from typing import Container
from currency_converter import CurrencyConverter 

cc = CurrencyConverter('http://www.ecb.europa.eu/stats/eurofxref/eurofxref.zip') 
print(cc.convert(1,'USD','KRW')) #달러당 원화 

import requests
from bs4 import BeautifulSoup #웹 크롤링 패키지 

def get_exchange_rate(target1, target2):
    headers = {
        'User-Agent': 'Mozilla/5.0', #모질라가 기본 웹브라우저로 많이 사용됨. 호환성을 위해 써줌. 
        'Content-Type': 'text/html; charest=utf-8' #html요청한다 받아줘라 
    }

    response = requests.get('http://kr.investing.com/currencies/{}-{}'.format(target1,target2), headers=headers) 
    content = BeautifulSoup(response.content, 'html.parser')
    Containers = content.find('span',{'data-test':'instrument-price-last'})

    print(Containers.text)

get_exchange_rate('usd','krw') 