import 'package:flutter/material.dart';
import 'package:shop_app/cart_page.dart';
import 'package:shop_app/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List of pages to be displayed in the IndexedStack
  List<Widget> pages = const [Productlist(), CartPage()];

  // Index of the currently visible page
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body of the app containing an IndexedStack to switch between pages
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      // Bottom navigation bar for navigating between pages
      bottomNavigationBar: BottomNavigationBar(
        // Index of the currently selected item in the bottom navigation bar
        currentIndex: currentPage,
        // Callback function when a navigation item is tapped
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        // List of bottom navigation bar items, each with an icon and label
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '',
          ),
        ],
      ),
    );
  }
}
