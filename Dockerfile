FROM --platform=${TARGETPLATFORM:-linux/amd64} langfarm/alinux3:3.9

ARG NODE_VERSION
ENV NODE_VERSION=${NODE_VERSION:-20.19.0}

RUN curl -o- https://fnm.vercel.app/install | bash -s -- --install-dir "/usr/local/bin" --skip-shell

RUN fnm install ${NODE_VERSION}

# node 镜像源
ENV FNM_NODE_DIST_MIRROR=https://mirrors.ustc.edu.cn/node/
#ENV FNM_NODE_DIST_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/

# npm 镜像源
ENV COREPACK_NPM_REGISTRY=https://registry.npmmirror.com
RUN npm config set registry https://registry.npmmirror.com -g
