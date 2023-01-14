import 'package:flutter/material.dart';

import 'package:machine_code/model/menu_list_model.dart';
import 'package:machine_code/service/menu_list_service.dart';

class OrderProvider extends ChangeNotifier {
//**
// ***************************** PROPERTIES ********************************
//*/

  MenuListModel? menuListModel;
  MenuListService listService = MenuListService();
  int totalPrice = 0;
  List<CartItem> orderList = [];

//**
// ***************************** METHODS ********************************
//*/
  Future<MenuListModel> fetchList() async {
    menuListModel = await listService.fetchMenuListData();
    return listService.fetchMenuListData();
  }

  int getQuantity(CartItem cartItem, int listIndex) {
    int index = -1;
    for (int i = 0; i < menuListModel!.catData![listIndex].length; i++) {
      if (menuListModel!.catData![listIndex][i].name == cartItem.name) {
        index = i;
      }
    }
    return menuListModel!.catData![listIndex][index].quantity ?? 0;
  }

  void increment(CartItem cartItem, int listIndex) {
    int index = -1;
    late CartItem updatedCartItem;
    for (int i = 0; i < menuListModel!.catData![listIndex].length; i++) {
      if (menuListModel!.catData![listIndex][i].name == cartItem.name) {
        index = i;

        updatedCartItem = CartItem(
            price: cartItem.price,
            quantity: menuListModel!.catData![listIndex][i].quantity! + 1,
            name: cartItem.name);
      }
    }
    menuListModel!.catData![listIndex].removeAt(index);
    menuListModel!.catData![listIndex].insert(index, updatedCartItem);

    calculateTotalPrice();
    // update order list
    updateOrderList(updatedCartItem);
    notifyListeners();
  }

  void decrement(CartItem cartItem, int listIndex) {
    int index = -1;
    late CartItem updatedCartItem;
    for (int i = 0; i < menuListModel!.catData![listIndex].length; i++) {
      if (menuListModel!.catData![listIndex][i].name == cartItem.name &&
          menuListModel!.catData![listIndex][i].quantity! > 0) {
        index = i;

        updatedCartItem = CartItem(
            price: cartItem.price,
            quantity: menuListModel!.catData![listIndex][i].quantity! - 1,
            name: cartItem.name);
      }
    }
    if (index != -1) {
      menuListModel!.catData![listIndex].removeAt(index);
      menuListModel!.catData![listIndex].insert(index, updatedCartItem);
      calculateTotalPrice();
      // update order list
      updateOrderList(updatedCartItem);
    }
    notifyListeners();
  }

  void calculateTotalPrice() {
    int price = 0;
    if (menuListModel != null) {
      for (int i = 0; i < menuListModel!.catData!.length; i++) {
        for (int j = 0; j < menuListModel!.catData![i].length; j++) {
          price = price +
              menuListModel!.catData![i][j].price! *
                  menuListModel!.catData![i][j].quantity!;
        }
      }
    }

    totalPrice = price;
  }

//**
// ***************************** ORDER METHODS ********************************
//*/
  void updateOrderList(CartItem updatedCartItem) {
    int index = -1;
    for (int i = 0; i < orderList.length; i++) {
      if (orderList[i].name == updatedCartItem.name) {
        index = i;
      }
    }
    if (index == -1) {
      orderList.add(updatedCartItem);
    } else {
      orderList.removeAt(index);
      orderList.insert(index, updatedCartItem);
    }
  }

  Future<void> placeOrder() async {
    totalPrice = 0;
    orderList.sort((b, a) => a.quantity!.compareTo(b.quantity!));
    MenuListModel newMenuListModel = await listService.fetchMenuListData();
    List<List<CartItem>>? catData = [...newMenuListModel.catData!, orderList];

    menuListModel = MenuListModel(catData: catData);
    debugPrint('menuListModel -> ${menuListModel!.catData!.length}');
    notifyListeners();
  }
}
