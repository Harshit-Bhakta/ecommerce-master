class ProfileModelWrapper {
  String? msg;
  ProfileModel? profileModel;

  ProfileModelWrapper({this.msg, this.profileModel});

  ProfileModelWrapper.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    profileModel = json['data'] != null ? ProfileModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (profileModel != null) {
      data['data'] = profileModel!.toJson();
    }
    return data;
  }
}

class ProfileModel {
  int? id;
  String? cusName;
  String? cusAdd;
  String? cusCity;
  String? cusState;
  String? cusPostcode;
  String? cusCountry;
  String? cusPhone;
  String? cusFax;
  String? shipName;
  String? shipAdd;
  String? shipCity;
  String? shipState;
  String? shipPostcode;
  String? shipCountry;
  String? shipPhone;
  int? userId;
  String? createdAt;
  String? updatedAt;
  dynamic user;

  ProfileModel(
      {this.id,
        this.cusName,
        this.cusAdd,
        this.cusCity,
        this.cusState,
        this.cusPostcode,
        this.cusCountry,
        this.cusPhone,
        this.cusFax,
        this.shipName,
        this.shipAdd,
        this.shipCity,
        this.shipState,
        this.shipPostcode,
        this.shipCountry,
        this.shipPhone,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.user});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cusName = json['cus_name'];
    cusAdd = json['cus_add'];
    cusCity = json['cus_city'];
    cusState = json['cus_state'];
    cusPostcode = json['cus_postcode'];
    cusCountry = json['cus_country'];
    cusPhone = json['cus_phone'];
    cusFax = json['cus_fax'];
    shipName = json['ship_name'];
    shipAdd = json['ship_add'];
    shipCity = json['ship_city'];
    shipState = json['ship_state'];
    shipPostcode = json['ship_postcode'];
    shipCountry = json['ship_country'];
    shipPhone = json['ship_phone'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user= json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cus_name'] = cusName;
    data['cus_add'] = cusAdd;
    data['cus_city'] = cusCity;
    data['cus_state'] = cusState;
    data['cus_postcode'] = cusPostcode;
    data['cus_country'] = 'Bangladesh';
    data['cus_phone'] = cusPhone;
    data['cus_fax'] = cusPhone;
    data['ship_name'] = cusName;
    data['ship_add'] = cusAdd;
    data['ship_city'] = cusCity;
    data['ship_state'] = cusState;
    data['ship_postcode'] = cusPostcode;
    data['ship_country'] = 'Bangladesh';
    data['ship_phone'] = cusPhone;
    return data;
  }
}
