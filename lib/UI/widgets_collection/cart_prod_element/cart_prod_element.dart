import 'package:eco_store_demo/UI/widgets_collection/custom_text/custom_text.dart';
import 'package:eco_store_demo/model/product_model/product_model.dart';
import 'package:flutter/material.dart';

class CartProdElement extends StatelessWidget {
  final ProductModel? model;
  final void Function()? onPressProduct;
  final void Function()? onRemoveProduct;
  final Size screenSize;
  const CartProdElement({
    super.key,
    required this.screenSize,
    this.model,
    this.onPressProduct,
    this.onRemoveProduct,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressProduct,
      child: Container(
        width: screenSize.width * 0.95,
        margin: EdgeInsets.only(
          bottom: screenSize.height * 0.025,
        ),
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
      child: Row(
        children: [
          _buildProductImage(model!),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildProductName(),
              _buildPricing(),
              _buildDeleteCart(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(ProductModel prodModel) {
    return Container(
      width: screenSize.width * 0.15,
      height: screenSize.height * 0.15,
      margin: EdgeInsets.symmetric(
        vertical: screenSize.height * 0.01,
        horizontal: screenSize.width * 0.01,
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
      width: screenSize.width * 0.75,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(left: screenSize.width * 0.05),
      child: CustomText(
        text: "${model?.title ?? "Name Not Available"}",
        fontSize: 12,
        maxLine: 3,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildPricing() {
    return Container(
      alignment: Alignment.topLeft,
      width: screenSize.width * 0.75,
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
      child: CustomText(
        text: "\n \$ " + "${model?.price ?? "N/A"}",
        fontSize: 18,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildDeleteCart() {
    return TextButton(
      onPressed: onRemoveProduct,
      style: TextButton.styleFrom(
        side: BorderSide(color: Colors.blue)
      ),
      child: CustomText(
        text: "Remove",
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
