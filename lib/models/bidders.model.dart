class Bidders {
  String? bidderId;
  String? bidderFirstName;
  String? bidderLastName;
  int? bidderAmount;

  Bidders(
      {this.bidderId,
      this.bidderFirstName,
      this.bidderLastName,
      this.bidderAmount});

  Bidders.fromJson(Map<String, dynamic> json) {
    bidderId = json['bidder_id'];
    bidderFirstName = json['bidder_first_name'];
    bidderLastName = json['bidder_last_name'];
    bidderAmount = json['bidder_bid_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.bidderId;
    data['bidder_first_name'] = this.bidderFirstName;
    data['bidder_last_name'] = this.bidderLastName;
    data['bidder_bid_amount'] = this.bidderAmount;
    return data;
  }
}
