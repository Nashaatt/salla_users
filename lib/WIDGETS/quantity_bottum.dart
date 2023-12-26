import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/MODELS/cart_model.dart';
import 'package:smart_shop/PROVIDERS/cart_provider.dart';
import 'package:smart_shop/WIDGETS/subtitles.dart';

class QuentityBottomWidget extends StatelessWidget {
  const QuentityBottomWidget({super.key, required this.cartModel});
  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 6,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xffCBB26A),
          ),
        ),
        Expanded(
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              // shrinkWrap: true,
              itemCount: 100,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    cartProvider.updateQty(
                      Qty: index + 1,
                      productId: cartModel.producttID,
                    );
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SubtitleTextWidget(label: "${index + 1}"),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}