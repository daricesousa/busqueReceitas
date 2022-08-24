import 'package:busque_receitas/app/models/recipe/avaliation_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_ingredient_model.dart';

class RecipeModel {
  int id;
  String title;
  List<RecipeIngredientModel> listIngredients;
  String picture;
  String difficulty;
  int creatorId;
  List<String> method;
  List<AvaliationModel> avaliations;

  RecipeModel(
      {required this.id,
      required this.title,
      required this.listIngredients,
      required this.picture,
      required this.difficulty,
      required this.creatorId,
      required this.avaliations,
      required this.method,
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'picture': picture,
      'difficulty': difficulty,
      'creator': creatorId,
      'method': method,
      'ingredients': {"list": listIngredients.map((e) => e.toMap()).toList()},
      //avaliation
    };
  }

  factory RecipeModel.fromMap(Map<String, dynamic> json) {
    return RecipeModel(
        id: json['id'],
        title: json['title'],
        picture: json['picture'],
        difficulty: json['difficulty'],
        creatorId: json['creator'],
        method: json['method'].map<String>((e) => e.toString()).toList(), 
        listIngredients: json['ingredients']['list']
            .map<RecipeIngredientModel>((e) => RecipeIngredientModel.fromMap(e))
            .toList(),
       avaliations: [],
        );
  }



}
