import qrcode
import os

# qr_data = 'www.naver.com'
# qr_img = qrcode.make(qr_data) 

# qr_img.save(qr_data + '.png') 

with open('./Samples/site_list.txt', 'rt',encoding='UTF8') as f: #파일은 알아서 닫아주는 코드 
    read_lines = f.readlines()
    
    for line in read_lines:
        line = line.strip() #문자열 양끝의 공백이나 지정된 문자 제거 
        print(line) 

        qr_data = line
        qr_img = qrcode.make(qr_data) 

        qr_img.save('./Samples/' + qr_data +'.png')
# print(read_lines) 
