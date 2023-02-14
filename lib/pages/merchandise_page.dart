import 'package:flutter/material.dart';
import 'package:major_kill_minis/constants/variables.dart';
import 'package:major_kill_minis/logic/major_minis_logic.dart';
import 'package:major_kill_minis/logic/merchandise_logic.dart';
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


  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('', style: TextStyle(color: textColor),),
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
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData){
            List merchandise = snapshot.data as List<dynamic>;
            MajorMiniLogic.setSearchMerch(merchandise);
            return Padding(padding: EdgeInsets.all(height/80), child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context , index) {
                Merch merch = Merch.fromJson(merchandise[index]);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewMerch(merch: merch)));
                  },
                  child: Card(
                    elevation: 0,
                    shadowColor: shadowColor,
                    color: cardBackgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Image
                        Expanded(child: Image.network(merch.images[0])),
                        //name
                        Padding(
                          padding: EdgeInsets.all(height/80),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(child:Text(merch.name , style: const TextStyle(color: textColor,fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                              //cost
                              Row(
                                children: [
                                  Text('\$CAD${merch.price.toStringAsFixed(2)}' , style: const TextStyle(color: textColor, fontStyle: FontStyle.italic, fontSize: 12),),
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
              itemCount: merchandise.length,
            ),);
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
        future: MerchandiseLogic.getMerchandise(),),
    );
  }
}
