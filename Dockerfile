# Use a imagem oficial do Python
FROM python:3.12-alpine AS base

# Update the package list
RUN apk update && apk upgrade

# Install chromium, chromium-chromedriver, xvfb, curl, unzip, libexif, udev
RUN apk add curl unzip libexif udev chromium chromium-chromedriver xvfb

# Make dir app
RUN mkdir /app
WORKDIR /app

# Copy content of app to /app
COPY ./app ./

# Install the requirements
RUN pip3 install -r ./requirements.txt

# Exponha a porta do FastAPI
EXPOSE 8000

# DEV container
FROM base AS dev

# Command to run the FastAPI app with auto-reload
CMD ["uvicorn", "main:app", "--reload", "--host", "0.0.0.0", "--port", "4404"]

# PROD container
FROM base AS prod

# Command to run the FastAPI app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "4404"]
