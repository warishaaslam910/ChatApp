import express from "express";
import http from "http";
import { Server } from "socket.io";
import cors from "cors";
import dotenv from "dotenv";
import pool  from "./config/db.js";

import fs from "fs";
import path from "path";

import authRoutes from "./routes/authRoutes.js";
import messageRoutes from "./routes/messageRoutes.js";

import { saveMessage } from "./models/messageModel.js";

dotenv.config();

const app = express();
const server = http.createServer(app);

const io = new Server(server, {
  cors: {
    origin: "*", // allow Flutter app
    methods: ["GET", "POST"],
  },
});

app.use(cors());
app.use(express.json());

// Routes
app.use("/api/auth", authRoutes);
app.use("/api/messages", messageRoutes);
app.use("/api/users", authRoutes);


// ==========================
// ✅ Postgres initialization
// ==========================
// const { Pool } = pkg;

// const pool = new Pool({
//   user: process.env.DB_USER || "postgres",
//   host: process.env.DB_HOST || "localhost", // or Docker service name
//   database: process.env.DB_NAME || "mydb",
//   password: process.env.DB_PASSWORD || "password",
//   port: process.env.DB_PORT || 5432,
// });

const initDB = async () => {
  try {
 const sqlPath = path.join(process.cwd(), "src", "data", "data.sql");
const sql = fs.readFileSync(sqlPath, "utf8");
await pool.query(sql);
    console.log("✅ Tables checked/created successfully");
  } catch (err) {
    console.error("❌ Error initializing DB:", err);
  }
};

// ==========================
// Socket.IO connection
// ==========================
io.on("connection", (socket) => {
  console.log("New client connected: " + socket.id);

  socket.on("join", (userId) => {
    socket.join(userId);
    console.log(`User ${userId} joined room`);
  });

  socket.on("send_message", async ({ senderId, receiverId, message }) => {
    io.to(receiverId).emit("receive_message", { senderId, message });
    await saveMessage(senderId, receiverId, message);
  });

  socket.on("disconnect", () => {
    console.log("Client disconnected: " + socket.id);
  });
});

// ==========================
// Start server after DB init
// ==========================
// initDB().then(() => {
//   server.listen(process.env.PORT, () => {
//     console.log(`🚀 Server running on port ${process.env.PORT}`);
//   });
// });
initDB().then(() => {
  server.listen(process.env.PORT, "0.0.0.0", () => {
    console.log(`🚀 Server running on http://0.0.0.0:${process.env.PORT}`);
  });
});

console.log("Connecting to DB with:", {
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  db: process.env.DB_NAME,
  port: process.env.DB_PORT,
});





// import express from "express";
// import http from "http";
// import { Server } from "socket.io";
// import cors from "cors";
// import dotenv from "dotenv";
// import authRoutes from "./routes/authRoutes.js";
// import messageRoutes from "./routes/messageRoutes.js";
// import { saveMessage } from "./models/messageModel.js";

// dotenv.config();

// const app=express();
// const server = http.createServer(app);

// const io = new Server(server, {
//   cors: {
//     origin: "*", // allow Flutter app
//     methods: ["GET", "POST"]
//   }
// });

// app.use(cors());
// app.use(express.json());

// // Routes
// app.use("/api/auth", authRoutes);
// app.use("/api/messages", messageRoutes);
// // Socket.IO connection
// // io.on("connection", (socket) => {
// //   console.log("New client connected: " + socket.id);

// //   socket.on("join", (userId) => {
// //     socket.join(userId); // join a room with user id
// //   });
// // })

// //   socket.on("send_message", async ({ senderId, receiverId, message }) => {
// //     io.to(receiverId).emit("receive_message", { senderId, message });
// //     await saveMessage(senderId, receiverId, message);
// //   });

// //   socket.on("disconnect", () => {
// //     console.log("Client disconnected: " + socket.id);
// //   });

// io.on("connection", (socket) => {
//   console.log("New client connected: " + socket.id);

//   socket.on("join", (userId) => {
//     socket.join(userId);
//     console.log(`User ${userId} joined room`);
//   });

//   // 👇 moved here
//   socket.on("send_message", async ({ senderId, receiverId, message }) => {
//     io.to(receiverId).emit("receive_message", { senderId, message });
//     await saveMessage(senderId, receiverId, message);
//   });

//   // 👇 moved here
//   socket.on("disconnect", () => {
//     console.log("Client disconnected: " + socket.id);
//   });
// });

//   server.listen(process.env.PORT, () =>
//   console.log(`Server running on port ${process.env.PORT}`)
// );