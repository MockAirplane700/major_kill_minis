import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:major_kill_minis/constants/functions.dart';
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

    List images = widget.mini.image;

    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.mini.name ,style: const TextStyle(color: textColor),),
        iconTheme: const IconThemeData(color: iconThemeDataColor),
        backgroundColor: appBarColor,
        actions: [
          IconButton(onPressed: (){
            Share.share(widget.mini.link[0]);
          }, icon: const Icon(Icons.share))
        ],
      ),
      backgroundColor: backgroundColor,
      body: Center(child: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image of the mini, or images
              Expanded(
                flex: 2,
                child: CarouselSlider(
                    items: List.generate(images.length, (index) => GestureDetector(
                      onTap: () {
                        showDialog(context: context, builder: (context)=> AlertDialog(
                          backgroundColor: Colors.transparent,
                          content: Image.network(images[index], height: height,fit: BoxFit.cover,width: width,),
                        ));
                      },
                      child: Image.network(images[index]),
                    )),
                    options: CarouselOptions(
                      height: height/2,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      viewportFraction: 1.0,

                    )
                ),
              ),
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
                    child: Text(fixDescription(widget.mini.description), style: const TextStyle(color: textColor),),
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     IconButton(
              //         onPressed: (){
              //           // share the link to the web page
              //           Share.share(widget.mini.link);
              //         },
              //         icon: const Icon(Icons.share)
              //     )
              //   ],
              // ),
              // quantity
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     IconButton(
              //         onPressed: _increment, icon: const Icon(Icons.add)
              //     ),
              //     Text(quantity.toString()),
              //     IconButton(
              //         onPressed: _decrement, icon: const Icon(Icons.remove)
              //     )
              //   ],
              // ),
              // add to cart
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height/80)),
                elevation: 8,
                shadowColor: shadowColor,
                child: Row(
                  children: [
                    Expanded(child: ElevatedButton(
                        onPressed: () {
                          // calculate total of new price based of quantity
                          // double resultPrice = widget.mini.price * quantity;
                          // bloc.addToCart({
                          //   'name':widget.mini.name,
                          //   'description' : widget.mini.description,
                          //   'price': resultPrice.toString(),
                          //   'image' : widget.mini.image,
                          //   'base' : widget.mini.base,
                          //   'link': widget.mini.link,
                          //   'quantity' : quantity
                          // });

                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${widget.mini.name} has been added to cart')));
                          showDialog(context: context, builder: (context)=> AlertDialog(
                            title: const Text('Where to buy them.', style: TextStyle(color: textColor),),
                            scrollable: true,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height/80)),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Esty
                                Card(
                                  shadowColor: shadowColor,
                                  color: cardBackgroundColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height/80)),
                                  elevation: 8,
                                  child: ListTile(
                                    leading: Image.network(widget.mini.image[0],),
                                    title: Text(widget.mini.name, style: const TextStyle(color: textColor),),
                                    subtitle: Text(widget.mini.recommendedProxy, style: const TextStyle(color: textColor),),
                                    trailing: const Icon(FontAwesomeIcons.etsy, color: iconColor,),
                                    visualDensity: const VisualDensity(vertical: VisualDensity.maximumDensity),
                                    onTap: () {
                                      // link to mini , -> etsy
                                      launchWebSiteUrl(widget.mini.link[1]);
                                    },
                                  ),
                                ),
                                // Spotify
                                Card(
                                  shadowColor: shadowColor,
                                  color: cardBackgroundColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height/80)),
                                  elevation: 8,
                                  child: ListTile(
                                    leading: Image.network(widget.mini.image[0]),
                                    title: Text(widget.mini.name, style: const TextStyle(color: textColor),),
                                    subtitle: Text(widget.mini.recommendedProxy, style: const TextStyle(color: textColor),),
                                    trailing: const Icon(FontAwesomeIcons.shopify, color: iconColor,),
                                    visualDensity: const VisualDensity(vertical: VisualDensity.maximumDensity),
                                    onTap: () {
                                      // link to mini , -> etsy
                                      launchWebSiteUrl(widget.mini.link[1]);
                                    },
                                  ),
                                ),
                                // Major mini website
                                Card(
                                  shadowColor: shadowColor,
                                  color: cardBackgroundColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height/80)),
                                  elevation: 8,
                                  child: ListTile(
                                    leading: Image.network(widget.mini.image[0]),
                                    title: Text(widget.mini.name, style: const TextStyle(color: textColor),),
                                    subtitle: Text(widget.mini.recommendedProxy, style: const TextStyle(color: textColor),),
                                    trailing: const Icon(FontAwesomeIcons.globe, color: iconColor,),
                                    visualDensity: const VisualDensity(vertical: VisualDensity.maximumDensity),
                                    onTap: () {
                                      // link to mini , -> etsy
                                      launchWebSiteUrl(widget.mini.link[0]);
                                    },
                                  ),
                                ),
                              ],),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                        )
                        , child: const Text('Purchase', style: TextStyle(color: textColor),)
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),),
    );
  }
}
