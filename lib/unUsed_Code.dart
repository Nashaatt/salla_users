// Future<void> signIn() async {
//     try {
//       if (emailController.text.trim().isEmpty) {
//         return showWarningSnackBar(context, 'Empty Email');
//       }
//       if (passwordController.text.trim().isEmpty) {
//         return showWarningSnackBar(context, 'Empty Password');
//       }

//       await AuthService().signInUser(
//         emailController.text.trim(),
//         passwordController.text.trim(),
//       );
//       if (!context.mounted) return;
//       showSnackBar(context, 'Successfully logged in');
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         showErrorSnackBar(context, 'No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         showErrorSnackBar(context, 'Wrong password provided for that user.');
//       } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
//         showErrorSnackBar(context, 'Login credentials are invalid.');
//       } else if (e.code == 'invalid-email') {
//         showErrorSnackBar(context, 'The email address is badly formatted.');
//       }
//     }
//   }



//////////// LATEST ARRIVAL ////////////////////////////////////////////////////////




// Padding(
//       padding: const EdgeInsets.only(right: 8.0),
//       child: GestureDetector(
//         onTap: () async {
//           viwedProductProvider.addViewedProduct(
//             productId: productModel.productID,
//           );
//           await Navigator.pushNamed(
//             context,
//             ProductDetailsScreen.routName,
//             arguments: productModel.productID,
//           );
//         },
//         child: Container(
//           width: size.width * 0.70,
//           padding: const EdgeInsets.all(9),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//               color: AppColors.goldenColor,
//               width: 1,
//             ),
//           ),
//           child: Row(
//             children: [
//               SizedBox(
//                 width: 90,
//                 height: 90,
//                 child: Image.network(
//                   productModel.productImage,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Flexible(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Flexible(
//                       child: TitlesTextWidget(
//                         label: productModel.productTitle,
//                         maxLines: 1,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

                    
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SubtitleTextWidget(
//                           label: "${productModel.productPrice} AED",
//                           fontSize: 12,
//                           color: Colors.red,
//                           fontWeight: FontWeight.w600,
//                         ),


//                         Row(
//                           children: [
//                             HeartButton(
//                               productID: productModel.productID,
//                             ),
//                             const SizedBox(
//                               width: 6,
//                             ),
//                             InkWell(
//                               onTap: () async {
//                                 if (cartProvider.isProdInCart(
//                                     productId: productModel.productID)) {
//                                   return;
//                                 }
//                                 cartProvider.addProductToCart(
//                                     productId: productModel.productID);
//                                 try {
//                                   await cartProvider.addToCartFirebase(
//                                     productId: productModel.productID,
//                                     qty: 1,
//                                     context: context,
//                                   );
//                                 } catch (e) {
//                                   // ignore: use_build_context_synchronously
//                                   MyAppFunctions.showErrorOrWarningDialog(
//                                       context: context,
//                                       subtitle: e.toString(),
//                                       fct: () {});
//                                 }
//                               },
//                               child: Icon(
//                                 cartProvider.isProdInCart(
//                                         productId: productModel.productID)
//                                     ? Icons.check
//                                     : Icons.add_shopping_cart_rounded,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );





// getCurrentProduct == null
//         ? const SizedBox.shrink()
//         :

//////////////////////////////////DELETE\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// IconButton(
//                                     onPressed: () async {
//                                       await cartProvider
//                                           .removeCartItemFromFirestor(
//                                         cartId: cartModel.cartID,
//                                         productId: cartModel.producttID,
//                                         qty: cartModel.cartQty,
//                                       );
//                                       cartProvider.removeOneItem(
//                                         productId: getCurrentProduct.productID,
//                                       );
//                                     },
//                                     icon: const Icon(
//                                       Icons.clear,
//                                       color: Color.fromARGB(255, 219, 43, 30),
//                                       size: 35,
//                                     ),
//                                   ),
///////////////////////////////qTY/////////////////////////////////////////////
// OutlinedButton.icon(
//                                 onPressed: () async {
//                                   await showModalBottomSheet(
//                                       backgroundColor: Theme.of(context)
//                                           .scaffoldBackgroundColor,
//                                       shape: const RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.only(
//                                             topRight: Radius.circular(10),
//                                             topLeft: Radius.circular(10)),
//                                       ),
//                                       context: context,
//                                       builder: (context) {
//                                         return QuentityBottomWidget(
//                                           cartModel: cartModel,
//                                         );
//                                       });
//                                 },
//                                 icon: const Icon(
//                                   IconlyLight.arrowDown2,
//                                   color: Color(0xffCBB26A),
//                                 ),
//                                 label: Text(
//                                   // getCurrentProduct.productQty
//                                   "${cartModel.cartQty}",
//                                   style: const TextStyle(),
//                                 ),
//                                 style: OutlinedButton.styleFrom(
//                                   side: const BorderSide(
//                                       width: 1, color: Color(0xffCBB26A)),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30.0),
//                                   ),
//                                 ),
//                               ),

