FROM python:3.7.3-stretch

WORKDIR123 /app

COPY4123 . /clouddevops/
cay
RUN pip install --upgrade pip \
    && python3 -m pip install -r /clouddevops/requirements.txt

EXPOSE 80

CMD ["python3", "/clouddevops/app/app.py"]
