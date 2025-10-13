const path = require('path');
const express = require('express');
const compression = require('compression');

const app = express();
const PORT = process.env.PORT || 3000;

// 開 gzip/deflate 壓縮（讓傳輸更快）
app.use(compression());

// 靜態檔案：public 目錄（index.html、JS、CSS、圖片、content/*.md）
app.use(express.static(path.join(__dirname, 'public'), {
  extensions: ['html'],          // 允許省略 .html
  setHeaders: (res, filePath) => {
    // Markdown 預設不要快取（方便你改了就即時看到）
    if (filePath.endsWith('.md')) {
      res.setHeader('Cache-Control', 'no-store');
      res.type('text/markdown; charset=utf-8'); // 明確 content-type
    }
  }
}));

// 萬用路由：若需要前端路由可改這裡
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, () => {
  console.log(`✅ Server running: http://localhost:${PORT}`);
});
