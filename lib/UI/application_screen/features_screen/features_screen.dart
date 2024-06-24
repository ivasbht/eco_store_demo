import 'package:eco_store_demo/UI/widgets_collection/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class FeaturesScreen extends StatefulWidget {
  const FeaturesScreen({super.key});

  @override
  State<FeaturesScreen> createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Features",
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 30,
          bottom: 30,
        ),
        child: SingleChildScrollView(
          child: CustomText(
            text: "$features",
          ),
        ),
      ),
    );
  }
}

const String features = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed risus mauris, gravida vitae consequat vel, lobortis in quam. Suspendisse potenti. Suspendisse potenti. Aliquam a turpis eu turpis ullamcorper sagittis nec sed ex. In feugiat sollicitudin aliquam. Etiam nec malesuada ante, et convallis risus. Nulla elementum convallis justo vitae porttitor.

Donec hendrerit sit amet sem ac venenatis. Praesent condimentum elit eget mauris egestas, et cursus tellus efficitur. Proin posuere tellus vel libero imperdiet volutpat. Quisque volutpat tortor a mauris pretium porta. Aliquam vel bibendum neque. Sed vel enim in leo vestibulum commodo. In hendrerit justo in tempor cursus.

Suspendisse vulputate mauris feugiat justo congue fermentum. Nulla ante ligula, condimentum sed faucibus venenatis, malesuada ac magna. Curabitur tempor ex sit amet fringilla viverra. Curabitur eu bibendum risus. Nunc rutrum facilisis rutrum. Duis vestibulum eu justo eu vulputate. Integer condimentum luctus augue sed congue. Fusce eu porttitor justo. Phasellus imperdiet mauris quis ligula interdum posuere. Mauris pellentesque arcu vel varius lacinia.

Nam consequat dignissim velit, eu vehicula purus volutpat in. Phasellus et arcu tortor. Etiam venenatis, ex in consectetur fermentum, nisl sapien porttitor ex, ac porttitor purus felis vitae tellus. Maecenas commodo gravida ligula, et molestie neque tincidunt et. Donec eleifend leo id turpis fringilla tempor. Vivamus vel est gravida, commodo lorem vel, ornare neque. Nam id erat in tortor hendrerit pulvinar. Nullam ac quam ligula. Curabitur cursus venenatis gravida.

Phasellus venenatis diam ut lacinia mattis. Proin vel hendrerit erat. Nunc nec magna viverra, rhoncus nunc at, tincidunt magna. Aenean tempor, turpis sit amet imperdiet semper, libero metus ullamcorper sapien, nec fringilla enim ligula a quam. Mauris et luctus leo. In gravida augue ut velit rhoncus ornare. Cras et erat iaculis, bibendum massa nec, dictum urna. Nam at sem commodo, laoreet velit ultricies, auctor nibh. Praesent hendrerit sodales ante vitae mollis. Etiam tempus consequat blandit. Sed sed malesuada ex, sit amet tempor justo. Nam nec tempor orci, ac elementum augue. Fusce auctor pretium libero ut volutpat. Integer ut blandit magna. Nam quis interdum neque.
""";
