class UserModel {
  int id;
  String name;
  String email;
  String? rule;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.rule
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'rule': rule,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      rule: map['rule'],
    );
  }

}
