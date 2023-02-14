import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:major_kill_minis/constants/variables.dart';
import 'package:major_kill_minis/logic/bloc/cart_items_bloc.dart';
import 'package:major_kill_minis/logic/cart_provider.dart';
import 'package:major_kill_minis/logic/major_minis_logic.dart';
import 'package:major_kill_minis/objects/cart.dart';
import 'package:major_kill_minis/objects/major_mini.dart';
import 'package:major_kill_minis/pages/view_mini.dart';
import 'package:major_kill_minis/persistence/db_helper.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
 final List products;
  const ProductsPage({Key? key, required this.products}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  DbHelper dbHelper = DbHelper();


  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<CartProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List list = widget.products;
    MajorMiniLogic.setSearchCollection(list);

    // todo: Make into a 2 by 2 grid making the mini image a bigger, consider making it a carasoul no auto scroll
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index){
        MajorMini _mini = MajorMini.fromJson(list[index]);
        return Card(
          shadowColor: shadowColor,
          elevation: 0,
          color: cardBackgroundColor,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewMini(mini: _mini)));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image slider, no auto play
                Expanded(
                  child: CarouselSlider(
                      items: List.generate(_mini.image.length, (index) => Image.network(_mini.image[index])),
                      options: CarouselOptions(
                        height: height/2,
                        enlargeCenterPage: true,
                        viewportFraction: 1.0,


                      )
                  ),
                ),
                const Divider(),
                // Name of the mini
                Text(_mini.name , style: const TextStyle(color: textColor, fontWeight: FontWeight.bold),),
                // Price of the mini
                Row(
                  children: [
                    Text('AUD\$${_mini.price.toStringAsFixed(2)}' , style: const TextStyle(color: textColor, fontStyle: FontStyle.italic, fontSize: 12),),
                  ],
                )
              ],
            ),
          ),
        );
      },
      itemCount: list.length,);
  }
}
