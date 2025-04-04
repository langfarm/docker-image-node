FROM --platform=${TARGETPLATFORM:-linux/amd64} langfarm/alinux3:3.9

ARG NODE_VERSION
ENV NODE_VERSION=${NODE_VERSION:-20.19.0}

RUN curl -o- https://fnm.vercel.app/install | bash -s -- --install-dir "/usr/local/bin" --skip-shell

ENV FNM_DIR=/usr/local/share/fnm

RUN fnm install --fnm-dir ${FNM_DIR} ${NODE_VERSION} \
    && ln -s ${FNM_DIR}/node-versions/v${NODE_VERSION}/installation/bin/node /usr/local/bin/node \
    && ln -s ${FNM_DIR}/node-versions/v${NODE_VERSION}/installation/bin/npm /usr/local/bin/npm \
    && ln -s ${FNM_DIR}/node-versions/v${NODE_VERSION}/installation/bin/npx /usr/local/bin/npx \
    && ln -s ${FNM_DIR}/node-versions/v${NODE_VERSION}/installation/bin/corepack /usr/local/bin/corepack

# node 镜像源
ENV FNM_NODE_DIST_MIRROR=https://mirrors.ustc.edu.cn/node/
#ENV FNM_NODE_DIST_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/

# npm 镜像源
ENV COREPACK_NPM_REGISTRY=https://registry.npmmirror.com
RUN npm config set registry https://registry.npmmirror.com -g
