FROM ubuntu:24.04

LABEL maintainer="eu4ng97@gmail.com"
LABEL version="0.1.0"
LABEL description=""

# 환경 변수 설정
ENV TZ=Asia/Seoul  \
    DEBIAN_FRONTEND=noninteractive  \
    RUNNER_ALLOW_RUNASROOT=1  \
    GITHUB_ORGANIZATION=ORG

# 패키치 설치 및 업데이트
RUN apt-get upgrade -y  \
    && apt-get update  \
    && apt-get install -y tzdata curl libicu-dev jq \
    && apt-get clean  \
    && rm -rf /var/lib/apt/lists/*

# 작업 디렉토리 설정
WORKDIR /actions-runner

# init.sh 파일 추가
COPY init.sh init.sh
RUN chmod +x init.sh

# runner 설치
RUN curl -o actions-runner-linux-x64-2.323.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.323.0/actions-runner-linux-x64-2.323.0.tar.gz  \
    && tar xzf ./actions-runner-linux-x64-2.323.0.tar.gz  \
    && rm -rf actions-runner-linux-x64-2.323.0.tar.gz

ENTRYPOINT [ "./init.sh" ]
