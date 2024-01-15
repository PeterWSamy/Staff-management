class HistoryModel {
  String checkInTime;
  String checkOutTime;
  double workHours;
  String userId;

  HistoryModel({
    required this.checkInTime,
    required this.checkOutTime,
    required this.workHours,
    required this.userId,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      checkInTime: json['checkInTime'],
      checkOutTime: json['checkOutTime'] ?? "",
      workHours: (json['workHours'] ?? 0).toDouble(),
      userId: json['userId'] ,
    );
  }

  Map<String, dynamic> toJson() => {
        "checkInTime": checkInTime,
        "checkOutTime": checkOutTime,
        "workHours": workHours,
        "userId": userId,
      };
}
/*
checkInTime: {
      type: Date,
      required: [true, "CheckInTime is required"],
    },
    checkOutTime: {
      type: Date,
    },
    workHours: {
      type: Number,
    },
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "user",
      required: [true, "UserId is required"],
    },
    balance: {
      type: Number,
    }
*/