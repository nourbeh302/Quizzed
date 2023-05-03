class PasswordValidator {
  bool isPasswordValid(String value, int min, int max) {
    return value.length > min && value.length < max;
  }
}
