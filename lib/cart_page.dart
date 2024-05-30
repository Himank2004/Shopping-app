import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing the cart data using Provider
    final cart = Provider.of<CartProvider>(context).cart;
    // Alternatively, you can use the context.watch method:
    // final cart = context.watch<CartProvider>().cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];

          return ListTile(
            // Displaying the product image in a CircleAvatar
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                  cartItem['imageUrl'] as String? ?? 'default_image_path'),
              radius: 35,
            ),
            // A button to trigger the delete product action
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Delete Product',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: const Text('Are you sure you want to delete it?'),
                      actions: [
                        // Confirming deletion action
                        TextButton(
                          onPressed: () {
                            // Removing the product from the cart
                            // You can use context.read<CartProvider>().removeProduct(cartItem);
                            Provider.of<CartProvider>(context, listen: false)
                                .removeProduct(cartItem);
                            Navigator.of(context).pop(); // Closing the dialog
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Canceling deletion action
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Closing the dialog
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            // Displaying the product title and size
            title: Text(
              cartItem['title']?.toString() ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text('Size: ${cartItem['size']?.toString() ?? ''}'),
          );
        },
      ),
    );
  }
}
