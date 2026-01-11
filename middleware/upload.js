const multer = require("multer");
const path = require("path");
const fs = require("fs");

const uploadDir = path.join(__dirname, "../uploads");

// LOG THE PATH
console.log("📁 UPLOAD DIR IS:", uploadDir);

// ensure uploads folder exists
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir);
  console.log("📁 uploads folder created");
}

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    console.log("➡️ Saving file to:", uploadDir);
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => {
    const filename = Date.now() + path.extname(file.originalname);
    console.log("📝 File name:", filename);
    cb(null, filename);
  }
});

module.exports = multer({ storage });
