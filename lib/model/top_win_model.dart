class TopWinModel {
  bool? status;
  List<Data>? data;

  TopWinModel({this.status, this.data});

  TopWinModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic userId;
  dynamic betAmount;
  dynamic status;
  dynamic winningAmount;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic name;
  dynamic totalWinning;

  Data(
      {this.id,
        this.userId,
        this.betAmount,
        this.status,
        this.winningAmount,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.totalWinning});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    betAmount = json['bet_amount'];
    status = json['status'];
    winningAmount = json['winning_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    totalWinning = json['total_winning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['bet_amount'] = this.betAmount;
    data['status'] = this.status;
    data['winning_amount'] = this.winningAmount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['total_winning'] = this.totalWinning;
    return data;
  }
}
