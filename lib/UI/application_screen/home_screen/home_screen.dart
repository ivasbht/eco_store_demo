import 'package:eco_store_demo/UI/widgets_collection/custom_drawer/custom_drawer.dart';
import 'package:eco_store_demo/UI/widgets_collection/custom_text/custom_text.dart';
import 'package:eco_store_demo/UI/widgets_collection/custom_textfield_widget/custom_textfield_widget.dart';
import 'package:eco_store_demo/UI/widgets_collection/mixins/size_mixin/size_mixin.dart';
import 'package:eco_store_demo/const_files/app_routes/app_routes.dart';
import 'package:eco_store_demo/store/home_page_store/home_page_bloc/home_page_bloc.dart';
import 'package:eco_store_demo/store/home_page_store/home_page_state/home_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SizeMixin {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initializaSize(context);
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
            onPressed: () {},
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
            _buildSearchBar(),
            _buildProductList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar({
    TextEditingController? searchController,
  }) {
    return Container(
      width: screenWidth * 0.9,
      child: CustomTextfieldWidget(
        controller: searchController,
        fillColor: Colors.blueAccent.shade100,
        filled: true,
        hintText: "Search Your Item Here....",
        hintStyle: TextStyle(color: Colors.white54),
        style: TextStyle(color: Colors.white),
        suffixIcon: Icon(
          Icons.search,
          size: 30,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }

  Widget _buildProductList() {
    return Container(
      margin: EdgeInsets.only(
        top: screenHeight * 0.05,
      ),
      child: BlocProvider(
        create: (context) => HomePageBloc(),
        child: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (ctxt, state) {
            if (state == HomePageState.initializing) {
              return _buildTextMessage(message: 'initialize');
            } else if (state == HomePageState.loading) {
              return _buildTextMessage(message: 'loading');
            } else if (state == HomePageState.completed) {
              return _buildTextMessage(message: 'result');
            } else {
              return _buildTextMessage(message: 'Error');
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
      ),
    );
  }
}