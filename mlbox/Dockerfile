FROM ubuntu:latest

RUN apt-get update && apt-get install -y build-essential python-dev python-tk python-pip && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN pip install --upgrade pip && pip install pip cmake jupyter
ADD https://github.com/AxeldeRomblay/mlbox/tarball/master ./master
RUN cd master/AxeldeRomblay-MLBox-2e5e8eb/python-package/ && python setup.py install

EXPOSE 8888

CMD ["/usr/local/bin/jupyter", "notebook", "--ip=0.0.0.0", "--allow-root"] 
