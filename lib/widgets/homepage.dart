import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rangza_ekart/widgets/productdetails.dart';
import 'package:rangza_ekart/widgets/profile.dart';

class MediFastHomePage extends StatefulWidget {
  const MediFastHomePage({Key? key}) : super(key: key);

  @override
  State<MediFastHomePage> createState() => _MediFastHomePageState();
}

class _MediFastHomePageState extends State<MediFastHomePage> {
  int _currentIndex = 0;
  final List<String> _bannerImages = [
    'assets/banner1.png',

  ];

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Prescription Medicines', 'icon': Icons.description},
    {'name': 'Over-the-Counter', 'icon': Icons.medication},
    {'name': 'Wellness & Supplements', 'icon': Icons.favorite_outline},
    {'name': 'Baby & Mother Care', 'icon': Icons.child_care},
    {'name': 'Personal Care & Hygiene', 'icon': Icons.clean_hands},
    {'name': 'Medical Devices & Equipment', 'icon': Icons.medical_services},
  ];

  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Dettol 50 ml',
      'price': 110,
      'oldPrice': 150,
      'image': 'assets/banner1.png',
    },
    {
      'name': 'Steel Pot',
      'price': 110,
      'oldPrice': 150,
      'image': 'assets/banner1.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ✅ AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(),
        elevation: 0,

        title: Row(
          children: [
            Image.asset('assets/icon.jpeg', height: 30),
            const SizedBox(width: 6),
            const Text.rich(
              TextSpan(
                text: 'Rangza',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),

              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none, color: Colors.black)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.black)),
          IconButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  ProfileScreen(),
                  ),
                );


              },
              icon: const Icon(Icons.person, color: Colors.black)),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🖼️ Banner Carousel
              CarouselSlider(
                items: _bannerImages
                    .map((item) => ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ))
                    .toList(),
                options: CarouselOptions(
                  height: 160,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),

              // 🔘 Dots Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _bannerImages.asMap().entries.map((entry) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == entry.key
                          ? const Color(0xFF007BFF)
                          : Colors.grey.shade300,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),

              // 🏷️ Categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "See more",
                    style: TextStyle(
                      color: Color(0xFF007BFF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  return Column(
                    children: [
                      Icon(cat['icon'], size: 40, color: Colors.black87),
                      const SizedBox(height: 8),
                      Text(
                        cat['name'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 20),
              buildSection("Antiseptics"),
              buildSection("Antibiotics"),
              buildSection("Baby & Mother Care"),
            ],
          ),
        ),
      ),





    );
  }

  // 🔹 Product Section Builder
  Widget buildSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _products.length,
            itemBuilder: (context, index) {
              final product = _products[index];
              return GestureDetector(

                child: Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(product['image']),
                      ),
                      Text(
                        product['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "₹${product['oldPrice']} ",
                              style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: "₹${product['price']}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007BFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        child: const Text(
                          "Add to Cart",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                onTap: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  ProductDetailPage(),
                    ),
                  );

                },
              )



                ;
            },
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
