# Use the specified Python version
FROM python:3.11
ARG GIT_COMMIT
ENV APP_VERSION=$GIT_COMMIT
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY gunicorn_conf.py .
COPY start-new.sh .
COPY app/ /app/app/
CMD ["./start-new.sh"]