# Create the base image
FROM selenium/standalone-chrome:latest

USER root

# Update the package list
RUN apt-get update

# Alais python3 to python
RUN ln -s /usr/bin/python3 /usr/bin/python

# Install pip
RUN apt install python3-pip -y

# Make dir app
RUN mkdir /app
WORKDIR /app

# Copy content of app to /app
COPY ./app ./

# Copy the requirements file
COPY ./requirements.txt ./requirements.txt

# Install the requirements
RUN pip3 install -r ./requirements.txt
