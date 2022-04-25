import 'package:websales/models/bidders.model.dart';

class Product {
  String? sId;
  String? sellerId;
  String? title;
  int? iV;
  int? basePrice;
  String? beginningOfTheAuction;
  String? description;
  String? endOfTheAuction;
  List<Bidders>? bidders;

  Product(
      {this.sId,
      this.sellerId,
      this.title,
      this.iV,
      this.basePrice,
      this.beginningOfTheAuction,
      this.description,
      this.endOfTheAuction,
      this.bidders});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sellerId = json['seller_id'];
    title = json['title'];
    iV = json['__v'];
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
    data['__v'] = this.iV;
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
