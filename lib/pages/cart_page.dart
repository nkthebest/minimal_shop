import 'package:flutter/material.dart';
import 'package:minimalshop/components/my_button.dart';
import 'package:minimalshop/models/product.dart';
import 'package:minimalshop/models/shop.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // remove item from cart
  void removeItemFromCart(BuildContext context, Product product) {
    {
      //show a dailog box for confirmation to remove
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: const Text("Remove this item from your cart?"),
                actions: [
                  //cancel button
                  MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                  ),

                  // yes button
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);

                      context.read<Shop>().removeFromCart(product);
                    },
                    child: Text("yes"),
                  ),
                ],
              ));
    }
  }

  // user pressed the pay button
  void payButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: Text("user wants to pay! connect it payment backend...."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // get access to the cart
    final cart = context.watch<Shop>().cart;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Cart Page"),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children: [
        //cart list
        Expanded(
          child: cart.isEmpty
              ? const Center(child: Text("your cart is empty.."))
              : ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    // get individual item
                    final item = cart[index];

                    //return as alist tile
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text(item.price.toStringAsFixed(2)),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => removeItemFromCart(context, item),
                      ),
                    );
                  }),
        ),

        Padding(
          padding: const EdgeInsets.all(50),
          child: MyButton(
            onTap: () => payButtonPressed(context),
            child: Text("pay now"),
          ),
        ),
      ]),
    );
  }
}
