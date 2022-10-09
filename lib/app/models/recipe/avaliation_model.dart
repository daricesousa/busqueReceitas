class AvaliationModel {

  int userRating;
  int quantity;
  double ratingAverage;
  AvaliationModel({ this.userRating=-1, this.quantity=0, this.ratingAverage=0.0});

  Map<String, dynamic> toMap(){
    return{
      'userRating': userRating,
      'quantity': quantity,
      'ratingAverage': ratingAverage,
    };
  }
}
