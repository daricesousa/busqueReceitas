class DiffidcultyConvert {
  DiffidcultyConvert._();
  static Difficulty fromInt(int i) {
    if (i == 1) {
      return Difficulty.easy;
    }
    if (i == 3) {
      return Difficulty.hard;
    }
    return Difficulty.medium;
  }

  static int toInt(Difficulty difficulty) {
    if (difficulty == Difficulty.easy) {
      return 1;
    }
    if (difficulty == Difficulty.hard) {
      return 3;
    }
    return 2;
  }


  

}

enum Difficulty {easy, medium, hard; 
  String get name{
    if (index == 0) return "Fácil";
    if (index == 1) return "Médio";
    return "Dificíl";
  }
}