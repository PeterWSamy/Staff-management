class AddUserViewModel{
  String checkFormValidation(String name, String email, String role,String title,String hourRate){
    if(name.isEmpty || email.isEmpty || role.isEmpty || title.isEmpty || hourRate.isEmpty){
      return "Please fill all fields";
    }
    if(!isEmailValid(email)){
      return "Please enter a valid email";
    }
    if(hourRate.contains(RegExp(r'[A-Z]')) || hourRate.contains(RegExp(r'[a-z]'))){
      return "Please enter a valid hour rate";
    }
    return "";
  }
  
  bool isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}