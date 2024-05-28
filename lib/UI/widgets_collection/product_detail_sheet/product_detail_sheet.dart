import 'package:eco_store_demo/UI/widgets_collection/custom_text/custom_text.dart';
import 'package:eco_store_demo/model/product_model/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailSheet extends StatelessWidget {
  final Size screenSize;
  final ProductModel product;
  ProductDetailSheet({
    super.key,
    required this.screenSize,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Container(
      child: Column(
        children: [
          _buildProductImage(product),
          _buildProductName(),
          _buildPricing(),
        ],
      ),
    );
  }

  Widget _buildProductImage(ProductModel prodModel) {
    return Container(
      width: screenSize.width * 0.25,
      height: screenSize.height * 0.25,
      margin: EdgeInsets.symmetric(
        vertical: screenSize.height * 0.01,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(prodModel.image ?? ""),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _buildProductName() {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
      child: CustomText(
        text: "${product.title ?? "Name Not Available"}",
        fontSize: 12,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildPricing() {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
      child: CustomText(
        text: "\n \$ " + "${product.price ?? "N/A"}",
        fontSize: 18,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
      ),
    );
  }
}
