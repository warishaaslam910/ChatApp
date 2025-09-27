import express from "express";
import { registerUser, loginUser,fetchAllUsers } from "../controllers/authController.js";

const router = express.Router();

router.post("/register", registerUser);
router.post("/login", loginUser);
router.get("/all", fetchAllUsers);

export default router;
