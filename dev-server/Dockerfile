FROM node-base

ARG FUEL_WEB_REQS
RUN easy_install -U pip && \
    pip install -r $FUEL_WEB_REQS && \
    pip install --upgrade tox
