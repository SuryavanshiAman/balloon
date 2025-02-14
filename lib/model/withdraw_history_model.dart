class WithdrawHistoryModel {
  bool? success;
  List<Data>? data;

  WithdrawHistoryModel({this.success, this.data});

  WithdrawHistoryModel.fromJson(Map<String, dynamic> json) {
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
  dynamic amount;
  dynamic actualAmount;
  dynamic mobile;
  dynamic accountId;
  dynamic type;
  dynamic usdtWalletAddress;
  dynamic orderId;
  dynamic payout;
  dynamic remark;
  dynamic response;
  dynamic status;
  dynamic typeimage;
  dynamic referenceId;
  dynamic rejectmsg;
  dynamic createdAt;
  dynamic updatedAt;

  Data(
      {this.id,
        this.userId,
        this.amount,
        this.actualAmount,
        this.mobile,
        this.accountId,
        this.type,
        this.usdtWalletAddress,
        this.orderId,
        this.payout,
        this.remark,
        this.response,
        this.status,
        this.typeimage,
        this.referenceId,
        this.rejectmsg,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    actualAmount = json['actual_amount'];
    mobile = json['mobile'];
    accountId = json['account_id'];
    type = json['type'];
    usdtWalletAddress = json['usdt_wallet_address'];
    orderId = json['order_id'];
    payout = json['payout'];
    remark = json['remark'];
    response = json['response'];
    status = json['status'];
    typeimage = json['typeimage'];
    referenceId = json['referenceId'];
    rejectmsg = json['rejectmsg'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['actual_amount'] = this.actualAmount;
    data['mobile'] = this.mobile;
    data['account_id'] = this.accountId;
    data['type'] = this.type;
    data['usdt_wallet_address'] = this.usdtWalletAddress;
    data['order_id'] = this.orderId;
    data['payout'] = this.payout;
    data['remark'] = this.remark;
    data['response'] = this.response;
    data['status'] = this.status;
    data['typeimage'] = this.typeimage;
    data['referenceId'] = this.referenceId;
    data['rejectmsg'] = this.rejectmsg;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
