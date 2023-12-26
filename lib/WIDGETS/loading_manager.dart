import 'package:flutter/material.dart';
import 'package:smart_shop/CONSTANTS/app_colors.dart';

class LoadingManager extends StatelessWidget {
  const LoadingManager(
      {super.key, required this.child, required this.isLoading});
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          Container(
            color: Colors.black38,
          ),
          const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              color: AppColors.goldenColor,
            ),
          ),
        ],
      ],
    );
  }
}
