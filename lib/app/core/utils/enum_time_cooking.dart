enum TimeCooking{
  ate0,
  ate3,
  ate10,
  ate20,
  ate40,
  ate60;

  String get name{
    if(index == 0) return 'Sem cozimento';
    if(index == 1) return 'Até 3 min';
    if(index == 2) return 'Até 10 min';
    if(index == 3) return 'Até 20 min';
    if(index == 4) return 'Até 40 min';
    else return 'Até 60 min';
  }

  int get value{
    if(index == 0) return 0;
    if(index == 1) return 3;
    if(index == 2) return 10;
    if(index == 3) return 20;
    if(index == 4) return 40;
    else return 60;
  }

  String get homeName{
    if(index == 0) return 'Sem cozimento';
    if(index == 1) return 'Cozimento: até 3 min';
    if(index == 2) return 'Cozimento: até 10 min';
    if(index == 3) return 'Cozimento: até 20 min';
    if(index == 4) return 'Cozimento: até 40 min';
    else return 'Cozimento: até 60 min';
  }
}