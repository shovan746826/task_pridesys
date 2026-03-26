

String? isValidPassword(String? password) {
  // return password != null && RegExp(r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$").hasMatch(password)
  return password != null && password.trim().length == 6
      ? null
      : 'Please enter a valid password';
}


String? isValidEmail(String? email) {
  return (email != null && RegExp(r"^(?=[a-zA-Z0-9@._%+-]{6,256}$)(?=[a-zA-Z0-9._%+-]{1,64}@)[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$").hasMatch(email))
      ? null
      : 'Please enter a valid email address';
}

String? isValidEmailOrUserName(String? email) {
  return (email != null && email.trim().length > 1)
      ? null
      : 'Please enter a valid email/user name';
}

String? isValidName(String? email) {
  return (email != null && email.trim().length > 1)
      ? null
      : 'Please enter a valid name';
}

String? isValidPhoneNumber(String? number) {
  return number != null && number.length > 8
      ? null
      : "Please enter a valid phone number";
}


String? isValidOTP(String? otp) {
  return otp != null && RegExp(r"\d{6}$").hasMatch(otp)
      ? null
      : "Please enter a valid phone number";
}

String? isValidFullName(String? name) {
  const pattern = r"^[a-zA-Z]+( [a-zA-Z]+)+$";
  final regExp = RegExp(pattern);

  return name != null &&  regExp.hasMatch(name)
      ? null
      : "Please enter a valid full name (first and last name)";
}

String? isValidUserName(String? name) {
  if (name == null || name.length < 6) {
    return "Please enter a minimum of 6 characters for the username";
  }
  if (name.contains(" ")) {
    return "Username should not contain spaces";
  }
  return null;
}

String? isValidCountryName(String? name) {
  return name != null && name.length > 1
      ? null
      : "Please select country";
}

