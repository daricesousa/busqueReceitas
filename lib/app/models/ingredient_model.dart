class IngredientModel {
  int id;
  String name;
  int groupId;
  List<int> associateId;

  IngredientModel({
    required this.id,
    required this.name,
    required this.groupId,
    required this.associateId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'group_id': groupId,
      'associate_id': associateId,
    };
  }

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
        id: map['id'],
        name: map['name'],
        groupId: map['group_id'],
        associateId: map['associate_id']);
  }
}
