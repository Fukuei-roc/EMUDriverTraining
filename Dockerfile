# 使用 Node.js 官方映像
FROM node:18-alpine

# 設定工作目錄
WORKDIR /app

# 複製 package 檔案
COPY package*.json ./

# 安裝依賴
RUN npm install

# 複製所有應用程式檔案
COPY . .

# 暴露埠號 (根據您的開發伺服器設定，通常是 3000 或 8080)
EXPOSE 3000

# 啟動命令
CMD ["npm", "run", "dev"]