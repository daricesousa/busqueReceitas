enum Difficulty {easy, medium, hard; 
  String get name{
    if (index == 0) return "Fácil";
    if (index == 1) return "Médio";
    return "Difícil";
  }
}
