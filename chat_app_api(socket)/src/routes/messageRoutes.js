import express from "express";
import { fetchMessages,createMessage } from "../controllers/messageController.js";

const router = express.Router();

router.get("/:user1/:user2", fetchMessages);
router.post("/", createMessage);


export default router;
