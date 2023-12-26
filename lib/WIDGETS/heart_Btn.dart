import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/PROVIDERS/wishList_provider.dart';

class HeartButton extends StatefulWidget {
  const HeartButton({
    super.key,
    required this.productID,
  });

  final String productID;

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListProvider>(context);
    return InkWell(
      onTap: () async {
        // wishListProvider.addOrRemoveFromWishList(productId: widget.productID);
        if (wishListProvider.getWishListItems.containsKey(widget.productID)) {
          await wishListProvider.removeWishListItemFromFirestor(
            wishListId:
                wishListProvider.getWishListItems[widget.productID]!.wishListID,
            productId: widget.productID,
          );
        } else {
          wishListProvider.addToWishListFirebase(
            productId: widget.productID,
            context: context,
          );
        }
        await wishListProvider.fetchWishList();
      },
      child: Icon(
        wishListProvider.isProdInWishList(productId: widget.productID)
            ? IconlyBold.heart
            : IconlyLight.heart,
        color: wishListProvider.isProdInWishList(productId: widget.productID)
            ? Colors.red
            : Theme.of(context).primaryColorDark,
      ),
    );
  }
}
