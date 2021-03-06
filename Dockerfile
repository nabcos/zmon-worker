FROM zalando/python:15.01.03

#making this a cachable point as compile takes forever without -j

RUN apt-get install -y libsnappy-dev libev4 libev-dev

RUN mkdir -p /app
WORKDIR /app

ADD requirements.txt /app/requirements.txt
ADD test_requirements.txt /app/test_requirements.txt
RUN pip install -r /app/requirements.txt

ADD README.rst /app/README.rst
ADD setup.py /app/setup.py
ADD zmon_worker_monitor /app/zmon_worker_monitor
ADD web.conf /app/web.conf
ADD app.py /app/app.py

RUN cd /app && python setup.py install

RUN mkdir -p /app/logs

CMD ["python","app.py"]
