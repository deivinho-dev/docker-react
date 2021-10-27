# Build Phase: Install dependencies and run npm build
FROM node:alpine as builder

RUN mkdir -p /home/node/app
WORKDIR '/home/node/app'

COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Run Phase
FROM nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html
