class RegExpConstans {
  static RegExpConstans? _instance;
  static RegExpConstans? get instance {
    _instance ??= RegExpConstans._init();
    return _instance;
  }

  RegExpConstans._init();

  final alpha = RegExp(r'^[A-Za-z]+$');

  final numeric = RegExp(r'^-?[0-9]+$');


}
