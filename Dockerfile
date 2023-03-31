
FROM python:3.9.14-slim-buster
MAINTAINER Karl Swanson <karlcswanson@gmail.com>

RUN apt-get update -y \ && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
RUN apt-get install git curl make build-essential -y --no-install-recommends
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install nodejs -y --no-install-recommends
RUN npm install yarn -g

WORKDIR /usr/src/app
COPY . .

RUN yarn install --prod
RUN pip3 install --no-cache-dir -r py/requirements.txt

RUN yarn build
CMD ["python", "py/micboard.py"]
