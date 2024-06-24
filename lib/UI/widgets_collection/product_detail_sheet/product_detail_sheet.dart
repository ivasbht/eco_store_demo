import 'package:eco_store_demo/UI/widgets_collection/custom_text/custom_text.dart';
import 'package:eco_store_demo/model/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductDetailSheet extends StatelessWidget {
  final Size screenSize;
  final ProductModel product;
  final int quantity;
  final void Function()? onAddToCart;
  final void Function(int)? onIncrement;
  final void Function(int)? onDecrement;
  ProductDetailSheet({
    super.key,
    required this.screenSize,
    required this.product,
    this.onAddToCart,
    this.quantity = 0,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width,
      height: screenSize.height * 0.95,
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
              if (quantity <= 0) ...[
                _buildAddToCartButton(),
              ] else ...[
                _buildSpinnerButton(),
              ],
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

  Widget _buildAddToCartButton() {
    return Container(
      margin: EdgeInsets.only(
        top: screenSize.height * 0.05,
        bottom: screenSize.height * 0.05,
      ),
      child: TextButton(
        onPressed: onAddToCart,
        style: TextButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            fixedSize: Size(
              screenSize.width * 0.8,
              screenSize.height * 0.1,
            )),
        child: CustomText(
          text: "Add To Cart",
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildSpinnerButton() {
    return Container(
      margin: EdgeInsets.only(
        top: screenSize.height * 0.05,
        bottom: screenSize.height * 0.05,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              if (onDecrement != null) {
                onDecrement!(quantity-1);
              }
            },
            iconSize: 40,
            icon: Icon(
              Icons.remove,
            ),
          ),
          SizedBox(
            width: screenSize.width * 0.35,
            child: CustomText(
              text: "${quantity}",
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: () {
              if (onIncrement != null) {
                onIncrement!(quantity+1);
              }
            },
            iconSize: 40,
            icon: Icon(
              Icons.add_circle_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
