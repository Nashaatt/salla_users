import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/CONSTANTS/app_colors.dart';
import 'package:smart_shop/MODELS/order_model.dart';
import 'package:smart_shop/PROVIDERS/order_provider.dart';
import 'package:smart_shop/WIDGETS/ITEM%20WIDGETS/order_widget.dart';
import 'package:smart_shop/WIDGETS/empty_widget.dart';
import 'package:smart_shop/WIDGETS/text_widget.dart';

class OrdersScreenFree extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreenFree({Key? key}) : super(key: key);

  @override
  State<OrdersScreenFree> createState() => _OrdersScreenFreeState();
}

class _OrdersScreenFreeState extends State<OrdersScreenFree> {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppNameTextWidget(
          text: "My orders",
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: StreamBuilder<List<OrderModelAdvanced>>(
        stream: orderProvider
            .fetchOrdersStream(), // Assuming this method returns a Stream<List<OrderModelAdvanced>>
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print(snapshot.connectionState);
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("${snapshot.error}7777777777777777");
            return SelectableText(
              snapshot.error.toString(),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const EmptyBagWidget(
              image: "IMG/bag/empty_order.png",
              buttonTitle: "shop now",
              title: "Empty Orders",
              subTitle: "select order and enjoy the quality",
            );
          }
          print(snapshot.data!.length);
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                child: OrderWidget(
                  orderModelAdvanced: snapshot.data![index],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                endIndent: 10,
                indent: 10,
                thickness: 1,
                color: AppColors.goldenColor,
              );
            },
          );
        },
      ),
    );
  }
}
