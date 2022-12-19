import 'package:flutter/material.dart';
import 'package:major_kill_minis/constants/variables.dart';
import 'package:major_kill_minis/logic/history_logic.dart';
import 'package:major_kill_minis/objects/major_mini.dart';
import 'package:major_kill_minis/pages/view_mini.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {

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
      body: Padding(padding: EdgeInsets.all(height/80) , child: FutureBuilder(
          builder: (context , snapshot) {
            if (snapshot.hasData) {
              List list = snapshot.data as List;

              return ListView.builder(
                itemBuilder: (context , index) {
                  if (list.isEmpty) {
                    return const Center(child: Text('There is no history yet', style: TextStyle(color: textColor),),);
                  }else{
                    return Card(
                      elevation: 8,
                      color: cardBackgroundColor,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width/50)),
                      child: ListTile(
                        leading: Image.network(list[index].networkImage),
                        title: Text(list[index].name , style: const TextStyle(color: textColor),),
                        subtitle: Text('CAD\$${list[index].price.toString()}0', style: const TextStyle(color: textColor, fontWeight: FontWeight.bold),),
                        trailing: Text(list[index].quantity.toString(), style: const TextStyle(color: textColor, fontSize: 15),),
                      ),
                    );
                  }//end if-else
                },
                itemCount: list.length,
              );
            }else{
              return const Center(child: CircularProgressIndicator(),);
            }//end if-else
          },
        future: HistoryLogic.getHistory(),
      ),),
    );
  }
}
