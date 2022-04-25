import 'package:websales/models/bidders.model.dart';

class Product {
  String? sId;
  String? sellerId;
  String? seller_first_name;
  String? seller_last_name;
  String? title;
  String? picture;
  String? description;
  int? basePrice;
  String? beginningOfTheAuction;
  String? endOfTheAuction;
  List<Bidders>? bidders;

  Product(
      {this.sId,
      this.sellerId,
      this.title,
      this.picture,
      this.seller_first_name,
      this.seller_last_name,
      this.basePrice,
      this.beginningOfTheAuction,
      this.description,
      this.endOfTheAuction,
      this.bidders});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sellerId = json['seller_id'];
    title = json['title'];
    picture = json['picture'];
    seller_first_name = json['seller_first_name'];
    seller_last_name = json['seller_last_name'];
    basePrice = json['base_price'];
    beginningOfTheAuction = json['beginning_of_the_auction'];
    description = json['description'];
    endOfTheAuction = json['end_of_the_auction'];
    if (json['bidders'] != null) {
      bidders = <Bidders>[];
      json['bidders'].forEach((v) {
        bidders!.add(new Bidders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['seller_id'] = this.sellerId;
    data['title'] = this.title;
    data['picture'] = this.picture;
    data['seller_first_name'] = this.seller_first_name;
    data['seller_last_name'] = this.seller_last_name;
    data['base_price'] = this.basePrice;
    data['beginning_of_the_auction'] = this.beginningOfTheAuction;
    data['description'] = this.description;
    data['end_of_the_auction'] = this.endOfTheAuction;
    if (this.bidders != null) {
      data['bidders'] = this.bidders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
