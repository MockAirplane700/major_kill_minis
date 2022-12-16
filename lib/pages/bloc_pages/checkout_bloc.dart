import 'package:flutter/material.dart';
import 'package:major_kill_minis/constants/variables.dart';
import 'package:major_kill_minis/logic/bloc/cart_items_bloc.dart';
import 'package:major_kill_minis/logic/major_minis_logic.dart';
import 'package:major_kill_minis/widgets/custom_navigation_drawer.dart';
import 'package:major_kill_minis/widgets/custom_search_delegate.dart';

class CheckoutBloc extends StatelessWidget {
  const CheckoutBloc({super.key});


  Widget checkoutListBuilder(snapshot) {
    return ListView.builder(
      itemCount: snapshot.data["cart items"].length,
      itemBuilder: (BuildContext context, i) {
        final cartList = snapshot.data["cart items"];
        return Card(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          shadowColor: shadowColor,
          child: ListTile(
            leading: Image.network(cartList[i]['image']),
            title: Text(cartList[i]['name']),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    Text("CAD\$${cartList[i]['price']}0" , style: const TextStyle(color: textColor, fontSize: 14),),

                  ],
                ),
                Row(
                  children: [
                    Text('Quantity: ${cartList[i]['quantity'].toString()}', style: const TextStyle(color: textColor, fontWeight: FontWeight.bold),)

                  ],
                )
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.remove_shopping_cart , color: Colors.red,),
              onPressed: () {
                bloc.removeFromCart(cartList[i]);
              },
            ),
            onTap: () {
              //empty
            },
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout' , style: TextStyle(color: textColor),),
        backgroundColor: appBarColor,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
              icon: const Icon(Icons.search)
          )
        ],
        iconTheme: const IconThemeData(color: iconThemeDataColor),
      ),
      body: StreamBuilder(
        stream: bloc.getStream,
        initialData: bloc.allItems,
        builder: (context, snapshot) {
          return snapshot.data['cart items'].length > 0
              ? Column(
            children: <Widget>[
              /// The [checkoutListBuilder] has to be fixed
              /// in an expanded widget to ensure it
              /// doesn't occupy the whole screen and leaves
              /// room for the the RaisedButton
              Expanded(child: checkoutListBuilder(snapshot)),
              ElevatedButton(
                onPressed: () {
                  // add to log in history and clear the cart
                  List list = snapshot.data['cart items'];
                  MajorMiniLogic.setOrderHistory(list);
                },
                child: Text("Checkout"),
              ),
              SizedBox(height: 40)
            ],
          )
              : Center(child: Text("You haven't taken any item yet"));
        },
      ),
      drawer: const CustomDrawer(),
    );
  }
}