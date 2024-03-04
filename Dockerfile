# Use a imagem oficial do Python
FROM python:3.12-alpine

# Update the package list
RUN apk update && apk upgrade

# Install chromium, chromium-chromedriver, xvfb, curl, unzip, libexif, udev
RUN apk add curl unzip libexif udev chromium chromium-chromedriver xvfb

# RUN pip install --no-cache-dir \
#     selenium \
#     webdriver-manager

# Make dir app
RUN mkdir /app
WORKDIR /app

# Copy content of app to /app
COPY ./app ./

# Install the requirements
RUN pip3 install -r ./requirements.txt

# Exponha a porta do FastAPI
EXPOSE 8000

# Comando para executar o aplicativo FastAPI
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "4404"]
