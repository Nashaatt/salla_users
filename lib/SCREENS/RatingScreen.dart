import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../CONSTANTS/app_colors.dart';
import '../PROVIDERS/cart_provider.dart';
import '../PROVIDERS/products_provider.dart';
import '../PROVIDERS/user_provider.dart';
import '../SERVICES/my_app_functions.dart';

class RatingScreen extends StatefulWidget {
  final String orderid;
  final String productid;

  RatingScreen(this.orderid, this.productid);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double rate = 0.0;
  final TextEditingController _titlereviewController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal.withOpacity(0.6),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "How would you rate it?",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 15),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      rate = rating;
                    });
                    print(rate);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Title your review",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextFormField(
                controller: _titlereviewController,
                decoration: InputDecoration(
                    hintText: "What's most important to know?",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Write your review",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextFormField(
                controller: _reviewController,
                // obscureText: true,
                maxLines: 8,
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(top: 10, left: 10),
                    hintText:
                        """   What did you like or dislike? What did 
     you use this product for?""",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            SizedBox(
              height: 150,
            ),
            GestureDetector(
              onTap: () async {
                if (_titlereviewController.text != "" &&
                    _reviewController != "" &&
                    rate != 0) {
                  await rating();
                  await displayProductMaxRating(widget.productid);
                } else {
                  Fluttertoast.showToast(
                      msg: "Please required all field",
                      backgroundColor: AppColors.goldenColor,
                      textColor: Colors.white);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 330,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange.withOpacity(0.3),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> displayProductMaxRating(String productId) async {
    double productMaxRating = await calculateProductAverageRating(productId);
    await FirebaseFirestore.instance
        .collection("products")
        .doc(productId)
        .update({
      'TotalproductRating': productMaxRating,
    });
    print('Max rating for product $productId: $productMaxRating');
    // Use the retrieved max rating as needed in your app UI
  }

  Future<void> rating() async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return;
    }
    final uid = user.uid;
    print(uid);
    try {
      // setState(() {
      //   isLoading = true;
      // });

      final ratingid = const Uuid().v4();
      print(ratingid);
      await FirebaseFirestore.instance
          .collection("ProductRating")
          .doc(ratingid)
          .set({
        "ratingid": ratingid,
        "userId": uid,
        "productId": widget.productid,
        "orderid": widget.orderid,
        "rating": rate,
        "titleReview": _titlereviewController.text,
        "Review": _reviewController.text
      });
      await FirebaseFirestore.instance
          .collection("ordersAdvance")
          .doc(widget.orderid)
          .update({'orderStatus': "3"});
      Fluttertoast.showToast(
          msg: "Rating and review has been added",
          backgroundColor: AppColors.goldenColor,
          textColor: Colors.white);
      // await cartProvider.clearCartFromFirestore();
      // cartProvider.clearLocalCart();
      Navigator.pop(context);
    } catch (e) {
      // ignore: use_build_context_synchronously
      MyAppFunctions.showErrorOrWarningDialog(
          context: context, subtitle: e.toString(), fct: () {});
    } finally {}
  }
//   Future<double> getProductMaxRating(String productId) async {
//   double maxRating = 0;

//   try {
//     QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('ProductRating')
//         .where('productId', isEqualTo: productId)
//         .get();

//     if (snapshot.docs.isNotEmpty) {
//       // Iterate through the ratings and find the maximum
//       for (var doc in snapshot.docs) {
//         double rating = doc['rating'] as double;
//         if (rating > maxRating) {
//           maxRating = rating;
//           print(maxRating);
//         }
//       }
//     }
//   } catch (e) {
//     print("Error fetching ratings: $e");
//   }

//   return maxRating;
// }
  Future<double> calculateProductAverageRating(String productId) async {
    double totalRating = 0;
    int numberOfRatings = 0;

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('ProductRating')
          .where('productId', isEqualTo: productId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          double rating = doc['rating'] as double;
          totalRating += rating;
          numberOfRatings++;
        }
      }
    } catch (e) {
      print("Error fetching ratings: $e");
    }

    if (numberOfRatings > 0) {
      double averageRating = totalRating / numberOfRatings;
      return averageRating;
    } else {
      return 0; // Return 0 if there are no ratings for the product
    }
  }
}
