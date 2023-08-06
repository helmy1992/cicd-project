FROM python:3.9
WORKDIR /app
COPY FlaskApp /app
COPY MySQL_Queries /docker-entrypoint-initdb.d
RUN pip install --trusted-host pypi.python.org -r requirements.txt
EXPOSE 5000
CMD ["python", "app.py"]
