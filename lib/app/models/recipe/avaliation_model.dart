class AvaliationModel {
  int userId;
  int rating;
  AvaliationModel({required this.userId, required this.rating});

  factory AvaliationModel.fromMap(Map<String, dynamic> json) {
    return AvaliationModel(
      userId: json['user'],
      rating: json['rating'],
    );
  }

  int identify(){
    return userId;
  }
}
