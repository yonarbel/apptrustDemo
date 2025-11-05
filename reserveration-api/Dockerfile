# Build
FROM node:20-alpine AS build
WORKDIR /app
RUN echo 'registry=https://registry.npmjs.org/' > /root/.npmrc
COPY package.json package-lock.json* ./
RUN npm install --omit=dev
COPY . .
# Run
FROM node:20-alpine
WORKDIR /app
COPY --from=build /app /app
EXPOSE 3001
CMD ["node", "server.js"]
