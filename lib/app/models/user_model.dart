class UserModel {
  int id;
  String name;
  String email;
  String senha;
  DateTime validSign;
  DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.senha,
    required this.validSign,
    required this.createdAt,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'senha': senha,
      'valid_sign': validSign,
      'created_at': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      senha: map['senha'] ?? '',
      validSign: map['valid_sign'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }

}
