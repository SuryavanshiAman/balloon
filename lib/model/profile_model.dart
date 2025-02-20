class ProfileModel {
  bool? status;
  String? message;
  String? gameType;
  String? gameUrl;
  Data? data;


  ProfileModel({this.status, this.message,this.gameType, this.data, });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    gameType = json['game_type'];
    gameUrl = json['game_url'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['game_type'] = this.gameType;
    data['game_url'] = this.gameUrl;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;

  }
}

class Data {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic mobile;
  dynamic password;
  dynamic referralcode;
  dynamic referrerId;
  dynamic image;
  dynamic wallet;
  dynamic deposit;
  dynamic winning;
  dynamic bonus;
  dynamic status;
  dynamic datetime;

  Data(
      {this.id,
        this.name,
        this.email,
        this.mobile,
        this.password,
        this.referralcode,
        this.referrerId,
        this.image,
        this.wallet,
        this.deposit,
        this.winning,
        this.bonus,
        this.status,
        this.datetime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    referralcode = json['referralcode'];
    referrerId = json['referrer_id'];
    image = json['image'];
    wallet = json['wallet'];
    deposit = json['deposit'];
    winning = json['winning'];
    bonus = json['bonus'];
    status = json['status'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['referralcode'] = this.referralcode;
    data['referrer_id'] = this.referrerId;
    data['image'] = this.image;
    data['wallet'] = this.wallet;
    data['deposit'] = this.deposit;
    data['winning'] = this.winning;
    data['bonus'] = this.bonus;
    data['status'] = this.status;
    data['datetime'] = this.datetime;
    return data;
  }
}
