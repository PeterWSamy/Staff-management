class ApiRoutes{
  static const String BASE_URL = "https://staff-app-bice.vercel.app/api/v0.0";
  static const String postLogin = "${BASE_URL}/user/signin";
  static const String postAddUser = "${BASE_URL}/user/addUser";
  static const String getGetUser = "${BASE_URL}/user/getUser";
  static const String getAllUsers = "${BASE_URL}/user/allUsers";
  static const String deleteUser = "${BASE_URL}/user/delete";


  static const String getGetHistory = "${BASE_URL}/workday/workHistory";
  static const String postCheckIn = "${BASE_URL}/workday/checkIn";
  static const String postCheckOut = "${BASE_URL}/workday/checkOut";
  
}