class PasswordValidator {
  final int _minCharacters = 8, _maxCharacters = 32;

  get minCharacters => _minCharacters;
  get maxCharacters => _maxCharacters;

  bool isPasswordValid(String value) {
    return value.length > minCharacters && value.length < maxCharacters;
  }
}
