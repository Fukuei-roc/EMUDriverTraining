FROM node:18-alpine

WORKDIR /app

# 先安裝依賴（利用快取）
COPY package*.json ./
RUN npm ci --only=production

# 一次帶入所有前端資產（已包含 public/content 與 public/lib）
COPY public/ /app/public/

# 伺服器程式
COPY server.js /app/server.js

ENV NODE_ENV=production
EXPOSE 3000
CMD ["node", "server.js"]
