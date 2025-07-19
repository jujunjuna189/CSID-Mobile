class ParserZero {
  ParserZero._privateConstructor();
  static final instance = ParserZero._privateConstructor();

  String set(int value) {
    return value < 10 ? "0$value" : value.toString();
  }
}
