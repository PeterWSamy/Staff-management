const workdayModel = require("../../../DB/models/workday.model");
const userModel = require("../../../DB/models/user.model");

const getAllWorkDays = async (req, res) => {
    try{
        const workdays = await workdayModel.find();
        if(workdays.length == 0){
            res.status(404).json({status:"fail", message:"No workdays found"});
        }else{
            res.status(200).json({status:"success", data:workdays});
        }
    }catch(error){
        return res.status(404).json({status:"fail", message:error.message});
    }
};

const checkIn = async (req, res) => {
    let {email} = req.body;
    let user = await userModel.findOne({email});
    if(!user){
        res.status(404).json({status:"fail", message:"User not found"});
    }else{
        let openWorkday = await workdayModel.findOne({userId:user._id , checkOutTime: null });
        if (openWorkday) {
            return res.status(400).json({ error: "You already have an open workday." });
        }else{
            let workday = new workdayModel({
                checkInTime: req.body.checkInTime,
                userId: user._id
            });
            workday.checkInTime.setHours(workday.checkInTime.getHours() + 2);
            let savedWorkDay = await workday.save();
            res.status(200).json({status:"success", data:savedWorkDay});
        }
    }
};

const checkOut = async (req, res) => {
    var{email , checkOutTime} = req.body;
    let user = await userModel.findOne({email});
    if(!user){
        res.status(404).json({status:"fail", message:"User not found"});
    }else{

        let workday = await workdayModel.findOne({userId:user._id, checkOutTime:null});
        if(!workday){
            res.status(404).json({status:"fail", message:"Workday not found"});
        }else{
            workday.checkOutTime = checkOutTime;
            workday.checkOutTime.setHours(workday.checkOutTime.getHours() + 2);

            workday.workHours = parseFloat(((workday.checkOutTime - workday.checkInTime)/3600000).toFixed(2));
            workday.balance = parseFloat((workday.workHours * user.hourPrice).toFixed(2));

            let savedWorkDay = await workday.save();
            res.status(200).json({status:"success", data:savedWorkDay});
        }
    }
};

const getWorkHistory = async (req, res) => {
    try{
        let user = await userModel.findOne({email:req.body.email});
        if(!user){
            res.status(404).json({status:"fail", message:"User not found"});
        }else{
            
            const monthToRetrieve = parseInt(req.query.month, 10) || 0;
            let workdays = []
            if(monthToRetrieve == 0){
                workdays = await workdayModel.find({userId:user._id});
                res.status(200).json({status:"success", data:workdays});
            }else{
                // get the workhistory by id and monthToRetrieve
                workdays = await workdayModel.aggregate([
                    {
                        $match: {
                            userId: user._id,
                            $expr: { $eq: [{ $month: '$checkInTime' }, monthToRetrieve] },
                        },
                    },
                ]);
                let monthBalance = 0;
                workdays.forEach(workday => {
                    monthBalance += workday.balance;
                });
                res.status(200).json({status:"success", balance:monthBalance,data:workdays});
            }
            if(workdays.length == 0){
                res.status(404).json({status:"fail", message:"No workdays found"});
            }
        }
    }catch(error){
        res.status(404).json({status:"fail", message:error.message});
    }
};

module.exports = {getAllWorkDays ,checkIn, checkOut, getWorkHistory};