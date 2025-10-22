import 'package:flutter/material.dart';

import 'cart.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 2;
  int currentPage = 0;
  String selectedTab = 'Description';

  final List<String> images = [

    'assets/banner1.png',
    'assets/banner1.png',
    'assets/banner1.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔙 Back Button
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                // 🖼️ Image Carousel
                Center(
                  child: SizedBox(
                    height: 250,
                    child: PageView.builder(
                      itemCount: images.length,
                      onPageChanged: (index) {
                        setState(() => currentPage = index);
                      },
                      itemBuilder: (context, index) => Image.asset(
                        images[index],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                // 🔴 Dots Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                        (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentPage == index
                            ? Colors.redAccent
                            : Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // 🧴 Product Name
                const Text(
                  "Dettol Antiseptic Liquid",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                // 📄 Tabs
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildTabButton("Description"),
                    const SizedBox(width: 10),
                    _buildTabButton("How to use"),
                    const SizedBox(width: 10),
                    _buildTabButton("Return Policy"),
                  ],
                ),

                const SizedBox(height: 20),

                // 📝 Tab Content
                Text(
                  _getTabContent(),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 40),

                // 💰 Price + Quantity + Cart Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "1200 Rs",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),

                    // Quantity Controller
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() => quantity--);
                            }
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Text(
                            quantity.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() => quantity++);
                          },
                        ),
                      ],
                    ),

                    // 🛒 Add to Cart
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007BFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Added to Cart!"),
                          ),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  CartPage(),
                          ),
                        );




                      },
                      child: const Icon(Icons.shopping_cart_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🧭 Tab Button Builder
  Widget _buildTabButton(String label) {
    final bool isSelected = selectedTab == label;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF007BFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // 📘 Tab Content
  String _getTabContent() {
    switch (selectedTab) {
      case "Description":
        return "Dettol Antiseptic Liquid helps protect against bacteria and infections. "
            "It can be used for first aid, cleaning wounds, and personal hygiene purposes.";
      case "How to use":
        return "Dilute with water before applying to the skin. For external use only. "
            "Avoid contact with eyes or mouth.";
      case "Return Policy":
        return "Returns accepted within 7 days if the product seal is intact. "
            "Please retain the original packaging for return.";
      default:
        return "";
    }
  }
}
