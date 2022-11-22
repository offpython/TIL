from gtts import gTTS # 없는 패키지는 설치해야 함. 
from playsound import playsound 
import os 

os.chdir(os.path.dirname(os.path.abspath(__file__))) #

text = '안녕하세요 마이크로소프트 에이아이 스쿨에 오신 것을 환영합니다.'

tts = gTTS(text = text, lang='ko') #text to speach 
cucrrent_file_path = os.getcwd() + "./hi.mp3"
tts.save(cucrrent_file_path) 

#저장한 파일 play 
playsound(cucrrent_file_path) 