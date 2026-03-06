# Use an Ocaml image as base
FROM aie007/ubuntu-ocaml:5.4-dune-installed

# copy project source to container
COPY . /app

# set the working directory
WORKDIR /app

# set execute permissions for ocaml files
RUN chmod -R +x /app

# run calculator program 
CMD ["dune", "exec", "./src/calculator/app.exe"]
