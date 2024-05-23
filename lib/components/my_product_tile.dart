import 'package:flutter/material.dart';
import 'package:minimalshop/models/product.dart';
import 'package:minimalshop/models/shop.dart';
import 'package:provider/provider.dart';

class MyProductTile extends StatelessWidget {
  final Product product;

  const MyProductTile({
    super.key,
    required this.product,
  });

  //add to cart button pressed

  void addToCart(BuildContext context) {
    //show a dailog box for confirmation
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("add this item to your cart?"),
              actions: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),

                // yes button
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);

                    context.read<Shop>().addToCart(product);
                  },
                  child: Text("yes"),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(25),
      width: 300,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //product image
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(25),
                      child: Image.asset(product.imagepath)),
                ),

                const SizedBox(height: 25),

                //product name
                Text(
                  product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                //product description
                Text(
                  product.description,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),

            //product price + add to cart button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // product price
                Text('\s' + product.price.toStringAsFixed(2)),

                //add to cart button
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () => addToCart(context),
                    icon: Icon(Icons.add),
                  ),
                )
              ],
            ),
          ]),
    );
  }
}
