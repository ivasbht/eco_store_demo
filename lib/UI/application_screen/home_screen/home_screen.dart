import 'package:eco_store_demo/UI/widgets_collection/custom_text/custom_text.dart';
import 'package:eco_store_demo/UI/widgets_collection/custom_textfield_widget/custom_textfield_widget.dart';
import 'package:eco_store_demo/UI/widgets_collection/mixins/size_mixin/size_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        style:TextStyle(color: Colors.white),
        suffixIcon: Icon(
          Icons.search,
          size: 30,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
