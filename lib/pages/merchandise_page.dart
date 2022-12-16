import 'package:flutter/material.dart';
import 'package:major_kill_minis/constants/variables.dart';
import 'package:major_kill_minis/logic/major_minis_logic.dart';
import 'package:major_kill_minis/objects/merch.dart';
import 'package:major_kill_minis/pages/view_merch.dart';
import 'package:major_kill_minis/widgets/custom_navigation_drawer.dart';
import 'package:major_kill_minis/widgets/custom_search_delegate_merchandise.dart';

class MerchandisePage extends StatefulWidget {
  const MerchandisePage({Key? key}) : super(key: key);

  @override
  State<MerchandisePage> createState() => _MerchandisePageState();
}

class _MerchandisePageState extends State<MerchandisePage> {
  List<Merch> merch = [
    Merch(
        name: '400K Hoodie',
        description: 'Celebrating the milestone achievement of reaching 400,000 YouTube subscribers, MajorKill has released exactly 400 premium black hoodies that include a screen printed hand written message to his loyal followers as well as a unique number printed on the sleeve.\n\nDon\'t miss out on this super limited piece and see what Major would like to share with you!\n\nProduct Specs:\n\nRegular fit, pullover hood\nMid-weight, 290 GSM\n80% cotton 20% polyester anti-pill fleece\nRaglan sleeves, kangaroo pocket, lined hood, tonal drawcord, sleeve cuff ribbing, preshunk to minimise to minimise shrinkage\nScreen printed exclusive MajorKill design\nUnique screen printed number on sleeve (#1 of 400)\nDetailed 400k sleeve print\nScreen printed hand written message from MajorKill himself',
        size: [
          'S', 'M' , 'L' , 'XL', '2XL' , '3XL'
        ], link: 'https://www.majorkill.shop/products/400k-black-hoodie',
        images: [
          'https://cdn.shopify.com/s/files/1/0559/3723/7127/products/400KBLACKHOODIEFINAL.png?v=1666934738&width=600',
          'https://cdn.shopify.com/s/files/1/0559/3723/7127/products/p9.jpg?v=1669938515',
          'https://cdn.shopify.com/s/files/1/0559/3723/7127/products/400KBLACKHOODIEBACKFINAL.png?v=1669938515'
        ],
        price: 75.00
    ),
    Merch(
        name: '400K Hoodie',
        description: 'Celebrating the milestone achievement of reaching 400,000 YouTube subscribers, MajorKill has released exactly 400 premium black hoodies that include a screen printed hand written message to his loyal followers as well as a unique number printed on the sleeve.\n\nDon\'t miss out on this super limited piece and see what Major would like to share with you!\n\nProduct Specs:\n\nRegular fit, pullover hood\nMid-weight, 290 GSM\n80% cotton 20% polyester anti-pill fleece\nRaglan sleeves, kangaroo pocket, lined hood, tonal drawcord, sleeve cuff ribbing, preshunk to minimise to minimise shrinkage\nScreen printed exclusive MajorKill design\nUnique screen printed number on sleeve (#1 of 400)\nDetailed 400k sleeve print\nScreen printed hand written message from MajorKill himself',
        size: [
          'S', 'M' , 'L' , 'XL', '2XL' , '3XL'
        ], link: 'https://www.majorkill.shop/products/400k-black-hoodie',
        images: [
          'https://cdn.shopify.com/s/files/1/0559/3723/7127/products/400KBLACKHOODIEFINAL.png?v=1666934738&width=600',
          'https://cdn.shopify.com/s/files/1/0559/3723/7127/products/p9.jpg?v=1669938515',
          'https://cdn.shopify.com/s/files/1/0559/3723/7127/products/400KBLACKHOODIEBACKFINAL.png?v=1669938515'
        ],
        price: 75.00
    ),
    Merch(
        name: '400K Hoodie',
        description: 'Celebrating the milestone achievement of reaching 400,000 YouTube subscribers, MajorKill has released exactly 400 premium black hoodies that include a screen printed hand written message to his loyal followers as well as a unique number printed on the sleeve.\n\nDon\'t miss out on this super limited piece and see what Major would like to share with you!\n\nProduct Specs:\n\nRegular fit, pullover hood\nMid-weight, 290 GSM\n80% cotton 20% polyester anti-pill fleece\nRaglan sleeves, kangaroo pocket, lined hood, tonal drawcord, sleeve cuff ribbing, preshunk to minimise to minimise shrinkage\nScreen printed exclusive MajorKill design\nUnique screen printed number on sleeve (#1 of 400)\nDetailed 400k sleeve print\nScreen printed hand written message from MajorKill himself',
        size: [
          'S', 'M' , 'L' , 'XL', '2XL' , '3XL'
        ], link: 'https://www.majorkill.shop/products/400k-black-hoodie',
        images: [
          'https://cdn.shopify.com/s/files/1/0559/3723/7127/products/400KBLACKHOODIEFINAL.png?v=1666934738&width=600',
          'https://cdn.shopify.com/s/files/1/0559/3723/7127/products/p9.jpg?v=1669938515',
          'https://cdn.shopify.com/s/files/1/0559/3723/7127/products/400KBLACKHOODIEBACKFINAL.png?v=1669938515'
        ],
        price: 75.00
    ),
  ];

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    MajorMiniLogic.setSearchMerch(merch);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Merchandise Page', style: TextStyle(color: textColor),),
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
      drawer: const CustomDrawer(),
      body: Padding(padding: EdgeInsets.all(height/80), child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context , index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewMerch(merch: merch[index])));
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width/80)),
                elevation: 8,
                shadowColor: shadowColor,
                color: cardBackgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Image
                    Expanded(child: Image.network(merch[index].images[0])),
                    //name
                    Padding(
                      padding: EdgeInsets.all(height/80),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(merch[index].name , style: const TextStyle(color: textColor,)),
                            ],
                          ),
                          //cost
                          Row(
                            children: [
                              Text('\$CAD${merch[index].price.toString()}0' , style: const TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        itemCount: merch.length,
      ),),
    );
  }
}
