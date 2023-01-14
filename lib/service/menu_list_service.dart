import 'dart:convert';

// import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:machine_code/model/menu_list_model.dart';

class MenuListService {
  Future<MenuListModel> fetchMenuListData() async {
    var response = await rootBundle.loadString('assets/menu.json');

    Map<String, dynamic> catalogdata = json.decode(response);

    MenuListModel data = MenuListModel.fromJson(catalogdata);

    return data;
  }
}
