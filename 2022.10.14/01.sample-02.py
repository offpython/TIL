import socket 

# ip adress 는 인터넷 주소. 8비트 4개로 이루어짐 . 8비트 x 4 = 32비트 체계 

in_addr = socket.gethostbyname(socket.gethostname()) #이름으로 id주소를 얻기 

print(in_addr) 

'''
OSI계층 7가지 
인터넷 프로토콜

'''