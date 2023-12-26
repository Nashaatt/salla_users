import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_shop/MODELS/order_model.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderModelAdvanced> orders = [];

  List<OrderModelAdvanced> get getOrders => orders;

  /////////////////////////////

  //////////////////////////////////////////

  // Future<List<OrderModelAdvanced>> fetchOrders() async {
  //   final auth = FirebaseAuth.instance;
  //   User? user = auth.currentUser;
  //   final uid = user!.uid;

  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("ordersAdvance")
  //         .where("userId", isEqualTo: uid)
  //         .get()
  //         .then((orderSnapshot) {
  //       orders.clear();

  //       for (var element in orderSnapshot.docs) {
  //         var data = element.data();
  //          inspect(data);

  //         String? deliveryDate = data.containsKey("deliveryDate")
  //             ? data["deliveryDate"].toString()
  //             : ""; // Use an empt
  //         orders.insert(
  //           0,
  //           OrderModelAdvanced(
  //             orderId: element.get("orderId"),
  //             userId: element.get("userId"),
  //             productId: element.get("productId"),
  //             prductTitle: element.get("productTitle").toString(),
  //             userName: element.get("userName"),
  //             price: element.get("price").toString(),
  //             ImageUrl: element.get("ImageUrl"),
  //             quntity: element.get("quntity").toString(),
  //             orderDate: element.get("orderDate"),
  //             orderaddress: element.get("orderAddress"),
  //             orderStatus: element.get("orderStatus"),
  //             deliverydate: deliveryDate,
  //           ),
  //         );
  //       }
  //     });
  //     return orders;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Stream<List<OrderModelAdvanced>> fetchOrdersStream() {
   final auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final uid = user!.uid;

  return FirebaseFirestore.instance
      .collection("ordersAdvance")
      .where("userId", isEqualTo: uid)
      .snapshots()
      .map((QuerySnapshot orderSnapshot) {
      List<OrderModelAdvanced> orders = [];
      for (var doc in orderSnapshot.docs) {
        orders.add(OrderModelAdvanced.fromFirestore(doc));
      }
      return orders;
    });
  }

  void removeOneItem({required productId}) {
    orders.remove(productId);
    notifyListeners();
  }
}
