const express=require("express");
const db=require("./db");
const cors=require("cors");
const connectDB = require("./db");
require('dotenv').config();

const authRoute=require("./routes/auth");
const jobRoute=require("./routes/jobRoutes");
const otpRoute=require("./routes/otpRoutes");
const app=express();
const PORT=3000;
app.use(cors());
app.use(express.json());
connectDB();
app.use("/job",jobRoute);

app.use("/",authRoute);
app.use("/",otpRoute);

app.listen(PORT,()=>{
    console.log(`Running on PORT ${PORT}`);
});