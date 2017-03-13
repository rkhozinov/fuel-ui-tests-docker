FROM base

ARG FUEL_WEB_REQS
RUN pip install --upgrade pip && \
    pip install -r $FUEL_WEB_REQS && \
    pip install --upgrade tox
