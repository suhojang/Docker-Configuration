### Docker 서버환경 구성

#### 프로젝트 계획 이유
> Docker로 Web Server환경을 손쉽게 하기 위해 DokcerFile/docker-compose.yml 설정 파일 구성

#### 구성
> JDK8, Tomcat9, Mysql, CentOS
> 원하시는 Server Configuration 파일들을 build, init, update 경로에 적용하시고 아래 사용방법으로 처리하시면 됩니다.

#### 사용방법
```
1. bulid(초기 빌드)
  1. docker-compose.yml이 있는 경로로 이동
    - ex) cd /app/docker/build
  
  2) docker-compose.yml 열기
    - vi docker-compose.yml

  3) 이미지명 수정
    - image: [생성할 이미지명]
  
  4) 저장
    - wq!  
    
  5) docker-compose 실행
    - docker-compose build
  
  6) docker image생성 확인
    - docker images
  
  7) docker repository 올리기
    - docker login [docker repository url]
    - 아이디 : [repository id]
    - 비밀번호 : [repository password]
    - docker tag [생성 된 이미지명] [docker repository url]
    - docker push [docker repository url]/[image name]

2. init(초기화)
  1) docker-compose.yml이 있는 경로로 이동
    - ex) cd /app/docker/init
  2) docker-compose 실행
    - docker-compose up -d

3. update(업데이트)
  1) docker-compose.yml이 있는 경로로 이동
    - ex) cd /app/docker/update
  2) docker-compose update 실행
    - docker-compose up -d
```

#### ETC - Dokcer Container 실행
```

1. Server
  - docker container run --privileged -i -t -d -p [public port:private port] \
    --name [container name] \
    [image name] init

2. Database
  - docker container run --privileged -i -t -d -p [public port:private port] \ 
    -e MYSQL_ROOT_PASSWORD=[database password] \
    -v [database volume server path]:[container database data path]:rw \
    --name [container name] \
    [image name]
    
```


```
git clone https://github.com/suhojang/Docker-Configuration.git
```
