# SpringBoot + Websocket을 이용한 채팅 서버 구축 

### 0. 개요
- SpringBoot 환경을 기반으로 하여 Websocket을 이용한 채팅서버 구축 실습.  
- daddyprogrammer.org에서 연재 및 소스 Github 등록
    - https://daddyprogrammer.org/post/series/spring-websocket-chat-server/
    
### 1. 실습 환경
- Java 8~11
- SpringBoot 2.x
- Websocket
- Stomp
- Redis pub/sub
- vue.js, freemarker, bootstrap
- Intellij Community

### 2. 실습 내용
- Spring websocket chatting server(1) – basic websocket server
    - Document
        - https://daddyprogrammer.org/post/4077/spring-websocket-chatting/
    - Git
        - https://github.com/codej99/websocket-chat-server/tree/feature/basic-websocket-server
- Spring websocket chatting server(2) – Stomp로 채팅서버 고도화하기
    - Document
        - https://daddyprogrammer.org/post/4691/spring-websocket-chatting-server-stomp-server/
    - Git
        - https://github.com/codej99/websocket-chat-server/tree/feature/stomp
        
- Spring websocket chatting server(3) – Redis pub/sub를 이용한 채팅서버 구현
    - Document
        - https://daddyprogrammer.org/post/4731/spring-websocket-chatting-server-redis-pub-sub/
    - Git
        - https://github.com/codej99/websocket-chat-server/tree/feature/redis-pub-sub

### 3. 기타
- Websocket Client
    - 실습1에서 사용.
    - Simple websocket client
    - Chrome store : https://chrome.google.com/webstore/search/websocket?hl=ko
- 채팅룸 화면 접속
    - 실습2,3에서 구현하는 채팅 웹뷰 접속 주소
    - http://localhost:8080/chat/room