import 'package:fashion_ecommerce_ui/core/constants.dart';
import 'package:fashion_ecommerce_ui/presentation/pages/model_details_page.dart';
import 'package:flutter/material.dart';

class ModelContent extends StatelessWidget {
  final String imageAsset;

  const ModelContent({super.key, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Constants.modelWidth,
        height: 250,
        padding: const EdgeInsets.all(40),
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ModelDetailsPage(imageAsset: imageAsset))),
          child: Hero(
              tag: imageAsset,
              child: Image.asset(fit: BoxFit.fitHeight, imageAsset)),
        ));
  }
}
