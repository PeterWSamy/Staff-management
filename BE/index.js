const express = require("express");
const app = express();
require("dotenv").config();
port = process.env.PORT || 3000;
app.use(express.json());
var cors = require("cors");
app.use(
  cors({
    origin: "*",
  })
);

const initConnection = require("./DB/config");
initConnection();

const { userRoutes, workdayRoutes } = require("./routes/routes");

app.use(`${process.env.PREFIX}/user`, userRoutes);
app.use(`${process.env.PREFIX}/workday`, workdayRoutes);

app.get("/", (req, res) => {
  res.send("Staff App");
});

app.listen(port, () => {
  console.log(`Staff App is running on port ${port}`);
});
