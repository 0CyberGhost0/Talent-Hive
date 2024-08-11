const mongoose=require("mongoose");
const express=require("express");
const Job=require("../models/jobModel");
const User = require("../models/userModel");
const jobRoute=express.Router();
jobRoute.get("/search",async(req,res)=>{
    try {
        console.log("inside search");
        const searchText=req.query.text;
        console.log(searchText);
        if(!searchText || searchText.length==0){
            return res.status(400).json({error:"Enter text to search"});
        }
        const jobs=await Job.find({
            title:{
                $regex:searchText,
                $options:"i"
            }
        });
        res.status(200).json(jobs);
    } catch (err) {
        res.status(500).json({error:err});
        
    }
});
jobRoute.post("/postJob",async(req,res)=>{
    try{
        console.log("inside postjob");
        const {title,org,type,minSalary,maxSalary,description,skill,imageUrl}=req.body;
        var job=new Job({
            title,org,type,minSalary,maxSalary,description,skill,imageUrl

        });
        console.log(job);
        await job.save();
        return res.status(200).json(job);
    }catch(err){
        res.status(500).json({error:err});
    }
});
jobRoute.get("/category/:type",async(req,res)=>{
    try {
        const category=req.params.type;
        // console.log(category);
        const jobs=await Job.find({"type":category});
        res.status(200).json(jobs);
        
    } catch (err) {
        res.status(500).json({error:err});        
    }
});

jobRoute.post("/featuredJob", async (req, res) => {
    try {
        console.log("FEATURED JOB");
        const { userId } = req.body;

        // Check if userId is provided
        if (!userId) {
            return res.status(400).json({ error: "userId not provided" });
        }

        // Fetch the user by ID and retrieve the skills
        const user = await User.findById(userId);
        
        if (!user) {
            return res.status(404).json({ error: "User not found" });
        }

        const userSkill = user.skill;

        // Aggregation pipeline to find jobs that match the user's skills
        const jobs = await Job.aggregate([
            {
                $addFields: {
                    matchedSkillsCount: {
                        $size: {
                            $setIntersection: ["$skill", userSkill] // Find common skills
                        }
                    }
                }
            },
            {
                $sort: { matchedSkillsCount: -1 } // Sort by the number of matched skills
            },
            {
                $limit: 7 // Limit the result to top 7 jobs
            }
        ]);

        res.json(jobs);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: err.message });
    }
});


module.exports = jobRoute;

jobRoute.post("/setSkill",async(req,res)=>{
    try {
        console.log("Inside setskill");
        const {skill,userId}=req.body;
        console.log(skill);
        console.log(userId);
        const user=await User.findById(userId);
        if(!user) return res.status(500).json({error:"User doesnt exist"});
        user.skill=skill;
        await user.save();
        res.status(200).json({msg:"Skills Updated Successfully"});

        
    } catch (err) {
        res.status(500).json({error:err});
    }
});

module.exports=jobRoute;