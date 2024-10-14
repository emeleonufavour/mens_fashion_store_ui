import 'package:fashion_ecommerce_ui/core/constants.dart';
import 'package:fashion_ecommerce_ui/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  final String title;
  final IconData icon;

  const ProductInfo({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.bodyHorizontalPadding,
        vertical: 4,
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 10),
          TextWidget(title),
        ],
      ),
    );
  }
}
