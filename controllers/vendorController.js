const Vendor = require("../models/Vendor");
const QRCode = require("qrcode");
const path = require("path");
const fs = require("fs");



exports.registerVendor = async (req, res) => {
  const {
    phone,
    ownerName,
    stallName,
    location,
    foodType
  } = req.body;

  // 1. Save vendor first
  const vendor = new Vendor({
    phone,
    ownerName,
    stallName,
    location,
    foodType,
    status: "in_progress"
  });

  await vendor.save();

  // 2. Create QR content (simple & unique)
  const qrData = `CLEANBITE_VENDOR_${vendor._id}`;
  const qrDir = path.join(__dirname, "../qrcodes");

  if (!fs.existsSync(qrDir)) {
    fs.mkdirSync(qrDir);
  }
  // 3. QR image path
  const qrPath = path.join(
    __dirname,
    `../qrcodes/${vendor._id}.png`
  );

  await QRCode.toFile(qrPath, qrData);




  // 5. Save QR image path in DB
  vendor.qrImage = `/qrcodes/${vendor._id}.png`;
  await vendor.save();

  res.json({
    success: true,
    vendorId: vendor._id
  });

  const today = new Date();
  vendor.monitoringStartDate = today;
  vendor.monitoringEndDate = new Date(
    today.getTime() + 15 * 24 * 60 * 60 * 1000
  );

};
exports.getVendorQR = async (req, res) => {
  const vendor = await Vendor.findById(req.params.vendorId);

  res.json({
    ownerName: vendor.ownerName,
    stallName: vendor.stallName,
    qrImage: vendor.qrImage
  });
};
