class EmailValidator {
  bool isEmailValid(String value) {
    return RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$')
        .hasMatch(value);
  }
}
