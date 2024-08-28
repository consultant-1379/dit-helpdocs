FROM node:8.9.4-alpine

EXPOSE 8585

WORKDIR /opt/helpdocs/

COPY helpdocs/ /opt/helpdocs/

RUN npm config set unsafe-perm true \
 && npm install -g cdt2 --registry http://presentation-layer.lmera.ericsson.se/registry --proxy null \
 && cdt2 package install --autofill \
 && npm prune \
 && npm cache clean --force \
 && cd /usr/local/lib/node_modules/ \
 && rm -rf cdt-build cdt-package cdt-skeleton npm

CMD cdt2 serve
