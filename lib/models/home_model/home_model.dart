// class HomeModel {
//   bool? status;
//   HomeDataModel? data;
//
//   HomeModel.formJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = HomeDataModel.formJson(json['data']);
//   }
// }
//
// class HomeDataModel {
//   List<BannerModel> banner = [];
//   List<ProductModel> product = [];
//
//   HomeDataModel.formJson(Map<String, dynamic> json) {
//     json['banner'].forEaach((element) {
//       banner.add(element);
//     });
//     json['product'].forEaach((element) {
//       product.add(element);
//     });
//   }
// }
//
// class BannerModel {
//   int? id;
//   String? image;
//
//   BannerModel.formJson(Map<String, dynamic> json) {
//     id = json['id'];
//     image = json['image'];
//   }
// }
//
// class ProductModel {
//   int? id;
//   dynamic price;
//   dynamic oldPrice;
//   dynamic discount;
//   String? image;
//   String? name;
//   bool? inFavorites;
//   bool? inCart;
//
//   ProductModel.formJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     name = json['name'];
//     image = json['image'];
//     inFavorites = json['in_favorites'];
//     inCart = json['in_cart'];
//   }
// }

class HomeModel {
  bool? status;
  String? message;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class HomeDataModel {
  List<BannersModel>? banners;
  List<ProductsModel>? products;
  String? ad;

  HomeDataModel({this.banners, this.products, this.ad});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <BannersModel>[];
      json['banners'].forEach((v) {
        banners!.add(BannersModel.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <ProductsModel>[];
      json['products'].forEach((v) {
        products!.add(ProductsModel.fromJson(v));
      });
    }
    ad = json['ad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (banners != null) {
      data['banners'] = banners!.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['ad'] = ad;
    return data;
  }
}

class BannersModel {
  int? id;
  String? image;

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['discount'] = discount;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    data['in_favorites'] = inFavorites;
    data['in_cart'] = inCart;
    return data;
  }
}
