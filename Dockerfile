FROM python:3.7.3-stretch

WORKDIR /app

COPY . /clouddevops/
cay
RUN pip install --upgrade pip \
    && python3 -m pip install -r /clouddevops/requirements.txt

EXPOSE 80

CMD ["python3", "/clouddevops/app/app.py"]
