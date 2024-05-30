import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;

  // Constructor for ProductDetailsPage, taking a required 'product' parameter
  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  // Variable to store the selected size, initialized to 0
  int selectedSize = 0;

  // Function to be called when the 'Add to Cart' button is pressed
  void onTap() {
    // Check if a size is selected
    if (selectedSize != 0) {
      // Access the CartProvider using Provider and add the product to the cart
      Provider.of<CartProvider>(context, listen: false).addProduct(
        {
          'id': widget.product['id'],
          'title': widget.product['title'],
          'price': widget.product['price'],
          'imageUrl': widget.product['imageUrl'],
          'company': widget.product['company'],
          'size': selectedSize,
        },
      );
    } else {
      // Show a snack bar if no size is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('please select a size'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('details'),
      ),
      body: Column(
        children: [
          // Display the title of the product with a large text style
          Text(
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          // Display the image of the product with padding and optional default image path
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              (widget.product['imageUrl'] as String?) ?? 'default_image_path',
              height: 250,
            ),
          ),
          const Spacer(flex: 2),
          // Container containing product details, size selection, and 'Add to Cart' button
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display the price of the product with a large text style
                Text(
                  '\$${widget.product['price']},',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // Horizontal list of size chips for size selection
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product['size'] as List<int>?)?.length ?? 0,
                    itemBuilder: (context, index) {
                      final size = (widget.product['size']! as List<int>)[index];
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                          onTap: () {
                            // Update the selected size when a chip is tapped
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: Chip(
                            label: Text(size.toString()),
                            backgroundColor: selectedSize == size
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Elevated button for adding the product to the cart
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        fixedSize: const Size(350, 50)),
                    child: const Text(
                      'Add to cart',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
