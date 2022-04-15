#!/bin/bash
echo "*** Building directory structure ***"
mkdir -p tempdir/{templates,static}
cp -a ./static/. ./tempdir/static
cp -a ./templates/. ./tempdir/templates
cp ./desafio2_app.py ./tempdir/
cd tempdir
echo "*** Creating Dockerfile ***"
touch Dockerfile
echo "FROM python" >> DOCKERFILE
echo "RUN pip install flask" >> DOCKERFILE
echo "COPY ./static /home/myapp/static/" >> DOCKERFILE
echo "COPY ./templates /home/myapp/templates/" >> DOCKERFILE
echo "COPY desafio2_app.py /home/myapp/" >> DOCKERFILE
echo "EXPOSE 5050" >> DOCKERFILE
echo "CMD python3 /home/myapp/desafio2_app.py" >> DOCKERFILE
sudo chmod 666 /var/run/docker.sock
echo "*** Building Docker Image ***"
docker build -t python-app .
echo "*** Running Docker Container ***"
docker run -t -d -p 5050:5050 --name python-app-running python-app
echo "*** Listing Docker Container ***"
docker ps -a
echo "*************** PROCESS COMPLETED! Please visit  http://localhost:5050 "