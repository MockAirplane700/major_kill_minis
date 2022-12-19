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
          if (snapshot.data['cart items'] != null) {
            List list = snapshot.data['cart items'];
            double total = 0.0;
            for(var element in list) {
              total += double.parse(element['price'].toString());
            }//end for loop

            return snapshot.data['cart items'].length > 0
                ? Column(
              children: <Widget>[
                /// The [checkoutListBuilder] has to be fixed
                /// in an expanded widget to ensure it
                /// doesn't occupy the whole screen and leaves
                /// room for the the RaisedButton
                Expanded(child: checkoutListBuilder(snapshot)),
                // here we calculate the total
                const Divider(),
                Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height/80), child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Text('Total (Before any tax or delivery):' , style: TextStyle(color: textColor),)),
                    Text('CAD\$${total.toString()}0' , style: const TextStyle(color: textColor),)
                  ],
                ),),
                ElevatedButton(
                  onPressed: () {
                    // add to log in history and clear the cart
                    List list = snapshot.data['cart items'];
                    MajorMiniLogic.setOrderHistory(list);

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Items have been added to history. Thank you :)')));
                    bloc.clearCart();
                  },
                  child: const Text("Checkout"),
                ),
                const SizedBox(height: 40)
              ],
            )
                : const Center(child: Text("You haven't taken any item yet"));
          }else{
            return const Center(child: Text("You haven't taken any item yet"));
          }
        },
      ),
      drawer: const CustomDrawer(),
    );
  }
}