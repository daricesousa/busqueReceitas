enum RecipeType {
  drink,
  snack,
  lunch_dinner,
  dessert;

  String get name {
    if (index == 0) return "bebida";
    if (index == 1) return "lanche";
    if(index == 2) return "almoço ou jantar";
    else return "sobremesa";
  }
}
