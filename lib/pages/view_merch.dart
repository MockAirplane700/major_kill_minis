import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:major_kill_minis/constants/variables.dart';
import 'package:major_kill_minis/logic/bloc/cart_items_bloc.dart';
import 'package:major_kill_minis/objects/merch.dart';
import 'package:major_kill_minis/widgets/custom_search_delegate_merchandise.dart';
import 'package:share_plus/share_plus.dart';

class ViewMerch extends StatefulWidget {
  final Merch merch;

  const ViewMerch({Key? key , required this.merch}) : super(key: key);

  @override
  State<ViewMerch> createState() => _ViewMerchState();
}

class _ViewMerchState extends State<ViewMerch> {
  int quantity = 1;
  String size = 'small';
  Color selectedColor = Colors.grey;
  Color smallColor = Colors.white;
  Color mediumColor = Colors.white;
  Color largeColor = Colors.white;
  Color extraLargeColor = Colors.white;
  Color twoLargerColor = Colors.white;
  Color threeLargeColor = Colors.white;

  void _increment(){
    setState(() {
      quantity++;
    });
  }

  void _decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void _colorManager(){
    int count = 0;
    for (var color in sizesBackgroundColors){
      if (color == Colors.pinkAccent){
        setState(() {
          sizesBackgroundColors.removeAt(count);
          sizesBackgroundColors.insert(count, Colors.white);
        });
      }
      count++;
    }//end for loop
  }

  void _selectedColor(int index){
    _colorManager();
    setState(() {
      //search for pink accent and replace it first
      sizesBackgroundColors.removeAt(index);
      sizesBackgroundColors.insert(index, Colors.pinkAccent);
    });
  }

  void _setSize(String string) {
    setState(() {
      size = string;
    });
  }

   List<Color> sizesBackgroundColors = [
    // small
    Colors.white,
    // medium
     Colors.white,
    // large
     Colors.white,
    // extra large
     Colors.white,
    // two extra large
     Colors.white,
    // three extra large
     Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List sizes = widget.merch.size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MajorKill Merchandise' , style: TextStyle(color: textColor),),
        backgroundColor: appBarColor,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MySearchDelegateMerch());
              },
              icon: const Icon(Icons.search)
          )
        ],
        iconTheme: const IconThemeData(color: iconThemeDataColor),
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image of the product
          CarouselSlider.builder(
              itemCount: widget.merch.images.length,
              itemBuilder: (context , itemIndex, pageViewIndex) {
                return Image.network(widget.merch.images[itemIndex]);
              },
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true
              )
          ),
          // Name of the product
          Padding(
            padding: EdgeInsets.all(height/80),
            child: Row(
              children: [
                Expanded(child: Text(widget.merch.name , style: const TextStyle(color: textColor),)),
                Expanded(child: IconButton(onPressed: () {
                  //share
                  Share.share(widget.merch.link);
                }, icon: const Icon(Icons.share))),
              ],
            ),
          ),
          // Share product => in a row next to name
          // price
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(width/90, 0, 0, height/90),
                child: Text('CAD\$${widget.merch.price.toString()}0' , style: const TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),),
              ),
            ],
          ),
          // description
          Card(
            shadowColor: shadowColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width/90)),
            elevation: 8,
            child: Padding(padding: EdgeInsets.all(width/40), child: Text(widget.merch.description , style: const TextStyle(color: textColor ),),),
          ),
          // Size => Row of circles you can select
          SizedBox(
            width: width,
            height: height/8,
            child: ListView.builder(
              itemBuilder: (context , index) {
                return GestureDetector(
                  onTap: () {
                    _selectedColor(index);
                    if (index == 0) {
                      //small
                      _setSize('small');
                    }

                    if (index == 1) {
                      //medium
                      _setSize('medium');
                    }

                    if (index == 2) {
                      //large
                      _setSize('large');
                    }

                    if (index == 3) {
                      //XL
                      _setSize('XL');
                    }

                    if (index == 4) {
                      //2XL
                      _setSize('2XL');
                    }

                    if (index == 5){
                      //3XL
                      _setSize('3XL');
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: sizesBackgroundColors[index],
                    radius: height/20,
                    child: Text(sizes[index] , style:const TextStyle(color: textColor, fontSize: 25, fontWeight: FontWeight.bold),),
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: sizes.length,
            ),
          ),
          // quantity
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: _increment, icon: const Icon(Icons.add)),
              Text(quantity.toString()),
              IconButton(onPressed: _decrement, icon: const Icon(Icons.remove))
            ],
          ),
          // add to cart
          GestureDetector(
            onTap: (){
              // add to cart
              double total = widget.merch.price * quantity;
              bloc.addToCart({
                'name':widget.merch.name,
                'price':total,
                'description' : widget.merch.description,
                'image' : widget.merch.images[0],
                'size' : size,
                'link': widget.merch.link,
                'quantity' : quantity
              });
              //notify the user
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${widget.merch.name} has been added to cart')));
            },
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width/5)),
              elevation: 10,
              shadowColor: shadowColor,
              color: Colors.white10,
              child: SizedBox(
                width: width,
                height: height/20,
                child: const Center(child: Text('Add to cart' , style: TextStyle(color: textColor),),),
              ),
            ),
          )
        ],
      ),),
    );
  }
}
