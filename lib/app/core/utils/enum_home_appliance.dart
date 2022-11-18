enum HomeAppliance{
  // stove,
  // oven,
  // fridge,
  // air_fryer,
  // blender,
  // mixer,
  // microwave;
  fogao,
  forno,
  geladeira,
  air_fryer,
  liquidificador,
  batedeira,
  microondas;
  String get name{
    if(index == 0) return "fogão";
    if(index == 1) return "forno";
    if(index == 2) return "geladeira";
    if(index == 3) return "air fryer";
    if(index == 4) return "liquidificador";
    if(index == 5) return "batedeira";
    else return "microondas";
  }
}