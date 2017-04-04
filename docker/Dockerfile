FROM node:7.8.0-alpine
COPY ./install .
COPY run .
RUN chmod +x install
RUN chmod +x run
RUN npm init -y
RUN ./install
ENTRYPOINT ["/bin/sh", "-c", "/run  \"$@\"", "--"]
