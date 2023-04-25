FROM node:alpine as builder
WORKDIR '/usr/src/app'
COPY package.json .
RUN npm install
COPY ./ ./
# 빌드 파일들을 컨테이너 안에 생성
RUN npm run build

FROM nginx
# 컨테이너에서 매핑할 포트 정보
EXPOSE 80
# 위에 as builder를 통해 빌드한 파일들이 /usr/src/app/build 내에 존재
# 해당 빌드된 파일들을 /usr/share/nginx/html 로 복사해줘야 nginx가 client 요청에 따른 정적 파일 제공 가능
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
