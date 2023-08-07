FROM python:3.9
WORKDIR /app
COPY FlaskApp /app

RUN pip install --trusted-host pypi.python.org -r requirements.txt
EXPOSE 5002
CMD ["python", "app.py"]
