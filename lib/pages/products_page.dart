import 'package:flutter/material.dart';
import 'package:major_kill_minis/constants/variables.dart';
import 'package:major_kill_minis/logic/bloc/cart_items_bloc.dart';
import 'package:major_kill_minis/logic/cart_provider.dart';
import 'package:major_kill_minis/logic/major_minis_logic.dart';
import 'package:major_kill_minis/objects/cart.dart';
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
    MajorMiniLogic.setSearchCollection(widget.products);

    return ListView.builder(
      itemCount: widget.products.length,
      shrinkWrap: true,
      padding:const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      itemBuilder: (context , index) {
        return Card(
          color: cardBackgroundColor,
          elevation: 5.0,
          child: Padding(padding: const EdgeInsets.all(4.0), child: SizedBox(
            height: height/1.9,
            width: width/2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(flex: 3, child: Image(image: NetworkImage(widget.products[index].image),),),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5,),
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          text: TextSpan(
                              text: 'Name: ',
                              style: TextStyle(
                                  color: Colors.blueGrey.shade800,
                                  fontSize: 16.0),
                              children: [
                                TextSpan(
                                    text:
                                    '${widget.products[index].name.toString()}\n',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ),
                        RichText(
                          maxLines: 1,
                          text: TextSpan(
                              text: 'Size: ',
                              style: TextStyle(
                                  color: Colors.blueGrey.shade800,
                                  fontSize: 16.0),
                              children: [
                                TextSpan(
                                    text:
                                    '${widget.products[index].size}\n',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ),
                        RichText(
                          maxLines: 1,
                          text: TextSpan(
                              text: 'Price: ' r"$",
                              style: TextStyle(
                                  color: Colors.blueGrey.shade800,
                                  fontSize: 16.0),
                              children: [
                                TextSpan(
                                    text:
                                    '${widget.products[index].price.toString()}\n',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: ElevatedButton(
                        onPressed: () {
                          // go to the view minis page
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewMini(mini: widget.products[index])));
                        }, child: const Text('View model')
                    ))
                  ],
                ),),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            // saveData(index);
                            bloc.addToCart({
                              'name':widget.products[index].name,
                              'price':widget.products[index].price,
                              'image' : widget.products[index].image,
                              'base' : widget.products[index].base,
                              'link': widget.products[index].link,
                              'quantity' : 1
                            });
                          },
                          child: const Text('add to cart')
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
        );
      },
    );
  }
}
