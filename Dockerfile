FROM python:3.11-slim-bullseye

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    TZ=Asia/Yangon

WORKDIR /app

COPY requirements.txt .

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends tzdata \
    && pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt \
    && playwright install chromium --with-deps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY . .


CMD ["python3", "bot.py"]
