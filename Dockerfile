# Dockerfile (multi-stage with test support)
FROM node:18-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Add a test stage
FROM node:18-alpine as tester
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
# Tests will run here

# Production stage
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html