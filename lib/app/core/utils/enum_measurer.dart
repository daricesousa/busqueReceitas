enum Measurer {
  grama,
  quilo,
  mililitro,
  litro,
  unidade,
  colher,
  xicara,
  copo,
  caixa,
  lata,
  pacote;

  String get display {
    if (index == 0) return "g";
    if (index == 1) return "kg";
    if (index == 2) return "ml";
    if (index == 3) return "L";
    if (index == 4) return "unidade";
    if (index == 5) return "colher";
    if (index == 6) return "xícara";
    if (index == 7) return "copo";
    if (index == 8) return "caixa";
    if (index == 9) return "lata";
    return "pacote";
  }

  String get instrution {
    if (index == 0) return "grama";
    if (index == 1) return "quilograma";
    if (index == 2) return "mililitro";
    if (index == 3) return "litro";
    if (index == 4) return "unidade";
    if (index == 5) return "colher de sopa";
    if (index == 6) return "xícara de chá (240 ml)";
    if (index == 7) return "copo (200 ml)";
    if (index == 8) return "caixa";
    if (index == 9) return "lata";
    return "pacote";
  }

  String get displayPlural {
    if (index == 0) return "g";
    if (index == 1) return "kg";
    if (index == 2) return "ml";
    if (index == 3) return "L";
    if (index == 4) return "unidades";
    if (index == 5) return "colheres";
    if (index == 6) return "xícaras";
    if (index == 7) return "copos";
    if (index == 8) return "caixas";
    if (index == 9) return "latas";
    return "pacotes";
  }
}

