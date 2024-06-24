import 'package:eco_store_demo/UI/widgets_collection/custom_drawer/custom_drawer.dart';
import 'package:eco_store_demo/UI/widgets_collection/custom_text/custom_text.dart';
import 'package:eco_store_demo/UI/widgets_collection/mixins/size_mixin/size_mixin.dart';
import 'package:eco_store_demo/UI/widgets_collection/product_detail_sheet/product_detail_sheet.dart';
import 'package:eco_store_demo/UI/widgets_collection/products_element/products_element.dart';
import 'package:eco_store_demo/const_files/app_routes/app_routes.dart';
import 'package:eco_store_demo/model/cart_model/cart_model.dart';
import 'package:eco_store_demo/model/product_model/product_model.dart';
import 'package:eco_store_demo/services/app_service/app_service.dart';
import 'package:eco_store_demo/store/cart_page_bloc/cart_page_bloc.dart';
import 'package:eco_store_demo/store/home_page_bloc/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SizeMixin {
  final AppServices appServices = AppServices();
  late HomePageBloc _homePageBloc;
  late CartPageBloc _cartPageBloc;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    initializaSize(context);
    _initializeHomeBloc();
    _initializeCartBloc();
    await appServices.openCartBox();
  }

  void _initializeHomeBloc() {
    _homePageBloc = HomePageBloc(service: appServices)
      ..add(HomeProductListCallEvent());
  }

  void _initializeCartBloc() {
    _cartPageBloc = CartPageBloc(service: appServices)
      ..add(CartApiCallEvent(() {}));
  }

  @override
  void dispose() {
    _homePageBloc.close();
    _cartPageBloc.close();
    // appServices.closeCart();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: CustomText(
          text: "Home Page",
          color: Colors.white,
        ),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.cart_screen);
            },
            icon: Icon(Icons.shopping_cart_outlined),
          )
        ],
      ),
      drawer: CustomDrawer(
        screenSize: screenSize,
        drawerList: [
          ListTile(
            title: CustomText(
              text: "About Us",
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.about_us_screen);
            },
          ),
          ListTile(
            title: CustomText(
              text: "Features",
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.features_screen);
            },
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
            _buildProductComponent(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductComponent() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          top: screenHeight * 0.05,
        ),
        child: BlocBuilder<HomePageBloc, HomePageState>(
          bloc: _homePageBloc,
          builder: (ctxt, state) {
            if (state.status == HomeStatus.initializing) {
              return _buildTextMessage(message: 'initialize');
            } else if (state.status == HomeStatus.loading) {
              return _buildTextMessage(message: 'loading');
            } else if (state.status == HomeStatus.completed) {
              return _buildProductList();
            } else {
              return _buildTextMessage(message: 'Error \n\n${state.error}');
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

  Widget _buildProductList() {
    final productsList = _homePageBloc.state.productModels ?? [];
    return SingleChildScrollView(
      child: Wrap(
        spacing: screenWidth * 0.035,
        runSpacing: screenHeight * 0.025,
        children: [
          ...productsList.map((product) {
            return ProductsElement(
              screenSize: screenSize,
              model: product,
              onPressProduct: () {
                _homePageBloc
                    .add(HomeProductDetailCallEvent(product.id.toString()));
                _showProductDetailSheet();
              },
            );
          }),
        ],
      ),
    );
  }

  void _showProductDetailSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return BlocBuilder<HomePageBloc, HomePageState>(
          bloc: _homePageBloc,
          builder: (context, prodState) {
            if (prodState.productStatus == ProductDetailStatus.initializing) {
              return _buildTextMessage(message: 'initialize');
            } else if (prodState.productStatus == ProductDetailStatus.loading) {
              return _buildTextMessage(message: 'loading');
            } else if (prodState.productStatus ==
                ProductDetailStatus.completed) {
              return _buildBlocForCartUpdate(prodState.productDetails!);
            } else {
              return _buildTextMessage(message: 'Error \n\n${prodState.error}');
            }
          },
        );
      },
    )..whenComplete(() {
        _homePageBloc.state.copyWith(
          productDetails: null,
          productStatus: ProductDetailStatus.initializing,
        );
      });
  }

  Widget _buildBlocForCartUpdate(ProductModel prod) {
    return BlocBuilder<CartPageBloc, CartPageState>(
      bloc: _cartPageBloc..add(CartApiCallEvent(() {})),
      builder: (context, cartState) {
        return _buildProductDetailScreen(prod, quantity: _getQuantity(prod));
      },
    );
  }

  Widget _buildProductDetailScreen(ProductModel prod, {int quantity = 0}) {
    return ProductDetailSheet(
      screenSize: screenSize,
      product: prod,
      quantity: quantity,
      onAddToCart: () {
        _updateCartBloc(prodId: prod.id.toString());
      },
      onIncrement: (quantity) {
        _updateCartBloc(
          prodId: prod.id.toString(),
          quantity:quantity,
        );
      },
      onDecrement: (quantity) {
        _updateCartBloc(
          prodId: prod.id.toString(),
          quantity:quantity,
        );
      },
    );
  }

  void _updateCartBloc({int quantity = 1, required String prodId}) {
    _cartPageBloc.add(
      CartAddUpdateEvent(
        CartModel(
          productId: prodId,
          quantity: quantity,
        ),
        () {
          _cartPageBloc.add(CartApiCallEvent(() {}));
        },
      ),
    );
  }

  int _getQuantity(ProductModel prod) {
    int quantity = 0;
    _cartPageBloc.cartDetails.forEach((cart) {
      if (prod.id.toString() == cart.productId.toString()) {
        quantity = int.tryParse(cart.quantity.toString()) ?? 0;
      }
    });
    return quantity;
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
  //       hintText: "Search Your Item Here....",
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
