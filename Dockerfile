# ---- Base image ----
FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# system deps (필요할 경우)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential \
       libpq-dev \
       gcc \
    && rm -rf /var/lib/apt/lists/*

# requirements.txt 가 django-project 안에 있다고 가정
COPY ./django-project/requirements.txt /app/

RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# 프로젝트 전체 복사 (venv 제외)
COPY ./django-project/ /app/
# venv 폴더 제외하고 싶으면 .dockerignore 에 추가
# venv/

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
