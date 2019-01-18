FROM node:10

ARG FASHOP_ADMIN_VERSION=v2-beta.0.0.3
ENV FASHOP_ADMIN_VERSION_ENV=${FASHOP_ADMIN_VERSION}

# 换淘宝源
RUN npm config set registry https://registry.npm.taobao.org/

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
    && npm run build

ADD . fashop-admin-code
VOLUME /fashop-admin-code

#COPY docker-entrypoint.sh /usr/local/bin/
# RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat
#ENTRYPOINT ["docker-entrypoint.sh"]
# CMD 设置容器启动后默认执行的命令及其参数，但 CMD 能够被 docker run 后面跟的命令行参数替换。
# ENTRYPOINT 配置容器启动时运行的命令
CMD ["/bin/echo", "fashop-admin docker is ok now"]
