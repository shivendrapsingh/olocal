FROM python:3.6-alpine

RUN adduser -D olocal

WORKDIR /home/olocal

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip install gunicorn pymysql

COPY app app
COPY migrations migrations
COPY olocal.py config.py boot.sh ./
RUN chmod +x boot.sh

ENV FLASK_APP olocal.py

RUN chown -R olocal:olocal ./
USER olocal

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]