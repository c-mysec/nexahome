# syntax=docker/dockerfile:1.7
FROM --platform=$TARGETPLATFORM node:20-alpine

WORKDIR /app

ENV NODE_ENV=production

COPY package*.json ./
RUN npm ci --omit=dev

COPY . .

RUN npm run build

EXPOSE 3001

CMD ["node", "dist/main.js"]
