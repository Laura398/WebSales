class Bidders {
  String? userId;
  double? price;

  Bidders({this.userId, this.price});

  Bidders.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['price'] = this.price;
    return data;
  }
}
