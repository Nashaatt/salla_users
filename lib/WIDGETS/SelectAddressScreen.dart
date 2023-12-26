import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/MODELS/address_model.dart';
import 'package:smart_shop/PROVIDERS/address_provider.dart';
import 'package:uuid/uuid.dart';

import '../CART/cart_widget.dart';
import '../CONSTANTS/app_colors.dart';
import '../PROVIDERS/cart_provider.dart';
import '../PROVIDERS/products_provider.dart';
import '../PROVIDERS/user_provider.dart';
import '../SERVICES/my_app_functions.dart';
import 'AddAddressScreen.dart';
import 'app_name.dart';
import 'empty_bag_widget.dart';
import 'loading_manager.dart';

List<AddressModel> address = [];
String addressesAsString = "";

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  State<SelectAddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<SelectAddressScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final addressProvider = Provider.of<AddressProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return cartProvider.getCartItems.isEmpty &&
            addressProvider.getaddress.isEmpty
        ? const Scaffold(
            body: EmptyBagWidget(
              image: "IMG/bag/emptyCart.png",
              title: "Your Shopping cart looks empty.",
              subTitle: "what are you waiting for !!",
              buttonTitle: "Shop Now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text("Select Delivery Address"),
              centerTitle: true,
            ),
            body: LoadingManager(
              isLoading: isLoading,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // AppNameTextWidget(
                          //   text:
                          //       "Cart   [ ${cartProvider.getCartItems.length} ]   Products",
                          //   fontSize: 15,
                          //   fontWeight: FontWeight.bold,
                          // ),
                          IconButton(
                            onPressed: () async {
                              await cartProvider.clearCartFromFirestore();
                              cartProvider.clearLocalCart();
                            },
                            icon: const Icon(
                              Icons.clear_all,
                              color: AppColors.goldenColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: cartProvider.getCartItems.length * 118,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartProvider.getCartItems.length,
                          itemBuilder: (context, index) {
                            return ChangeNotifierProvider.value(
                              value: cartProvider.getCartItems.values
                                  .toList()[index],
                              child: const CartWidget(),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Select a delivery address",
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: "League",
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    addressProvider.getaddress.isNotEmpty
                        ? Container(
                            height: addressProvider.getaddress.length * 70,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: addressProvider.getaddress.length,
                                itemBuilder: (context, index) {
                                  return ChangeNotifierProvider.value(
                                      value: addressProvider.getaddress.values
                                          .toList()[index],
                                      child: const AddressWidget());
                                }),
                          )
                        : const SizedBox(
                            height: 30,
                          ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddressEditScreen(),
                              ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "Add a New Address",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.goldenColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (addressProvider.SelectedAddresses != "") {
                          await orderPlace(
                              cartProvider: cartProvider,
                              productProvider: productProvider,
                              userProvider: userProvider,
                              addressModel: addressProvider.SelectedAddresses);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please fill Select Adddress",
                              backgroundColor: AppColors.goldenColor,
                              textColor: Colors.white);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 320,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.goldenColor),
                            child: const Text(
                              "Cash on Delivery",
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Future<void> orderPlace({
    required CartProvider cartProvider,
    required ProductProvider productProvider,
    required UserProvider userProvider,
    required String addressModel,
  }) async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return;
    }
    final uid = user.uid;
    try {
      setState(() {
        isLoading = true;
      });
      cartProvider.getCartItems.forEach((key, value) async {
        final getCurrentProduct = productProvider.findById(value.producttID);
        final orderId = const Uuid().v4();
        await FirebaseFirestore.instance
            .collection("ordersAdvance")
            .doc(orderId)
            .set({
          "orderId": orderId,
          "userId": uid,
          "productId": value.producttID,
          "productTitle": getCurrentProduct!.productTitle,
          "userName": userProvider.userModel!.userName,
          "price": double.parse(getCurrentProduct.productPrice) * value.cartQty,
          "totalPrice": cartProvider.getTotal(productProvider: productProvider),
          "ImageUrl": getCurrentProduct.productImage,
          "quntity": value.cartQty,
          "orderDate": Timestamp.now(),
          "orderStatus": "0",
          "orderAddress": addressModel
        });
      });
      await cartProvider.clearCartFromFirestore();
      cartProvider.clearLocalCart();
      Navigator.pop(context);
    } catch (e) {
      // ignore: use_build_context_synchronously
      MyAppFunctions.showErrorOrWarningDialog(
          context: context, subtitle: e.toString(), fct: () {});
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

class AddressWidget extends StatefulWidget {
  const AddressWidget({Key? key}) : super(key: key);

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  @override
  Widget build(BuildContext context) {
    final addressModel = Provider.of<AddressModel>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final addressProvider = Provider.of<AddressProvider>(context);

    return ListTile(
      leading: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Radio<AddressModel>(
          fillColor:
              MaterialStateColor.resolveWith((states) => AppColors.goldenColor),
          value: addressModel,
          groupValue: addressProvider.getSelectedAddress(),
          onChanged: (AddressModel? selectedAddress) {
            addressProvider.setSelectedAddress(selectedAddress!);
          },
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name: ${userProvider.userModel!.userName}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('Address: ${addressModel.town} area ${addressModel.flat}'),
          Text('Phone: ${addressModel.phoneNumber}'),
          // Add other address fields as needed
        ],
      ),
    );
    //    GestureDetector(
    //     onTap: () {
    //   setState(() {
    //     addressModel.isSelected = !addressModel.isSelected;

    //     if (addressModel.isSelected) {

    //  addressProvider.addSelectedAddress(addressModel);
    // print('AddressModel instance: ${addressProvider.SelectedAddresses}');
    //     } else {
    //       addressProvider.removeSelectedAddress(addressModel);
    //     }
    //   });
    // },
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Stack(
    //           children: [
    //             Container(
    //               height: 100,
    //               width: 340,
    //               // color: Colors.amber,
    //             ),
    //             Positioned(
    //               left: 25,
    //               top: 35,
    //               child: Column(
    //                 children: [
    //                   Container(
    //                     height: 30,
    //                     width: 30,
    //                     decoration: BoxDecoration(
    //                       border: Border.all(
    //                         color: addressModel.isSelected
    //                             ? Colors.black
    //                             : Colors.grey,
    //                       ),
    //                       borderRadius: BorderRadius.circular(5),
    //                     ),
    //                     child: InkWell(
    //                       child: addressModel.isSelected
    //                           ? Icon(
    //                               Icons.check,
    //                               color: Colors.black,
    //                               size: 20,
    //                             )
    //                           : null,
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ),
    //             Positioned(
    //               right: 0,
    //               child: Container(
    //                 height: 100,
    //                 width: 250,
    //                 // color: Colors.red,
    //                 child: Column(
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Text(
    //                           userProvider.userModel!.userName.toString(),
    //                           style: TextStyle(
    //                             fontSize: 18,
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                     Row(
    //                       children: [
    //                         Text(
    //                             "Flat-${addressModel.flat}, Area-${addressModel.area}")
    //                       ],
    //                     ),
    //                     Row(
    //                       children: [
    //                         Text(
    //                             "State- ${addressModel.state}, ")
    //                       ],
    //                     ),
    //                     Row(
    //                       children: [
    //                         Text("Phone number = ${addressModel.phoneNumber}")
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   );
  }
}
