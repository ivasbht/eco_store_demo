import 'package:eco_store_demo/UI/widgets_collection/custom_text/custom_text.dart';
import 'package:eco_store_demo/model/product_model/product_model.dart';
import 'package:flutter/material.dart';

class ProductsElement extends StatelessWidget {
  final ProductModel? model;
  final void Function()? onPressProduct;
  final Size screenSize;
  const ProductsElement({
    super.key,
    required this.screenSize,
    this.model,
    this.onPressProduct,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressProduct,
      child: Container(
        width: screenSize.width * 0.4,
        height: screenSize.height * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1.25,
            color: Colors.blueGrey,
          ),
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      child: Column(
        children: [
          _buildProductImage(model!),
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
        text: "${model?.title ?? "Name Not Available"}",
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
        text: "\n \$ " + "${model?.price ?? "N/A"}",
        fontSize: 18,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
      ),
    );
  }
}
