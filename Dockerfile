FROM node:18-alpine

WORKDIR /app

# 先安裝依賴（利用快取）
COPY package*.json ./
RUN npm ci --only=production

# 把靜態資產與程式打包進映像檔
# 1) public/（含 public/lib、public/index.html 等）
COPY public/ /app/public/
# 2) 將專案根的 content/ 打到 /app/public/content/（補上 images 來源）
COPY content/ /app/public/content/
# 3) 你的前端 lib（若已在 public/lib 可移除這行）
COPY lib/ /app/lib/

# 4) 伺服器程式（若檔名不同請調整）
COPY server.js /app/server.js

ENV NODE_ENV=production
EXPOSE 3000

CMD ["node", "server.js"]
