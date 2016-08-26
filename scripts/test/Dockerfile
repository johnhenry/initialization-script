FROM risingstack/alpine:3.4-v6.2.0-3.6.1
COPY run .
RUN chmod +x run
COPY package.json .
RUN npm install
CMD ./run
