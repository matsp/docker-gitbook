FROM node:alpine

ARG USER=node
ARG GROUP=node
ENV HOME=/opt/gitbook
RUN set -ex \
    && mkdir -p ${HOME} \
    && chown -R ${USER}:${GROUP} ${HOME} \
    && chmod -R 775 ${HOME}

WORKDIR ${HOME}
USER ${USER} 

RUN set -ex \
    && yarn global add gitbook-cli
RUN set -ex \
    && ${HOME}/.yarn/bin/gitbook update
RUN set -ex \
    && npm cache clean -g --force \
    && npm cache clean --force \
    && yarn cache clean

RUN mkdir -p  ${HOME}/book
VOLUME ${HOME}/book
EXPOSE 4000
ENTRYPOINT ["/opt/gitbook/.yarn/bin/gitbook"]
CMD ["--help"]
