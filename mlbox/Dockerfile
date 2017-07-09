FROM ubuntu:latest

RUN apt-get update && apt-get install -y build-essential python-dev python-tk && apt-get clean && rm -rf /var/lib/apt/lists/*
ADD https://bootstrap.pypa.io/get-pip.py ./get-pip.py
RUN python get-pip.py
RUN pip install cmake
RUN pip install jupyter
ADD https://github.com/AxeldeRomblay/mlbox/tarball/master ./master
RUN cd master/AxeldeRomblay-MLBox-2e5e8eb/python-package/ && python setup.py install

EXPOSE 8888

CMD ["/usr/local/bin/jupyter", "notebook", "--ip=0.0.0.0", "--allow-root"] 
