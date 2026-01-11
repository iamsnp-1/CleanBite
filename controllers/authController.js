exports.sendOtp = (req, res) => {
  const { phone } = req.body;

  if (!phone) {
    return res.status(400).json({ message: "Phone required" });
  }

  // Dummy OTP
  const otp = "123456";
  console.log("OTP:", otp);

  res.json({
    success: true,
    message: "OTP sent",
    otp: otp   // for hackathon demo
  });
};

exports.verifyOtp = (req, res) => {
  const { phone, otp } = req.body;

  if (!phone || !otp) {
    return res.status(400).json({ message: "Phone & OTP required" });
  }

  if (otp !== "123456") {
    return res.status(401).json({ message: "Invalid OTP" });
  }

  res.json({
    success: true,
    message: "Login successful",
    vendorId: phone
  });
};
