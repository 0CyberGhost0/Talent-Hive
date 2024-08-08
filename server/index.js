const express=require("express");
const db=require("./db");
const cors=require("cors");
const connectDB = require("./db");
const authRoute=require("./routes/auth");
const jobRoute=require("./routes/jobRoutes");
const app=express();
const PORT=3000;
app.use(cors());
app.use(express.json());
connectDB();
app.use("/",authRoute);
app.use("/",jobRoute);
app.listen(PORT,()=>{
    console.log(`Running on PORt ${PORT}`);
});