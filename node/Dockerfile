FROM node:latest

ARG FUEL_UI_NPM_REQS
RUN npm install -g gulp && \
    wget --no-check-certificate -O package.json $FUEL_UI_NPM_REQS && \
    npm install -g
