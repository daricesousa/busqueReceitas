class IngredientModel {
  int id;
  String name;
  int groupId;
  List<int> associates;

  IngredientModel({
    required this.id,
    required this.name,
    required this.groupId,
    List<int>? associates,
  }):associates = associates ?? [];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'group': groupId,
      'associates': associates,
    };
  }

  factory IngredientModel.fromMap(json) {
    return IngredientModel(
      id: json['id'],
      name: json['name'],
      groupId: json['group'],
      associates: json['associates'].cast<int>(),
    );
  }
  
 @override
  String toString() {
    return name;
  }


}
