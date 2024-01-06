import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/MODELS/order_model.dart';
import 'package:smart_shop/PROVIDERS/order_provider.dart';
import 'package:smart_shop/SIDE%20SCREENS/RatingScreen.dart';
import 'package:smart_shop/WIDGETS/text_widget.dart';

import '../../PROVIDERS/user_provider.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key, required this.orderModelAdvanced});
  final OrderModelAdvanced orderModelAdvanced;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  void initState() {
    print(widget.orderModelAdvanced.ImageUrl);
    super.initState();
  }

  bool seemore = false;
  @override
  Widget build(BuildContext context) {
    // final OrderModelAdvanced orderModelAdvanced;
    final orderProvider = Provider.of<OrderProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    getdate(String input) {
      DateTime parsedDate = DateTime.parse(input);

      String formattedDate =
          DateFormat.MMMd().format(parsedDate); // Formats as "Dec 30"
      String year =
          DateFormat.y().format(parsedDate); // Extracts the year as "2023"

      String finalFormattedDate = '$formattedDate $year'; // Combines both parts

      return finalFormattedDate; // Output: Dec 30 2023
    }

    return Column(
      children: [
        FittedBox(
          child: IntrinsicWidth(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200,
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
                ),
              ),
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: FancyShimmerImage(
                      imageUrl: widget.orderModelAdvanced.ImageUrl,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.8,
                              child: TitlesTextWidget(
                                label: widget.orderModelAdvanced.prductTitle,
                                maxLines: 2,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SubtitleTextWidget(
                              label: "${widget.orderModelAdvanced.price} AED",
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: const Color.fromARGB(255, 138, 106, 9),
                            ),
                            SubtitleTextWidget(
                              label:
                                  "Qty : x ${widget.orderModelAdvanced.quntity}",
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: const Color.fromARGB(255, 138, 106, 9),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SubtitleTextWidget(
                          label:
                              "Order Date : ${widget.orderModelAdvanced.orderDate.toDate().day} / ${widget.orderModelAdvanced.orderDate.toDate().month} / ${widget.orderModelAdvanced.orderDate.toDate().year}",
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  seemore = !seemore;
                });
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: const SubtitleTextWidget(
                  color: Colors.blue,
                  label: "See more..",
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 20, 0),
              child: SubtitleTextWidget(
                color: Colors.blue,
                label: widget.orderModelAdvanced.orderStatus == "1"
                    ? "Shipping"
                    : widget.orderModelAdvanced.orderStatus == "2" ||
                            widget.orderModelAdvanced.orderStatus == "3"
                        ? "Delivered"
                        : "Preparing",
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        seemore == true
            ? Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 57, 131, 131),
                    borderRadius: BorderRadius.circular(15)),
                width: size.width * 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    //////////////////// Address ////////////////////////
                    SubtitleTextWidget(
                      color: Colors.white,
                      label:
                          "Address : ${widget.orderModelAdvanced.orderaddress}",
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    ////////////////////PAYMRNT METHOD ////////////////////////
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SubtitleTextWidget(
                          label: "Payment Method :",
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                        Spacer(),
                        SubtitleTextWidget(
                          color: Colors.white,
                          label: "cash on delivery",
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SubtitleTextWidget(
                          label: "delivery Status :",
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                        const Spacer(),
                        SubtitleTextWidget(
                          color: Colors.white,
                          label: widget.orderModelAdvanced.orderStatus == "1"
                              ? "shipping"
                              : widget.orderModelAdvanced.orderStatus == "2" ||
                                      widget.orderModelAdvanced.orderStatus ==
                                          "3"
                                  ? "Delivered"
                                  : "preparing",
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    widget.orderModelAdvanced.orderStatus == "1"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SubtitleTextWidget(
                                color: Colors.red,
                                label: "Estimated Delivery Date :",
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              SubtitleTextWidget(
                                color: Colors.red,
                                label:
                                    "${getdate(widget.orderModelAdvanced.deliverydate.toString())}",
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ],
                          )
                        : widget.orderModelAdvanced.orderStatus == "2"
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RatingScreen(
                                            widget.orderModelAdvanced.orderId,
                                            widget
                                                .orderModelAdvanced.productId)),
                                  );
                                },
                                child: const SubtitleTextWidget(
                                  color: Colors.white,
                                  label: "Write Review",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              )
                            : widget.orderModelAdvanced.orderStatus == "3"
                                ? Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.check_rounded,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        SubtitleTextWidget(
                                          color: Colors.white,
                                          label: "Review Added",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox()
                  ],
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
