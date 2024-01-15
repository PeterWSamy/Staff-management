const userModel = require("../../../DB/models/user.model");
const jwt = require("jsonwebtoken");
const { confirmEmailMessage, sendCredentialsMessage } = require("../../../services/emailMessages");
const { sendEmail } = require("../../../services/emailService");
const bcrypt=require('bcryptjs');
const otpGenerator = require('otp-generator')
 
const getAllUsers = async (req, res) => {
  try {
    const users = await userModel.find();
    if (users.length == 0) {
      res.status(404).json({ status: "fail", message: "No users found" });
    } else {
      res.status(200).json({ status: "success", data: users });
    }
  } catch (error) {
    return res.status(404).json({ status: "fail", message: error.message });
  }
};

const addUser = async (req, res) => {
  try {
    let { email, name, title, role, hourPrice } =
      req.body;

    let user = await userModel.findOne({ email });
    if (user) {
      res.status(404).json({ status: "fail", message: "User already exists" });
    } else {
      let password = otpGenerator.generate(6, { upperCaseAlphabets: false, specialChars: false });
      let addUser = new userModel({
        email,
        password,
        name,
        title,
        role,
        hourPrice,
      });
      let savedUser = await addUser.save();
      let message = sendCredentialsMessage(savedUser.name, savedUser.email, password);
      sendEmail(savedUser.email, message, "Welcome On Board!");
      res.status(200).json({ status: "success", data: savedUser });
    
    }
  } catch (error) {
    res.status(404).json({ status: "fail", message: error.message });
  }
};

const getUserById = async (req, res) => {
  try {
    let user = await userModel.findById(req.params.id);
    if (!user) {
      res.status(404).json({ status: "fail", message: "User not found" });
    } else {
      res.status(200).json({ status: "success", data: user });
    }
  } catch (error) {
    res.status(404).json({ status: "fail", message: error.message });
  }
};

const updateUser = async (req, res) => {
  try {
    let id = req.params.id;
    let updatedUser = await userModel.findByIdAndUpdate(id, req.body, {
      new: true,
    });
    res.status(200).json({ status: "success", data: updatedUser });
  } catch (error) {
    res.status(404).json({ status: "fail", message: error.message });
  }
};

const deleteUser = async (req, res) => {
  try {
    let user = await userModel.findByIdAndDelete(req.params.id);
    if (!user) {
      res.status(404).json({ status: "fail", message: "User not found" });
    } else {
      res
        .status(200)
        .json({ status: "success", message: "User deleted successfully" });
    }
  } catch (error) {
    res.status(404).json({ status: "fail", message: error.message });
  }
};

const getUser = async (req, res) => {
  try {
    // for user to require its info. by token mainly nut know by sending id
    let { id } = req.body;
    let user = await userModel.findById(id);

    if (!user) {
      res
        .status(404)
        .json({ status: "fail", message: "User not found, Invalid ID" });
    } else {
      res.status(200).json({ status: "success", data: user });
    }
  } catch (error) {
    res.status(404).json({ status: "fail", message: error.message });
  }
};

const signin = async (req, res) => {
  try {
    let { email, password } = req.body;
    let user = await userModel.findOne({ email });
    let pass = password+user._id;
    console.log(pass);
    if (!user || !(await user.correctPassword(pass,user.password))) {
      res.status(404).json({ status: "fail", message: "Incorrect email or password" });
    } else {
      let token = jwt.sign({ id: user._id, isLoggedIn: true }, process.env.JWTKEY);
      res.status(200).json({ status: "success", data: token });
    }  
  } catch (error) {
    res.status(404).json({ status: "fail", message: error.message });
  }
};

const signup = async (req, res) => {
  try {
    let { name, email, password, confirmPassword, title } = req.body;
    if (password !== confirmPassword) {
      res
        .status(404)
        .json({ status: "fail", message: "Passwords don't match" });
    }

    let user = await userModel.findOne({ email });
    if (user) {
      res.status(404).json({ status: "fail", message: "User already exists" });
    }else{
      let addUser = new userModel({
        email,
        password,
        name,
        title,
      });
  
      let savedUser = await addUser.save();
      let token = jwt.sign({ email: savedUser.email }, process.env.JWTKEY);
      let message = confirmEmailMessage(req, savedUser.name, token);
      await sendEmail(savedUser.email, message, "Email Confirmation");
      res.status(200).json({ status: "success", data: savedUser });

    }
  } catch (error) {
    res.status(404).json({ status: "fail", message: error.message });
  }
};

const confirmEmail = async (req, res) => {
  try {
    let token = req.params.token;
    let { email } = jwt.verify(token, process.env.JWTKEY);
    let user = await userModel.findOne({ email });
    if (!user) {
      res.status(404).json({ status: "fail", message: "User not found" });
    }else{
      user.confirmed = true;
      await user.save();
      res.status(200).json({ status: "success", data: user });
    }
  } catch (error) {
    res.status(404).json({ status: "fail", message: error.message });
  }
};

const updatePassword = async (req, res) => {
  try{
    let{email,oldPassword,newPassword}=req.body;
    let user = await userModel.findOne({ email });
    let pass = oldPassword+user._id;
    if(oldPassword == newPassword){
      res.status(404).json({ status: "fail", message: "New password must be different from old password"});
    }
    if(!user || !(await user.correctPassword(pass,user.password))){
      res.status(404).json({ status: "fail", message: "Invalid email or password"});
    }else{
      user.password=newPassword;
      await user.save();
      res.status(200).json({ status: "success", data: user });
    }
  }catch(error){
    res.status(404).json({ status: "fail", message: error.message });
  }
};

module.exports = {
  getAllUsers,
  addUser,
  getUserById,
  updateUser,
  deleteUser,
  getUser,
  signin,
  signup,
  confirmEmail,
  updatePassword,
};
