import 'package:eco_store_demo/UI/widgets_collection/cart_prod_element/cart_prod_element.dart';
import 'package:eco_store_demo/UI/widgets_collection/custom_text/custom_text.dart';
import 'package:eco_store_demo/UI/widgets_collection/mixins/size_mixin/size_mixin.dart';
import 'package:eco_store_demo/model/product_model/product_model.dart';
import 'package:eco_store_demo/services/app_service/app_service.dart';
import 'package:eco_store_demo/store/cart_page_bloc/cart_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with SizeMixin {
  final appServices = AppServices();
  late CartPageBloc _cartPageBloc;

  @override
  void initState() {
    _callCartApi();
    super.initState();
  }

  void _callCartApi() {
    _cartPageBloc = CartPageBloc(service: appServices)
      ..add(CartApiCallEvent(() {
        _cartPageBloc..add(CartProductApiCallEvent());
      }));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initializaSize(context);
  }

  @override
  void dispose() {
    _cartPageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: CustomText(
          text: "Cart Page",
          color: Colors.white,
        ),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              _callCartApi();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(
          top: screenHeight * 0.025,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // _buildSearchBar(),
            _buildCartComponent(),
          ],
        ),
      ),
    );
  }

  Widget _buildCartComponent() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          top: screenHeight * 0.05,
        ),
        child: BlocBuilder<CartPageBloc, CartPageState>(
          bloc: _cartPageBloc,
          builder: (ctxt, state) {
            if (state.status == CartStatus.initializing) {
              return _buildTextMessage(message: 'Initialize Cart');
            } else if (state.status == CartStatus.loading) {
              return _buildTextMessage(message: 'Loading Cart');
            } else if (state.status == CartStatus.completed) {
              return _buildCartProdBloc(state);
            } else {
              return _buildTextMessage(
                  message: 'Error In Cart \n\n${state.error}');
            }
          },
        ),
      ),
    );
  }

  Widget _buildTextMessage({String message = "Message"}) {
    return Center(
      child: CustomText(
        text: "$message",
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCartProdBloc(CartPageState cartState) {
    return BlocBuilder<CartPageBloc, CartPageState>(
      bloc: _cartPageBloc,
      builder: (ctxt, state) {
        if (state.cartProdStatus == CartProductStatus.initializing) {
          return _buildTextMessage(message: 'Initializing Product');
        } else if (state.cartProdStatus == CartProductStatus.loading) {
          return _buildTextMessage(message: 'Loading Product');
        } else if (state.cartProdStatus == CartProductStatus.completed) {
          return _buildCartProductList();
        } else {
          return _buildTextMessage(
              message: 'Error In Product\n\n${state.error}');
        }
      },
    );
  }

  Widget _buildCartProductList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ..._cartPageBloc.cartDetails.map((cart) {
            return _buildProductSpreader(cart.products);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildProductSpreader(List<ProductModel> products) {
    return Column(
      children: [
        ...products.map((product) {
          return CartProdElement(
            screenSize: screenSize,
            model: product,
            onPressProduct: () {},
            onRemoveProduct: () {
              print("removingCart");
              _cartPageBloc.add(CartRemoveEvent(product.cartId, () {
                _callCartApi();
              }));
            },
          );
        }),
      ],
    );
  }

  // Widget _buildSearchBar({
  //   TextEditingController? searchController,
  // }) {
  //   return Container(
  //     width: screenWidth * 0.9,
  //     child: CustomTextfieldWidget(
  //       controller: searchController,
  //       fillColor: Colors.blueAccent.shade100,
  //       filled: true,
  //       hintText: "Search Your Cart Item Here....",
  //       hintStyle: TextStyle(color: Colors.white54),
  //       style: TextStyle(color: Colors.white),
  //       suffixIcon: Icon(
  //         Icons.search,
  //         size: 30,
  //       ),
  //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
  //     ),
  //   );
  // }
}
