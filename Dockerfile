# ---------- Build stage ----------
    FROM node:18-alpine AS builder
    WORKDIR /app
    
    COPY package.json package-lock.json ./
    RUN npm ci
    
    COPY . .
    RUN npm run build
    
    # ---------- Runtime stage ----------
    FROM nginx:alpine
    
    # Remove default nginx static config
    RUN rm -rf /usr/share/nginx/html/*
    
    # Copy CRA build output
    COPY --from=builder /app/build /usr/share/nginx/html
    
    # React Router support
    RUN printf "server {\n\
      listen 80;\n\
      root /usr/share/nginx/html;\n\
      index index.html;\n\
      location / {\n\
        try_files \$uri /index.html;\n\
      }\n\
    }\n" > /etc/nginx/conf.d/default.conf
    
    EXPOSE 80
    CMD ["nginx", "-g", "daemon off;"]
    