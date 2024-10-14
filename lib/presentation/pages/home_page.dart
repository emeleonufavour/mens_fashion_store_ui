import 'package:fashion_ecommerce_ui/data/datasource/image_data_source.dart';
import 'package:fashion_ecommerce_ui/presentation/widgets/model_swiper.dart';
import 'package:fashion_ecommerce_ui/presentation/widgets/model_content.dart';
import 'package:fashion_ecommerce_ui/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(CupertinoIcons.back),
        title: const TextWidget("Men", fontWeight: FontWeight.bold),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Badge(
              child: Icon(CupertinoIcons.cart),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextWidget("Sort by"),
                  Icon(Icons.sort_sharp),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.8,
              child: ModelSwiper(
                children: List.generate(
                  ImageDataSource.imageAssets.length,
                  (index) => ModelContent(
                    imageAsset: ImageDataSource.imageAssets[index],
                  ),
                ),
              ),
            ),
            // Bottom content
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          height: size.height * 0.01,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.maxFinite,
                          height: size.height * 0.01,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(
                    CupertinoIcons.heart,
                    color: Colors.grey,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
