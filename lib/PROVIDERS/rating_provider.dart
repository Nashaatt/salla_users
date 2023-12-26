import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../MODELS/rating_model.dart';

class RatingProvider with ChangeNotifier {
  final List<RatingModelAdvanced> review = [];

  List<RatingModelAdvanced> get getreviews => review;

  Future<List<RatingModelAdvanced>> fetchproductreview(String productid) async {
    try {
      await FirebaseFirestore.instance
          .collection("ProductRating")
          .where("productId", isEqualTo: productid)
          .get()
          .then((Snapshot) {
            review.clear();
        for (var element in Snapshot.docs) {
          var data = element.data();
          inspect(data);

          review.insert(
            0,
            RatingModelAdvanced(
              element.get("orderid"),
              element.get("userId"),
              element.get("productId"),
              element.get("ratingid"),
              element.get("rating").toString(),
              element.get("Review"),
              element.get("titleReview"),
            ),
          );
        }
      });
      print(review);
      return review;
    } catch (e) {
      rethrow;
    }
  }
  Future<Map<String, dynamic>> getUserDetails(String userId) async {
  try {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get();

    if (userSnapshot.exists) {
      // User details found, return the user data as a Map
      return userSnapshot.data() as Map<String, dynamic>;
    } else {
      // User not found or details are missing
      return {}; // Return an empty Map or null based on your handling
    }
  } catch (e) {
    // Handle any errors that occur during fetching user details
    print("Error fetching user details: $e");
    return {}; // Return an empty Map or null based on your handling
  }
}


  // Stream<List<OrderModelAdvanced>> fetchOrdersStream() {
  //  final auth = FirebaseAuth.instance;
  // User? user = auth.currentUser;
  // final uid = user!.uid;

  // return FirebaseFirestore.instance
  //     .collection("ordersAdvance")
  //     .where("userId", isEqualTo: uid)
  //     .snapshots()
  //     .map((QuerySnapshot orderSnapshot) {
  //     List<OrderModelAdvanced> orders = [];
  //     for (var doc in orderSnapshot.docs) {
  //       orders.add(OrderModelAdvanced.fromFirestore(doc));
  //     }
  //     return orders;
  //   });
  // }

  // void removeOneItem({required productId}) {
  //   orders.remove(productId);
  //   notifyListeners();
  // }
}
