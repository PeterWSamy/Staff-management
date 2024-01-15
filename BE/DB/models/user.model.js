const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, "Name is required"],
        minlength: [3, "Name must be at least 3 characters long"]
    },
    email: {
        type: String,
        required: [true, "Email is required"],
        unique: true,
    },
    password: {
        type: String,
        required: [true, "Password is required"],
        minlength: [6, "Password must be at least 6 characters long"]
    },
    role: {
        type: String,
        enum: ["user", "admin"],
        default: "user"
    },
    title: {
        type: String,
        required: [true, "Title is required"],
    },
    hourPrice: {
        type: Number,
        required: [true, "HourPrice is required"]
    },
}, { timestamps: true });

userSchema.pre('save', function (next) {
    this.password = this.password+this.id;
    console.log(this.password);
    this.password = bcrypt.hashSync(this.password, parseInt(process.env.SECRET_ROUNDS));
    console.log(this.password);
    next();
});

userSchema.post('save', function (doc, next) {
    console.log(doc);
    next();
});

userSchema.methods.correctPassword = function (password,storedPassword) {
    return bcrypt.compareSync(password, storedPassword);
};

const userModel = mongoose.model('user', userSchema);
module.exports = userModel;