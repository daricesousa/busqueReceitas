enum TimeSetup{
  ate3,
  ate10,
  ate20,
  ate40,
  ate60;

  String get name{
    if(index == 0) return 'Até 3 min';
    if(index == 1) return 'Até 10 min';
    if(index == 2) return 'Até 20 min';
    if(index == 3) return 'Até 40 min';
    else return 'Até 60 min';
  }

  int get value{
    if(index == 0) return 3;
    if(index == 1) return 10;
    if(index == 2) return 20;
    if(index == 3) return 40;
    else return 60;
  }

   String get homeName{
    if(index == 0) return 'Preparo: até 3 min';
    if(index == 1) return 'Preparo: até 10 min';
    if(index == 2) return 'Preparo: até 20 min';
    if(index == 3) return 'Preparo: até 40 min';
    else return 'Preparo: até 60 min';
  }
}