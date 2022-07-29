class IngredientModel {
  int id;
  String name;
  int groupId;
  List<int> associates;

  IngredientModel({
    required this.id,
    required this.name,
    required this.groupId,
    required this.associates,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'group': groupId,
      'associates': associates,
    };
  }

  factory IngredientModel.fromMap(Map<String, dynamic> json) {
    return IngredientModel(
        id: json['id'],
        name: json['name'],
        groupId: json['group'],
        associates: json['associates'].cast<int>(),
    );
  }
}
