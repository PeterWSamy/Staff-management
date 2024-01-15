class LoginViewModel{
  bool validateInputs(String email, String password){
    if(email.isEmpty || password.isEmpty){
      return false;
    }
    return true;
  }
}