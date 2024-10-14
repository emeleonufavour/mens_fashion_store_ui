import 'package:fashion_ecommerce_ui/data/datasource/image_data_source.dart';
import 'package:fashion_ecommerce_ui/presentation/widgets/product_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashion_ecommerce_ui/core/constants.dart';
import 'package:fashion_ecommerce_ui/core/controllers/bottom_container_ctr.dart';
import 'package:fashion_ecommerce_ui/presentation/widgets/bottom_container.dart';
import 'package:fashion_ecommerce_ui/presentation/widgets/model_card.dart';
import 'package:fashion_ecommerce_ui/presentation/widgets/text_widget.dart';

class ModelDetailsPage extends StatefulWidget {
  final String imageAsset;

  const ModelDetailsPage({super.key, required this.imageAsset});

  @override
  State<ModelDetailsPage> createState() => _ModelDetailsPageState();
}

class _ModelDetailsPageState extends State<ModelDetailsPage> {
  final BottomContainerController _controller = BottomContainerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(CupertinoIcons.back),
      ),
      title: const TextWidget("Men", fontWeight: FontWeight.bold),
      actions: const [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Constants.bodyHorizontalPadding),
          child: Badge(child: Icon(CupertinoIcons.cart)),
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
        ),
        _buildHeroImage(),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _buildBottomContainer(context),
        ),
      ],
    );
  }

  Widget _buildHeroImage() {
    return GestureDetector(
      onTap: _controller.minimize,
      child: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Hero(
          tag: widget.imageAsset,
          child: Image.asset(widget.imageAsset),
        ),
      ),
    );
  }

  Widget _buildBottomContainer(BuildContext context) {
    return BottomContainer(
      controller: _controller,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildProductInfo(),
          _buildAddToCartButton(context),
          _buildDeliveryInfo(),
          _buildAboutProduct(),
          _buildRelatedProducts(),
        ],
      ),
    );
  }

  Widget _buildProductInfo() {
    return const Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Constants.bodyHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget("Men's fashion",
              fontSize: 16, fontWeight: FontWeight.bold),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget("\$35", fontSize: 16),
              Row(
                children: [
                  Icon(CupertinoIcons.heart),
                  TextWidget("  353", fontSize: 16),
                ],
              ),
            ],
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.07,
      margin: const EdgeInsets.symmetric(
          horizontal: Constants.bodyHorizontalPadding),
      decoration: const BoxDecoration(color: Colors.black),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget("Add to Cart", color: Colors.white, fontSize: 16),
          SizedBox(width: 10),
          Icon(CupertinoIcons.cart, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfo() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProductInfo(title: "Free delivery", icon: Icons.delivery_dining),
          ProductInfo(title: "Free return", icon: Icons.drive_eta),
        ],
      ),
    );
  }

  Widget _buildAboutProduct() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: Constants.bodyHorizontalPadding,
          ),
          child: TextWidget("About product"),
        ),
        ProductInfo(title: "Product details", icon: Icons.info_outline),
        SizedBox(height: 30),
      ],
    );
  }

  Widget _buildRelatedProducts() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.bodyHorizontalPadding,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: ImageDataSource.imageAssets.length,
        itemBuilder: (context, index) {
          return ModelCard(imageAsset: ImageDataSource.imageAssets[index]);
        },
      ),
    );
  }
}
