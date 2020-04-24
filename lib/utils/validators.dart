/// Checks string not empty
String notEmpty(String value, {String message = 'Please input some text'}) {
  return value.isEmpty ? message : null;
}
