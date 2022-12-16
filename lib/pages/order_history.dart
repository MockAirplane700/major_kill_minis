import 'package:flutter/material.dart';
import 'package:major_kill_minis/constants/variables.dart';
import 'package:major_kill_minis/objects/major_mini.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  List<MajorMini> minis = [];

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order history' , style: TextStyle(color: textColor),),
        backgroundColor: appBarColor,
        iconTheme: const IconThemeData(color: iconThemeDataColor),
      ),
      backgroundColor: backgroundColor,
      body: Padding(padding: EdgeInsets.all(height/80) , child: ListView.builder(
          itemBuilder: (context , index) {
            return Card(
              elevation: 8,
              color: cardBackgroundColor,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width/50)),
              child: ListTile(
                leading: Image.network(minis[index].image),
                title: Text(minis[index].name , style: const TextStyle(color: textColor),),
                subtitle: Text(minis[index].price.toString(), style: const TextStyle(color: textColor, fontWeight: FontWeight.bold),),
                trailing: const Icon(Icons.more_vert),
              ),
            );
          }
      ),),
    );
  }
}
