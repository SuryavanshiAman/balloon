class BankViewModel {
  String? status;
  String? message;
  Data? data;

  BankViewModel({this.status, this.message, this.data});

  BankViewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic userid;
  dynamic name;
  dynamic accountNum;
  dynamic bankName;
  dynamic ifscCode;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  Data(
      {this.id,
        this.userid,
        this.name,
        this.accountNum,
        this.bankName,
        this.ifscCode,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    name = json['name'];
    accountNum = json['account_num'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['name'] = this.name;
    data['account_num'] = this.accountNum;
    data['bank_name'] = this.bankName;
    data['ifsc_code'] = this.ifscCode;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
