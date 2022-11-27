import 'package:busque_receitas/app/core/utils/enum_difficulty.dart';
import 'package:busque_receitas/app/models/recipe/avaliation_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_ingredient_model.dart';

class RecipeModel {
  int id;
  String title;
  List<RecipeIngredientModel> listIngredients;
  String picture;
  Difficulty difficulty;
  String creator;
  List<String> method;
  AvaliationModel avaliation;
  bool pictureIlustration;
  String timeSetup;
  String timeCooking;


  RecipeModel({
    required this.id,
    required this.title,
    required this.listIngredients,
    required this.picture,
    required this.difficulty,
    required this.creator,
    required this.method,
    required this.avaliation,
    required this.timeSetup,
    required this.timeCooking,
    this.pictureIlustration = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'difficulty': difficulty.index,
      'name_creator': creator,
      'method': method,
      'ingredients': {"list": listIngredients.map((e) => e.toMap()).toList(),},
      'avaliation': avaliation.toMap(),
      'picture': picture,
      'picture_ilustration': pictureIlustration,
      'time_setup': timeSetup,
      'time_cooking': timeCooking,
    };
  }

  factory RecipeModel.fromMap(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'],
      picture: json['picture'],
      pictureIlustration: json['picture_ilustration'] ?? false,
      difficulty: Difficulty.values[(json['difficulty'] ?? 0)],
      creator: json['name_creator'] ?? '',
      timeSetup: json['time_setup'] ?? '',
      timeCooking: json['time_cooking'] ?? '',
      method: json['method'].map<String>((e) => e.toString()).toList(),
      listIngredients: json['ingredients']['list']
          .map<RecipeIngredientModel>((e) => RecipeIngredientModel.fromMap(e))
          .toList(),
      avaliation: AvaliationModel(
        quantity: json['avaliation']['quantity'] ?? 0,
        ratingAverage:
            (json['avaliation']['rating_average'])?.toDouble() ?? 0.0,
        userRating: json['avaliation']['user_rating'] ?? 0,
      ),
    );
  }
}
