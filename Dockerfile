#Basic Image
FROM ubuntu:14.04
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update

#RUN apt-get install -y --force-yes git
RUN apt-get install -y --force-yes nginx
RUN apt-get install -y --force-yes build-essential
RUN apt-get install -y --force-yes python-pip
RUN pip install virtualenv
RUN apt-get install -y --force-yes libblas-dev liblapack-dev gfortran libfreetype6-dev libpng-dev python-dev libxft-dev libpq-dev

#Geo stuff
RUN apt-get install -y software-properties-common
RUN apt-get update -y
RUN apt-get install -y libgdal1h gdal-bin libgdal-dev
ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal


#Create the folder where app lives
#Assumes the entirety of my app is there
RUN mkdir /var/www
RUN mkdir /var/www/geopy
RUN pip install numpy==1.10.1
RUN pip install scipy==0.16.1
ADD ./requirements.txt /var/www/geopy/requirements.txt
RUN pip install -r /var/www/geopy/requirements.txt

#install Supervisor
RUN apt-get install -y --force-yes supervisor

#Set nginx and uwsgi configs
RUN rm /etc/nginx/sites-enabled/default
RUN mkdir -p /var/log/uwsgi
RUN mkdir /etc/uwsgi
RUN mkdir /etc/uwsgi/vassals