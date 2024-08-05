const express=require("express");
const authRouter=express.Router();
const User=require("../models/userModel");
const bcrypt=require("bcryptjs");
const jwt=require("jsonwebtoken");
authRouter.post("/signup",async (req,res)=>{
    try{
        const {email,password}=req.body;
        if(!email){
            res.statusCode(400).json({error:"Email cant be empty"});
        }
        if(!password){
            res.statusCode(400).json({error:"Enter Password"});
        }
        const existingUser=await User.findOne({email});
        if(existingUser){
            return res.status(500).json({error:"User already exists."});
        }
        const salt = await bcrypt.genSalt(10);
        const hashedPassword=await bcrypt.hash(password,salt);

        const user=User({
            email,
            password:hashedPassword,
        });
        await user.save();
        res.status(200).json({msg:"Account Created Successfully"});


    }catch(err){
        res.status(500).json({error:err.message});
    }
});
authRouter.post("/login",async (req,res)=>{
    try {
        const {email,password}=req.body;
        if(!email){
            return res.status(400).json({error:"Email cant be empty"});
        }
        if(!password){
            return res.status(400).json({error:"Enter Password"});
        }
        const user=await User.findOne({email:email});
        if(!user){
            return res.status(400).json({error:"User not found with this email"});
        }
        const token=jwt.sign({email},"jwtPassword");
        res.status(200).json({msg:"Login Successfull",token:token});  
    } catch (err) {
        res.status(500).json({error:err.message});
        
    }
});

module.exports=authRouter;