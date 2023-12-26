import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_shop/WIDGETS/titles.dart';

class AppNameTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const AppNameTextWidget({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      // ignore: sort_child_properties_last
      child: TitlesTextWidget(
        label: text,
        fontSize: fontSize,
        fontWeight: fontWeight,

      ),
      baseColor: const Color(0xffCBB26A),
      highlightColor: const Color.fromARGB(189, 0, 0, 0),
      period: const Duration(milliseconds: 2000),
    );
  }
}
