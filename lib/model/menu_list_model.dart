class MenuListModel {
  List<List<CartItem>>? catData;

  MenuListModel({this.catData});

  MenuListModel.fromJson(Map<String, dynamic> json) {
    List<CartItem> cat1 = [];
    List<CartItem> cat2 = [];
    List<CartItem> cat3 = [];
    List<CartItem> cat4 = [];
    List<CartItem> cat5 = [];
    List<CartItem> cat6 = [];

    if (json['cat1'] != null) {
      json['cat1'].forEach((v) {
        cat1.add(CartItem.fromJson(v));
      });
    }
    if (json['cat2'] != null) {
      json['cat2'].forEach((v) {
        cat2.add(CartItem.fromJson(v));
      });
    }
    if (json['cat3'] != null) {
      json['cat3'].forEach((v) {
        cat3.add(CartItem.fromJson(v));
      });
    }
    if (json['cat4'] != null) {
      json['cat4'].forEach((v) {
        cat4.add(CartItem.fromJson(v));
      });
    }
    if (json['cat5'] != null) {
      json['cat5'].forEach((v) {
        cat5.add(CartItem.fromJson(v));
      });
    }
    if (json['cat6'] != null) {
      json['cat6'].forEach((v) {
        cat6.add(CartItem.fromJson(v));
      });
    }

    catData = [cat1, cat2, cat3, cat4, cat5, cat6];
  }
}

class CartItem {
  String? name;
  int? price;
  bool? instock;
  int? quantity;

  CartItem({this.name, this.price, this.instock, this.quantity});

  CartItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    instock = json['instock'];
    quantity = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['price'] = price;
    data['instock'] = instock;
    data['quantity'] = quantity;
    return data;
  }
}
