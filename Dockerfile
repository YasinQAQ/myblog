FROM node:8.2.1-alpine
ENV KCP_VER 20170525
RUN \
    apk add git --update \
    &&  npm config set unsafe-perm=true \
    &&  npm install -g hexo-cli \
    &&  git clone https://github.com/moclaF/myblog.git \
    &&  cd myblog && npm install
WORKDIR /myblog
EXPOSE 4000
CMD hexo server
