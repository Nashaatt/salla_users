import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/PROVIDERS/cart_provider.dart';
import 'package:smart_shop/WIDGETS/subtitles.dart';
import 'package:smart_shop/WIDGETS/titles.dart';

import '../PROVIDERS/products_provider.dart';
import '../PROVIDERS/user_provider.dart';
import 'select_address_screen.dart';

class CartBottomSheetWidget extends StatelessWidget {
  const CartBottomSheetWidget({super.key, });


  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productsProvider = Provider.of<ProductProvider>(context);
   
    return Container(
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const BorderDirectional(
          top: BorderSide(color: Color(0xffCBB26A), width: 2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  TitlesTextWidget(
                    label:
                        "Total: [ ${cartProvider.getCartItems.length} ] Products  [ ${cartProvider.getQty()} ] Items",
                    fontSize: 12,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SubtitleTextWidget(
                    label:
                        "${cartProvider.getTotal(productProvider: productsProvider).toStringAsFixed(2)} AED",
                    color: Color(0xffCBB26A),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffCBB26A),
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () async {
               
                
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SelectAddressScreen(),));

                // await function();
              },
              child: const Text(
                "Buy",
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
