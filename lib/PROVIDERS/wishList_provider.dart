import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_shop/CONSTANTS/app_colors.dart';
import 'package:smart_shop/MODELS/wishList_model.dart';
import 'package:smart_shop/SERVICES/my_app_functions.dart';
import 'package:uuid/uuid.dart';

class WishListProvider with ChangeNotifier {
  final Map<String, WishListModel> _whishListItems = {};

  Map<String, WishListModel> get getWishListItems {
    return _whishListItems;
  }

  final userstDb = FirebaseFirestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;
// Firebase
  Future<void> addToWishListFirebase({
    required String productId,
    required BuildContext context,
  }) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: "Please login first",
        fct: () {},
      );
      return;
    }
    final uid = user.uid;
    final wishListId = const Uuid().v4();
    try {
      await userstDb.doc(uid).update({
        'userWish': FieldValue.arrayUnion([
          {
            'wishListId': wishListId,
            'productId': productId,
          }
        ])
      });
      Fluttertoast.showToast(
          msg: "Item has been added",
          backgroundColor: AppColors.goldenColor,
          textColor: Colors.white);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchWishList() async {
    final User? user = _auth.currentUser;
    if (user == null) {
      _whishListItems.clear();
      return;
    }
    try {
      final userDoc = await userstDb.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey("userWish")) {
        return;
      }
      final leg = userDoc.get("userWish").length;
      for (int index = 0; index < leg; index++) {
        _whishListItems.putIfAbsent(
            userDoc.get("userWish")[index]["productId"],
            () => WishListModel(
                  wishListID: userDoc.get("userWish")[index]["wishListId"],
                  producttID: userDoc.get("userWish")[index]["productId"],
                ));
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> removeWishListItemFromFirestor({
    required String wishListId,
    required String productId,
  }) async {
    final User? user = _auth.currentUser;
    try {
      await userstDb.doc(user!.uid).update({
        'userWish': FieldValue.arrayRemove([
          {
            'wishListId': wishListId,
            'productId': productId,
          }
        ])
      });
      // await fetchCart();
      _whishListItems.remove(productId);
      Fluttertoast.showToast(
        msg: "Item has been Removed",
        backgroundColor: AppColors.goldenColor,
        textColor: Colors.white,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearWishListFromFirestore() async {
    final User? user = _auth.currentUser;
    try {
      await userstDb.doc(user!.uid).update({
        'userWish': [],
      });
      // await fetchWishList();
      _whishListItems.clear();
      Fluttertoast.showToast(
        msg: "You cleared All WishList !",
        backgroundColor: AppColors.goldenColor,
        textColor: Colors.white,
      );
    } catch (e) {
      rethrow;
    }
  }

// Local

  void addOrRemoveFromWishList({required String productId}) {
    if (_whishListItems.containsKey(productId)) {
      _whishListItems.remove(productId);
    } else {
      _whishListItems.putIfAbsent(
        productId,
        () =>
            WishListModel(wishListID: const Uuid().v4(), producttID: productId),
      );
    }
    notifyListeners();
  }

  bool isProdInWishList({required String productId}) {
    return _whishListItems.containsKey(productId);
  }

  void clearLocalWishList() {
    _whishListItems.clear();
    notifyListeners();
  }
}
