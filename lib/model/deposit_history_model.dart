class DepositHistoryModel {
  bool? success;
  List<Data>? data;

  DepositHistoryModel({this.success, this.data});

  DepositHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic userId;
  dynamic cash;
  dynamic usdtAmount;
  dynamic extraCash;
  dynamic ziliUtrNum;
  dynamic bonus;
  dynamic screenshot;
  dynamic orderId;
  dynamic redirectUrl;
  dynamic type;
  dynamic status;
  dynamic typeimages;
  dynamic transactionId;
  dynamic createdAt;
  dynamic updatedAt;

  Data(
      {this.id,
        this.userId,
        this.cash,
        this.usdtAmount,
        this.extraCash,
        this.ziliUtrNum,
        this.bonus,
        this.screenshot,
        this.orderId,
        this.redirectUrl,
        this.type,
        this.status,
        this.typeimages,
        this.transactionId,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cash = json['cash'];
    usdtAmount = json['usdt_amount'];
    extraCash = json['extra_cash'];
    ziliUtrNum = json['zili_utr_num'];
    bonus = json['bonus'];
    screenshot = json['screenshot'];
    orderId = json['order_id'];
    redirectUrl = json['redirect_url'];
    type = json['type'];
    status = json['status'];
    typeimages = json['typeimages'];
    transactionId = json['transaction_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['cash'] = this.cash;
    data['usdt_amount'] = this.usdtAmount;
    data['extra_cash'] = this.extraCash;
    data['zili_utr_num'] = this.ziliUtrNum;
    data['bonus'] = this.bonus;
    data['screenshot'] = this.screenshot;
    data['order_id'] = this.orderId;
    data['redirect_url'] = this.redirectUrl;
    data['type'] = this.type;
    data['status'] = this.status;
    data['typeimages'] = this.typeimages;
    data['transaction_id'] = this.transactionId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
