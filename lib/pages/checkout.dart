import 'package:flutter/material.dart';
import 'package:major_kill_minis/constants/variables.dart';
import 'package:major_kill_minis/logic/cart_provider.dart';
import 'package:major_kill_minis/objects/cart.dart';
import 'package:major_kill_minis/persistence/db_helper.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  DbHelper? dbHelper = DbHelper();
  List<bool> tapped = [];
  String displayValue = '';
  int displayNumber = 0;

  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout', style: TextStyle(color: textColor),),
        backgroundColor: appBarColor,
        iconTheme: const IconThemeData(color: iconThemeDataColor),
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartProvider>(
              builder: (BuildContext context, provider, widget) {
                if (provider.cart.isEmpty) {
                  return const Center(
                      child: Text(
                        'Your Cart is Empty',
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                      ));
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.cart.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.blueGrey.shade200,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image(
                                  height: 80,
                                  width: 80,
                                  image:
                                  NetworkImage(provider.cart[index].image!),
                                ),
                                SizedBox(
                                  width: 130,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        text: TextSpan(
                                            text: 'Name: ',
                                            style: TextStyle(
                                                color: Colors.blueGrey.shade800,
                                                fontSize: 16.0),
                                            children: [
                                              TextSpan(
                                                  text:
                                                  '${provider.cart[index].productName!}\n',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ]),
                                      ),
                                      RichText(
                                        maxLines: 1,
                                        text: TextSpan(
                                            text: 'Size: ',
                                            style: TextStyle(
                                                color: Colors.blueGrey.shade800,
                                                fontSize: 16.0),
                                            children: [
                                              TextSpan(
                                                  text:
                                                  '${provider.cart[index].size!}\n',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ]),
                                      ),
                                      RichText(
                                        maxLines: 1,
                                        text: TextSpan(
                                            text: 'Price: ' r"$",
                                            style: TextStyle(
                                                color: Colors.blueGrey.shade800,
                                                fontSize: 16.0),
                                            children: [
                                              TextSpan(
                                                  text:
                                                  '${provider.cart[index].productPrice!}\n',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                                ValueListenableBuilder<int>(
                                    valueListenable: provider.cart[index].quantity,
                                    builder: (context, val, child) {
                                      return PlusMinusButtons(
                                          addQuantity: () {
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('add pressed')));
                                            cart.addQuantity(provider.cart[index].id!);
                                            dbHelper!.updateQuantity(Cart(
                                                id: index,
                                                productId: index.toString(),
                                                productName: provider
                                                    .cart[index].productName,
                                                initialPrice: provider
                                                    .cart[index].initialPrice,
                                                productPrice: provider
                                                    .cart[index].productPrice,
                                                quantity: ValueNotifier(
                                                    provider.cart[index]
                                                        .quantity.value),
                                                size: provider
                                                    .cart[index].size,
                                                image: provider
                                                    .cart[index].image)).then((value) {
                                              setState(() {
                                                // todo : perhaps the cart value is not being updated
                                                // val =int.parse(provider.cart[index].quantity.toString());
                                                displayNumber = provider.cart[index].quantity.value;
                                                displayValue = displayNumber.toString();
                                                cart.addTotalPrice(double.parse(
                                                    provider
                                                        .cart[index].productPrice
                                                        .toString()));
                                              });
                                            });
                                          },
                                          deleteQuantity: () {
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('delete pressed')));
                                            cart.deleteQuantity(
                                                provider.cart[index].id!);
                                            cart.removeTotalPrice(double.parse(
                                                provider.cart[index].productPrice
                                                    .toString()));
                                            setState(() {
                                            });
                                          },
                                          text: val.toString()
                                      );
                                    }),
                                IconButton(
                                    onPressed: () {
                                      dbHelper!.deleteCartItem(
                                          provider.cart[index].id!);
                                      provider
                                          .removeItem(provider.cart[index].id!);
                                      provider.removeCounter();
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red.shade800,
                                    )),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
          Consumer<CartProvider>(
            builder: (BuildContext context, value, Widget? child) {
              final ValueNotifier<int?> totalPrice = ValueNotifier(null);
              for (var element in value.cart) {
                totalPrice.value =
                   int.parse( ((element.productPrice! * element.quantity.value) +
                       (totalPrice.value ?? 0)).toString());
              }
              return Column(
                children: [
                  ValueListenableBuilder<int?>(
                      valueListenable: totalPrice,
                      builder: (context, val, child) {
                        return ReusableWidget(
                            title: 'Sub-Total',
                            value: r'$' + (val?.toStringAsFixed(2) ?? '0'));
                      }),
                ],
              );
            },
          )
        ],
      ),
    );
  }//end build
}

class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;
  const PlusMinusButtons(
      {Key? key,
        required this.addQuantity,
        required this.deleteQuantity,
        required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: deleteQuantity, icon: const Icon(Icons.remove)),
        Text(text),
        IconButton(onPressed: addQuantity, icon: const Icon(Icons.add)),
      ],
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}