FROM python:3.9.23
WORKDIR /app /app
COPY . .
RUN pip install -r app/requirements.txt
CMD ["python", "app/main.py"]
