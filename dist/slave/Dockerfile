FROM python

ADD requirements.txt /
RUN pip install -r requirements.txt

ADD api/ api/
EXPOSE 8000

CMD ["gunicorn", "sample:api", "-b", ":8000", "--chdir", "/api"]

