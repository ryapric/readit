FROM rocker/tidyverse:latest

RUN mkdir -p /root/readit
WORKDIR /root/readit
COPY . .

CMD ["make", "check"]
