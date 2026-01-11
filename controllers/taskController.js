const Task = require("../models/Task");
const Vendor = require("../models/Vendor");

// 🔹 STATIC HYGIENE CATEGORIES (DO NOT CHANGE DAILY)
const CATEGORIES = [
  { name: "Personal Hygiene", maxPoints: 15 },
  { name: "Utensil Cleanliness", maxPoints: 15 },
  { name: "Water Safety", maxPoints: 10 },
  { name: "Food Storage", maxPoints: 15 },
  { name: "Waste Disposal", maxPoints: 10 },
  { name: "Pest Control", maxPoints: 10 },
  { name: "Cooking & Freshness", maxPoints: 25 }
];

exports.getTodayTasks = async (req, res) => {
  const { vendorId } = req.params;

  const mongoose = require("mongoose");

  if (!mongoose.Types.ObjectId.isValid(vendorId)) {
    return res.status(400).json({
      message: "Invalid vendorId"
    });
  }

  const vendor = await Vendor.findById(vendorId);
  // 🔒 SAFETY: if monitoringStartDate missing (old vendor)
  if (!vendor.monitoringStartDate) {
    const start = new Date();
    vendor.monitoringStartDate = start;
    vendor.monitoringEndDate = new Date(
      start.getTime() + 15 * 24 * 60 * 60 * 1000
    );
    await vendor.save();
  }

  if (!vendor) {
    return res.status(404).json({ message: "Vendor not found" });
  }

  const today = new Date();
  const dayNumber =
    Math.floor(
      (today - vendor.monitoringStartDate) / (1000 * 60 * 60 * 24)
    ) + 1;

  if (dayNumber > 15) {
    return res.json({ message: "Monitoring period completed" });
  }

  // ✅ Check if today's tasks already exist
  let tasks = await Task.find({ vendorId, dayNumber });
  if (tasks.length > 0) {
    return res.json({ dayNumber, tasks });
  }

  // ✅ Shuffle categories INSIDE the function
  const shuffled = [...CATEGORIES].sort(() => 0.5 - Math.random());
  const selected = shuffled.slice(0, 3);

  // ✅ Create 3 tasks for today
  tasks = await Task.insertMany(
    selected.map(cat => ({
      vendorId,
      category: cat.name,
      title: cat.name,
      dayNumber,
      maxPoints: cat.maxPoints,
      status: "pending"
    }))
  );

  res.json({ dayNumber, tasks });
};

exports.submitProof = async (req, res) => {
  console.log("FILES RECEIVED:", req.files);   // 🔴 ADD THIS
  console.log("BODY RECEIVED:", req.body);
  const { taskId } = req.body;

  const task = await Task.findById(taskId);
  if (!task) {
    return res.status(404).json({ message: "Task not found" });
  }

  if (req.files?.image) {
    task.proofImage = `/uploads/${req.files.image[0].filename}`;
  }

  if (req.files?.video) {
    task.proofVideo = `/uploads/${req.files.video[0].filename}`;
  }

  task.status = "submitted";
  await task.save();

  res.json({ success: true });
};
exports.evaluateTask = async (req, res) => {
  const { taskId, awardedPoints } = req.body;

  const task = await Task.findById(taskId);
  if (!task) {
    return res.status(404).json({ message: "Task not found" });
  }

  if (awardedPoints > task.maxPoints) {
    return res.status(400).json({
      message: "Awarded points cannot exceed max points"
    });
  }

  task.awardedPoints = awardedPoints;
  task.status = "evaluated";
  await task.save();

  // update vendor total score
  const vendor = await Vendor.findById(task.vendorId);
  vendor.totalScore += awardedPoints;
  await vendor.save();

  // certification check
  if (vendor.totalScore >= 80) {
    vendor.status = "certified";
    await vendor.save();
  }

  res.json({
    success: true,
    totalScore: vendor.totalScore,
    status: vendor.status
  });
};
exports.evaluateTask = async (req, res) => {
  const { taskId, awardedPoints } = req.body;

  const task = await Task.findById(taskId);
  if (!task) {
    return res.status(404).json({ message: "Task not found" });
  }

  if (awardedPoints > task.maxPoints) {
    return res.status(400).json({
      message: "Awarded points cannot exceed max points"
    });
  }

  task.awardedPoints = awardedPoints;
  task.status = "evaluated";
  await task.save();

  // update vendor total score
  const vendor = await Vendor.findById(task.vendorId);
  vendor.totalScore += awardedPoints;
  await vendor.save();

  // certification check
  if (vendor.totalScore >= 80) {
    vendor.status = "certified";
    await vendor.save();
  }

  res.json({
    success: true,
    totalScore: vendor.totalScore,
    status: vendor.status
  });
};


