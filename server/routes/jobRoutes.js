const mongoose=require("mongoose");
const express=require("express");
const Job=require("../models/jobModel");
const jobRoute=express.Router();
jobRoute.post("/postJob",async(req,res)=>{
    try{
        const {title,org,type,minSalary,maxSalary,description,skill,imageUrl}=req.body;
        var job=new Job({
            title,org,type,minSalary,maxSalary,description,skill,imageUrl

        });
        await job.save();
        return res.status(200).json(job);
    }catch(err){
        res.status(500).json({error:err});
    }
});
jobRoute.post("/:type",async(req,res)=>{
    try {
        const category=req.params.type;
        console.log(category);
        const jobs=await Job.find({"type":category});
        res.status(200).json(jobs);
        
    } catch (err) {
        res.status(500).json({error:err});        
    }
})
module.exports=jobRoute;