const express=require("express");
var randomize=require("randomatic");
const otpRoutes=express.Router();
const sendMail=require("../mailer/mailer");
const OTP=require("../models/otpModel");
const User = require("../models/userModel");
const { OperationCanceledException } = require("typescript");
function generateOTP(length = 5) {
    return randomize('0',length);
}
otpRoutes.post("/getOtp",async (req,res)=>{
    try {
        const {email}=req.body;
        const user=await User.findOne({email:email});
        if(!user) return res.status(500).json({error:"User doesnt exist"});
        const otp=generateOTP();
        const htmlMessage = `
            <h1>Account Created on Talent Hive</h1>
            <p>Dear user,</p>
            <p>Thank you for signing up with Talent Hive. Your account has been created successfully.</p>
            <p>Please use the following OTP to verify your email address:</p>
            <h2>${otp}</h2>
            <p>This OTP is valid for 10 minutes.</p>
            <p>If you did not request this, please ignore this email.</p>
            <p>Best regards,<br/>Talent Hive Team</p>
        `;
        const newOtp=new OTP({
            otp,
            email,
        });
        await newOtp.save();
        console.log(otp);
        // await sendMail(email,"Welcome to Talent Hive: Your Account Has Been Successfully Created",htmlMessage);
        res.status(200).json({msg:"Email Sent Successfully"});
    } catch (err) {
        console.log(err);        
    }
});
otpRoutes.post("/verifyOtp",async (req,res)=>{
    try {
        console.log("INSIDE VERIFY OTP");
        const {email,otp}=req.body;
        if(!otp) return res.status(500).json({error:"Enter OTP!"});
        const existingOTP=await OTP.findOne({"email":email});
        if(!existingOTP) return res.status(500).json({error:"User doesn't exist"});
        if(existingOTP.expiresAt<Date.now()) return res.status(500).json({error:"OTP expired"});
        if(existingOTP.otp!= otp) return res.status(500).json({error:"Invalid OTP"});
        await OTP.deleteOne({"email":email});
        console.log(otp);
        res.status(200).json({msg:"Successfully Verified"});
    } catch (err) {
        console.log(err);        
    }
});
module.exports=otpRoutes;