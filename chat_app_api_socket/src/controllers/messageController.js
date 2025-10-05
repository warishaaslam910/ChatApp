import { saveMessage, getMessages } from "../models/messageModel.js";

export const fetchMessages = async (req, res) => {
  const { user1, user2 } = req.params;
  try {
    const messages = await getMessages(user1, user2);
    res.json(messages);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};


export const createMessage = async (req, res) => {
  const { senderId, receiverId, message } = req.body;
  try {
    await saveMessage(senderId, receiverId, message);
    res.json({ success: true, message: "Message sent successfully" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};