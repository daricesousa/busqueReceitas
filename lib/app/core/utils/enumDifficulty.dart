class DifficultyConvert {
  DifficultyConvert
._();
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


@override
  static diffilcultyToString(Difficulty difficulty){
    if (difficulty == Difficulty.easy) {
      return "Fácil";
    }
    if (difficulty == Difficulty.hard) {
      return "Difícil";
    }
    return "Médio";
  }

}

enum Difficulty {easy, medium, hard, empty}