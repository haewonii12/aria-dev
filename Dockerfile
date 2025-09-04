# ---- Base image ----
FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# AWS CLI 설치 (S3 접근용)
# 인터넷 차단 환경에서는 build-essential 같은 system deps를 설치할 수 없으므로
# CodeBuild에서 미리 wheelhouse.tar.gz / debs.tar.gz 를 만들어 S3에 올려야 함
RUN pip install --no-cache-dir awscli

# --- System deps 설치 ---
# CodeBuild 파이프라인에서 debs.tar.gz 를 준비했다고 가정
RUN aws s3 cp s3://haewon-dependency/system-deps/latest/debs.tar.gz /tmp/debs.tar.gz \
    && mkdir -p /tmp/debs \
    && tar -xzf /tmp/debs.tar.gz -C /tmp/debs \
    && dpkg -i /tmp/debs/*.deb || apt-get install -f -y \
    && rm -rf /tmp/debs*

# --- Python deps 설치 ---
# CodeBuild 파이프라인에서 wheelhouse.tar.gz 를 준비했다고 가정
RUN aws s3 cp s3://haewon-dependency/haewon/latest/wheelhouse.tar.gz /tmp/wheelhouse.tar.gz \
    && mkdir -p /tmp/wheelhouse \
    && tar -xzf /tmp/wheelhouse.tar.gz -C /tmp/wheelhouse \
    && pip install --no-index --find-links=/tmp/wheelhouse -r /tmp/wheelhouse/requirements.txt \
    && rm -rf /tmp/wheelhouse /tmp/wheelhouse.tar.gz

# --- Django 프로젝트 복사 ---
COPY ./django-project/ /app/

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

