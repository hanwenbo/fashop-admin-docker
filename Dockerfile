FROM node:10

ARG FASHOP_ADMIN_VERSION=v2-beta.0.0.3
ENV FASHOP_ADMIN_VERSION_ENV=${FASHOP_ADMIN_VERSION}

# 换淘宝源
RUN npm config set registry https://registry.npm.taobao.org/

# serve
RUN npm install -g serve

# umi
RUN npm install -g umi

RUN wget https://github.com/mojisrc/fashop-admin/archive/${FASHOP_ADMIN_VERSION_ENV}.tar.gz -O fashop-admin.tar.gz \
    && mkdir -p fashop-admin \
    && tar -xf fashop-admin.tar.gz -C fashop-admin --strip-components=1 \
    && rm fashop-admin.tar.gz \
    && cd fashop-admin \
    && rm -rf ./node_modules  \
    && rm -rf ./dist \
    && npm install \
    && npm run build \
    && cd dist \
    && serve .


EXPOSE 5000

ENTRYPOINT ["serve", "-s", ".", "-p", "5000"]
