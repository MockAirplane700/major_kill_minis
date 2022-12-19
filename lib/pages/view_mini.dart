import 'package:flutter/material.dart';
import 'package:major_kill_minis/constants/variables.dart';
import 'package:major_kill_minis/logic/bloc/cart_items_bloc.dart';
import 'package:major_kill_minis/objects/major_mini.dart';
import 'package:share_plus/share_plus.dart';

class ViewMini extends StatefulWidget {
  final MajorMini mini;

  const ViewMini({Key? key, required this.mini}) : super(key: key);

  @override
  State<ViewMini> createState() => _ViewMiniState();
}

class _ViewMiniState extends State<ViewMini> {
  int quantity = 1;

  void _increment() {
    setState(() {
      quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('View mini' ,style: TextStyle(color: textColor),),
        iconTheme: const IconThemeData(color: iconThemeDataColor),
        backgroundColor: appBarColor,
      ),
      backgroundColor: backgroundColor,
      body: Center(child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image of the mini, or images
            Image.network(widget.mini.image),
            //price
            Padding(
              padding:  EdgeInsets.all(height/80),
              child: Row(
                children: [
                  Text('CAD\$${widget.mini.price}0', style: const TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),)
                ],
              ),
            ),
            // Description
            Card(
                shadowColor: shadowColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height/50)),
                elevation: 5,
                child: Padding(
                  padding:  EdgeInsets.all(width/50),
                  child: Text(widget.mini.description, style: const TextStyle(color: textColor),),
                )),
            // size
            SizedBox(height: height/100,),
            Row(
              children:  [
                SizedBox(width: width/50,),
                const Text('Size' , style: TextStyle(color: textColor, fontSize: 25),),
              ],
            ),
            const Divider(),
            Padding(
              padding:  EdgeInsets.all(height/80),
              child: Text(widget.mini.size),
            ),
            // base
            Row(
              children: [
                SizedBox(width: width/50,),
                const Text('Base' , style: TextStyle(color: textColor, fontSize: 25),),
              ],
            ),
            const Divider(),
            Padding(
              padding:  EdgeInsets.all(height/80),
              child: Text(widget.mini.base),
            ),
            // recommended proxy
            Row(
              children: [
                SizedBox(width: width/50,),
                const Text('Recommended proxy' , style: TextStyle(color: textColor, fontSize: 25),),
              ],
            ),
            const Divider(),
            Padding(
              padding:  EdgeInsets.all(height/80),
              child: Text(widget.mini.recommendedProxy),
            ),
            // share -> share the webpage
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: (){
                      // share the link to the web page
                      Share.share(widget.mini.link);
                    },
                    icon: const Icon(Icons.share)
                )
              ],
            ),
            // quantity
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: _increment, icon: const Icon(Icons.add)
                ),
                Text(quantity.toString()),
                IconButton(
                    onPressed: _decrement, icon: const Icon(Icons.remove)
                )
              ],
            ),
            // add to cart
            Row(
              children: [
                Expanded(child: ElevatedButton(
                    onPressed: () {
                      // calculate total of new price based of quantity
                      double resultPrice = widget.mini.price * quantity;
                      bloc.addToCart({
                        'name':widget.mini.name,
                        'description' : widget.mini.description,
                        'price': resultPrice.toString(),
                        'image' : widget.mini.image,
                        'base' : widget.mini.base,
                        'link': widget.mini.link,
                        'quantity' : quantity
                      });

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${widget.mini.name} has been added to cart')));

                    }, child: const Text('Add to cart', style: TextStyle(color: textColor),)
                ))
              ],
            )
          ],
        ),
      ),),
    );
  }
}
