FROM python:2.7

WORKDIR /usr/src/pyramid_app

COPY . ./

RUN pip install --no-cache-dir --upgrade pip setuptools && \
    pip install --no-cache-dir -e ".[testing]" && \
    chmod +x ./backend_entrypoint.sh && \
    mv backend_entrypoint.sh /usr/local/bin/

ENTRYPOINT ["backend_entrypoint.sh"]