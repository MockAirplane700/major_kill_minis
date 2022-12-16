import 'package:flutter/material.dart';
import 'package:major_kill_minis/constants/variables.dart';
import 'package:major_kill_minis/objects/merch.dart';
import 'package:major_kill_minis/widgets/custom_search_delegate_merchandise.dart';

class ViewMerch extends StatefulWidget {
  final Merch merch;

  const ViewMerch({Key? key , required this.merch}) : super(key: key);

  @override
  State<ViewMerch> createState() => _ViewMerchState();
}

class _ViewMerchState extends State<ViewMerch> {
  int quantity = 1;
  final Color _selectedColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List sizes = widget.merch.size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Merch'),
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
          Image.network(widget.merch.images[0]),
          // Name of the product
          Padding(
            padding: EdgeInsets.all(height/80),
            child: Row(
              children: [
                Expanded(child: Text(widget.merch.name , style: const TextStyle(color: textColor),)),
                Expanded(child: IconButton(onPressed: () {
                  //share
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
            child: Padding(padding: EdgeInsets.all(width/50), child: Text(widget.merch.description , style: const TextStyle(color: textColor ),),),
          ),
          // Size => Row of circles you can select
          SizedBox(
            width: width,
            height: height/8,
            child: ListView.builder(
              itemBuilder: (context , index) {
                return GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: backgroundColor,
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
              IconButton(onPressed: (){

              }, icon: const Icon(Icons.add)),
              Text(quantity.toString()),
              IconButton(onPressed: (){

              }, icon: const Icon(Icons.remove))
            ],
          ),
          // add to cart
          GestureDetector(
            onTap: (){
              // add to cart
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
