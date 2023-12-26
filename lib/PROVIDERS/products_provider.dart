import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_shop/MODELS/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> products = [];
  List<ProductModel> get getProduct {
    return products;
  }
   List<ProductModel> productsproductsHorizontal = [];
  List<ProductModel> get getProductproductsHorizontal {
    return productsproductsHorizontal;
  }
   List<ProductModel> productsproductsVertical = [];
  List<ProductModel> get getproductsproductsVertical {
    return productsproductsVertical;
  }

  ProductModel? findById(String productId) {
    if (products.where((element) => element.productID == productId).isEmpty) {
      return null;
    }
    return products.firstWhere((element) => element.productID == productId);
  }

  List<ProductModel> findByCategory({required String categoryName}) {
    List<ProductModel> categoryList = products
        .where((element) => element.productcategory.toLowerCase().contains(
              categoryName.toLowerCase(),
            ))
        .toList();
    return categoryList;
  }

  List<ProductModel> searchQuery({required String searchText}) {
    List<ProductModel> searchList = products
        .where((element) => element.productcategory.toLowerCase().contains(
              searchText.toLowerCase(),
            ))
        .toList();
    return searchList;
  }

  final productDb = FirebaseFirestore.instance.collection("products");
  Future<List<ProductModel>> fetchProducts() async {
    try {
      await productDb
          .orderBy("createdAt",descending: false)
          .get()
          .then((productSnapshot) {
        products.clear();
        // products = []
        for (var element in productSnapshot.docs) {
          products.insert(0, ProductModel.fromFirestore(element));
        }
      });
      notifyListeners();
      return products;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ProductModel>> fetchproductStream() {
    try {
      return productDb.snapshots().map((snapshot) {
        products.clear();
        // products = []
        for (var element in snapshot.docs) {
          products.insert(0, ProductModel.fromFirestore(element));
        }
       
        return products;
      });
    } catch (e) {
      rethrow;
    }
  }
 
 
  Future<List<ProductModel>> fetchProductsHorizontal() async {
    try {
      await productDb
          .where("productDirection",isEqualTo: "Latest Arrival")
          .get()
          .then((productSnapshot) {
        productsproductsHorizontal.clear();
        // products = []
        for (var element in productSnapshot.docs) {
          productsproductsHorizontal.insert(0, ProductModel.fromFirestore(element));
        }
      });
      notifyListeners();
      return productsproductsHorizontal;
    } catch (e) {
      rethrow;
    }
  }  Future<List<ProductModel>> fetchProductsVertical() async {
    try {
      await productDb
          .where("productDirection",isEqualTo: "Recommanded")
          .get()
          .then((productSnapshot) {
        productsproductsVertical.clear();
        // products = []
        for (var element in productSnapshot.docs) {
          productsproductsVertical.insert(0, ProductModel.fromFirestore(element));
        }
      });
      notifyListeners();
      return productsproductsVertical;
    } catch (e) {
      rethrow;
    }
  }

  
}


















  // List<ProductModel> products = [
  //   //111111111111111111111111111111111
  //   ProductModel(
  //     productID: const Uuid().v4(),
  //     productTitle: "Echo smart bluetooth speaker with",
  //     productDescreption:
  //         "Echo Dot (5th Gen) | smart bluetooth speaker with clock and Alexa | Use your voice to control smart home devices, play music or the Quran, and more (speaks English & Khaleeji) | Cloud Blue",
  //     productPrice: "229",
  //     productcategory: "Phones",
  //     productQty: "1",
  //     productImage:
  //         "https://m.media-amazon.com/images/I/71C3lbbeLsL._AC_UL480_FMwebp_QL65_.jpg",
  //   ),
  //   //2222222222222222222222222222222222
  //   ProductModel(
  //     productID: const Uuid().v4(),
  //     productTitle: "Smart-Watch",
  //     productDescreption:
  //         "Echo Dot (5th Gen) | smart bluetooth speaker with clock and Alexa | Use your voice to control smart home devices, play music or the Quran, and more (speaks English & Khaleeji) | Cloud Blue",
  //     productPrice: "5000",
  //     productcategory: "Watches",
  //     productQty: "1",
  //     productImage:
  //         "https://m.media-amazon.com/images/I/61obMEmVYRL._AC_UL480_FMwebp_QL65_.jpg",
  //   ),
  //   //3333333333333333333333333333
  //   ProductModel(
  //     productID: const Uuid().v4(),
  //     productTitle: "Black Decker 55W ",
  //     productDescreption:
  //         "Echo Dot (5th Gen) | smart bluetooth speaker with clock and Alexa | Use your voice to control smart home devices, play music or the Quran, and more (speaks English & Khaleeji) | Cloud Blue",
  //     productPrice: "230",
  //     productcategory: "Electronics",
  //     productQty: "1",
  //     productImage:
  //         "https://m.media-amazon.com/images/I/81vWMm0TaqL.__AC_SX300_SY300_QL70_ML2_.jpg",
  //   ),
  //   //44444444444444444444444444444444444444
  //   ProductModel(
  //     productID: const Uuid().v4(),
  //     productTitle: "HeadPone G50",
  //     productDescreption:
  //         "Echo Dot (5th Gen) | smart bluetooth speaker with clock and Alexa | Use your voice to control smart home devices, play music or the Quran, and more (speaks English & Khaleeji) | Cloud Blue",
  //     productPrice: "270",
  //     productcategory: "ُPc",
  //     productQty: "7",
  //     productImage:
  //         "https://m.media-amazon.com/images/I/61k7dsClp9L._AC_UL480_FMwebp_QL65_.jpg",
  //   ),
  //   //5555555555555555555555555555555555555555555555
  //   ProductModel(
  //     productID: const Uuid().v4(),
  //     productTitle: "Addidas Men's shirt",
  //     productDescreption:
  //         "Echo Dot (5th Gen) | smart bluetooth speaker with clock and Alexa | Use your voice to control smart home devices, play music or the Quran, and more (speaks English & Khaleeji) | Cloud Blue",
  //     productPrice: "120",
  //     productcategory: "Clothes",
  //     productQty: "1",
  //     productImage:
  //         "https://assets.adidas.com/images/w_1880,f_auto,q_auto/52980bff1a494c459f0ffd8380664a32_9366/IM4587_21_model.jpg",
  //   ),
  // ];

