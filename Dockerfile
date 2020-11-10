FROM ubuntu:18.04
RUN apt update && apt install -y python3-dev gcc python3-pip libssl-dev
RUN mkdir /app
ADD webserver.py /app
ADD requirements.txt /
RUN pip3 install -r requirements.txt
EXPOSE 3000
WORKDIR /app
CMD ["python3", "./webserver.py"]
