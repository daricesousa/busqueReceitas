import 'package:busque_receitas/app/models/ingredient_model.dart';

class GroupIngredientsModel {
  int id;
  String name;
  List<IngredientModel> listIngredients;

  GroupIngredientsModel({
    required this.id,
    required this.name,
    List<IngredientModel>? listIngredients,
  }) :listIngredients = listIngredients ?? [];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'listIngredients': listIngredients.map((e) => e.toMap()).toList(),
    };
  }

  factory GroupIngredientsModel.fromMap(Map<String, dynamic> map) {
    return GroupIngredientsModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      listIngredients: map['listIngredients'].map<IngredientModel>(
            (e) => IngredientModel.fromMap(e),
          ).toList(),
    );
  }
}
