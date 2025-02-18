import 'package:ecommerce/data/models/promotional_slider_data_model.dart';

class PromotionalSliderListModel {
  String? msg;
  List<PromotionalSliderData>? promotionalSliderList;

  PromotionalSliderListModel({this.msg, this.promotionalSliderList});

  PromotionalSliderListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      promotionalSliderList = <PromotionalSliderData>[];
      json['data'].forEach((v) {
        promotionalSliderList!.add(PromotionalSliderData.fromJson(v));
      });
    }
  }
}