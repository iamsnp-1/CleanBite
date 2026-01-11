const Vendor = require("../models/Vendor");

exports.getDashboard = async (req, res) => {
  const { vendorId } = req.params;

  const vendor = await Vendor.findById(vendorId);

  if (!vendor) {
    return res.status(404).json({ message: "Vendor not found" });
  }

  res.json({
    ownerName: vendor.ownerName,
    status:
      vendor.status === "certified"
        ? "Certified"
        : "Hygiene in Progress",
    qrAvailable: true
  });
};
