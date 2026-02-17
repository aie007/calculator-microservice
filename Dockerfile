FROM ubuntu:latest

RUN apt-get update && apt-get install -y dos2unix

WORKDIR /app

COPY calculator.sh /app/calculator.sh

# convert line endings to unix style
RUN dos2unix /app/calculator.sh

# ensure script has execute permission
RUN chmod +x /app/calculator.sh

CMD ["bash", "/app/calculator.sh"]
