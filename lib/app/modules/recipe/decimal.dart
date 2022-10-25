import 'dart:math';

class Decimal {
  Decimal._();

  static forFraction(int decimal) {
    final digitos = _digitos(decimal);
    int div = pow(10, digitos).toInt();
    final mdc = _mdc(div, decimal);
    final numerador = inteiro(decimal / mdc);
    final denominador = inteiro(div/mdc);
    if(numerador >= 33 && numerador % 3 == 0){
      if(denominador == 50){
        return "2/3";
      }
      if(denominador == 100){
        return "1/3";
      }
    }
    return ("$numerador/$denominador");
  }

  static int _mdc(int a, int b) {
    while (b != 0) {
      int resto = a % b;
      a = b;
      b = resto;
    }
    return a;
  }

static int _digitos(int n){
   int digitos = 1;
    while(n >=10){
     n = int.parse((n/10).toString().split('.')[1]);
     digitos +=1;
    }
  return digitos;
}

static int inteiro(double n){
  final inteiro = n.toString().split('.')[0];
  return int.parse(inteiro);
}

static int decimal(double n){
  int decimal = 0;
  final list = n.toString().split('.');
  if(list.length == 2){
    decimal = int.parse(list[1]);
  }
  return decimal;
}

}
