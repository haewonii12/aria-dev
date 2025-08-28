FROM nginx:alpine
WORKDIR /usr/share/nginx/html

# build_out 아티팩트 내용을 nginx 기본 html 디렉토리에 복사
COPY ./*.html ./

EXPOSE 80
