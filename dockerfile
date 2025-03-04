# Stage 1: Build the Node.js application
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . ./

# Define environment variables
ENV PG_USER=postgres
ENV PG_HOST=host.docker.internal # Important for local postgres
ENV PG_DATABASE=survey
ENV PG_PASSWORD=scansky
ENV PG_PORT=5432
ENV PORT=5000
ENV PG_LOCALIZATION=localization00
ENV PG_MUNICIPALITIES=municipalities
ENV FRONTEND_URL=http://localhost:3000
ENV JWT_SECRET=renkyubayot
ENV PATH_TO_CERT=./certs/cert.pem
ENV PATH_TO_KEY=./certs/key.pem
ENV NODE_ENV=development
ENV HMAC_SECRET='3536ff5e50198beb4f44c5db7ec'
ENV CRYPTO_SECRET='oZ8Xtn14^zR'
ENV SESSION_SECRET='oZ8Xtn14^zR'
ENV BERTSENT_ENDPOINT="https://lpn44hs6cuzsncsk.us-east-1.aws.endpoints.huggingface.cloud"
ENV BERTOPIC_ENDPOINT="https://rcw8o59obk3klb42.us-east-1.aws.endpoints.huggingface.cloud"

EXPOSE 5000

CMD ["npm", "start"]