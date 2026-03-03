# Use an official Ocaml image as base
FROM ocaml/opam:ubuntu-22.04-ocaml-5.4

# set the working directory
WORKDIR /app

# copy project source to container
COPY /src /app

# install requirements


# set execute permissions for ocaml files
RUN chmod +x /app/calculator/calculator.ml /app/tests/calculator_test.ml

# run calculator program 
CMD ["ocaml", "/app/src/calculator/calculator.ml"]
