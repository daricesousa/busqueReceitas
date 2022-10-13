class Decimal {
  Decimal._();
  static forFraction(double number) {
    double decimal = getDecimal(number);
    int denominador = 1;
    while ((decimal * 10) % 10 != 0) {
      denominador *= 10;
      decimal *= 10;
    }
    int numerador = int.parse(decimal.toStringAsFixed(0));
    final mdc = _mdc(denominador, numerador);
    return " ${(numerador / mdc).toStringAsFixed(0)}/${(denominador / mdc).toStringAsFixed(0)}";
  }

  static int _mdc(int a, int b) {
    while (b != 0) {
      int resto = a % b;
      a = b;
      b = resto;
    }
    return a;
  }

  static double getDecimal(double n) {
    double decimal = 0;
    if ((n * 10) % 10 != 0) {
      decimal = n - double.parse(n.toStringAsFixed(0));
    }
    return decimal;
  }
}
