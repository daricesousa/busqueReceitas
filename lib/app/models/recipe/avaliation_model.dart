class AvaliationModel {

  int userRating;
  int quantity;
  double ratingAverage;
  AvaliationModel({ this.userRating=-1, this.quantity=0, this.ratingAverage=0.0});

  factory AvaliationModel.fromMap(Map<String, dynamic> json) {
    return AvaliationModel(
      
    );
  }


}
