# Use the specified Python version
FROM python:3.11

# Define build arguments
ARG GIT_TAG
ARG GIT_COMMIT_HASH

# Set APP_VERSION using GIT_TAG or GIT_COMMIT_HASH
ENV APP_VERSION=${GIT_TAG:-${GIT_COMMIT_HASH}}

# Set the working directory
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY start.sh .
COPY .env* ./
COPY app/ /app/app/
RUN if [ -f .env ]; then \
    AWS_ACCESS_KEY_ID=$(grep -E '^AWS_ACCESS_KEY_ID=' .env | cut -d '=' -f2-) && \
    AWS_SECRET_ACCESS_KEY=$(grep -E '^AWS_SECRET_ACCESS_KEY=' .env | cut -d '=' -f2-) && \
    AWS_PROFILE_NAME=$(grep -E '^AWS_PROFILE_NAME=' .env | cut -d '=' -f2-) && \
    mkdir -p /root/.aws && \
    echo "[$AWS_PROFILE_NAME]" > /root/.aws/credentials && \
    echo "aws_access_key_id = $AWS_ACCESS_KEY_ID" >> /root/.aws/credentials && \
    echo "aws_secret_access_key = $AWS_SECRET_ACCESS_KEY" >> /root/.aws/credentials; \
fi
CMD ["./start.sh"]