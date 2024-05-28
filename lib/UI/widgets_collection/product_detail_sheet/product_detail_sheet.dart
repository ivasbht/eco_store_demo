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
      height: screenSize.height * 0.9,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProductImage(product),
          Column(
            children: [
              _buildProductName(),
              _buildProductRating(),
              _buildPricing(),
              _buildProductDescription(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(ProductModel prodModel) {
    return Container(
      width: screenSize.width * 0.85,
      height: screenSize.height * 0.45,
      margin: EdgeInsets.symmetric(
        vertical: screenSize.height * 0.025,
        horizontal: screenSize.width * 0.025,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.blueGrey,
        ),
        image: DecorationImage(
          image: NetworkImage(prodModel.image ?? ""),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildProductName() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
      child: CustomText(
        text: "${product.title ?? "Name Not Available"} ",
        fontSize: 16,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.left,
        textSpans: [
          TextSpan(
            text: "\n(${product.category})",
            style: TextStyle(
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricing() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(
        vertical: screenSize.height * 0.035,
        horizontal: screenSize.width * 0.05,
      ),
      child: CustomText(
        text: "Price \$" + "${product.price ?? "N/A"}",
        fontSize: 14,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildProductDescription() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
      child: CustomText(
        text: "${product.description ?? "Description Not Available"}",
        fontSize: 14,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildProductRating() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.05,
        vertical: screenSize.height * 0.01,
      ),
      child: Row(
        children: [
          Icon(Icons.star),
          CustomText(
            text: "${product.rating["rate"] ?? ""}",
            fontSize: 14,
            textAlign: TextAlign.left,
            color: Colors.blueGrey,
            textSpans: [
              TextSpan(
                text: " (${product.rating["count"] ?? ""})",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
