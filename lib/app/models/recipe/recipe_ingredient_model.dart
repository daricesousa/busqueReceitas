import 'package:busque_receitas/app/core/utils/enum_measurer.dart';

class RecipeIngredientModel {
  int ingredientId;
  double quantity;
  String measurer;

  RecipeIngredientModel(
      {required this.ingredientId,
      required this.quantity,
      required this.measurer});

  Map<String, dynamic> toMap() {
    return {
      'id': ingredientId,
      'quantity': quantity,
      'measurer': measurer,
    };
  }

  factory RecipeIngredientModel.fromMap(Map<String, dynamic> json) {
    return RecipeIngredientModel(
      ingredientId: json['id'],
      quantity: json['quantity'].toDouble(),
      measurer: _personalizeMeasurer(json['measurer'], json['quantity'].toDouble(),),
    );
  }

  @override
  String toString() {
    return ingredientId.toString();
  }

  static String _personalizeMeasurer(String measurerRecipe, double quantity){
    Measurer? measurer;
    final listMeasurer = Measurer.values.map((e) => e).toList();
    for (Measurer m in listMeasurer) {
      if (measurerRecipe == m.display) {
        measurer = m;
      }
    }
    if(measurer!= null && quantity >  1 ){
      return measurer.displayPlural;
    }
    return measurerRecipe;
  }

}

