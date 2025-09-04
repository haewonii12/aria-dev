# ---- Base image ----
FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# --- System deps 설치 ---
ARG DEBS_DIR
COPY ${DEBS_DIR}/ /tmp/debs/
RUN dpkg -i /tmp/debs/*.deb || apt-get install -f -y && rm -rf /tmp/debs

# --- Python deps 설치 ---
ARG WHEELHOUSE_DIR
COPY ${WHEELHOUSE_DIR}/ /tmp/wheelhouse/
# requirements.txt는 wheelhouse 안에 없으므로 직접 복사
COPY django-project/requirements.txt /tmp/wheelhouse/requirements.txt
RUN pip install --no-index --find-links=/tmp/wheelhouse -r /tmp/wheelhouse/requirements.txt \
    && rm -rf /tmp/wheelhouse

# --- Django 프로젝트 복사 ---
COPY ./django-project/ /app/

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

