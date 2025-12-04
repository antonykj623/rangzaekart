import 'package:flutter/material.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({Key? key}) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  int selectedAddressIndex = 0;

  final List<Map<String, String>> savedAddresses = [
    {
      'name': 'Antony Jackson',
      'address': 'Rangza Street, Thrissur, Kerala',
      'phone': '+91 9876543210'
    },
    {
      'name': 'Home',
      'address': 'Near City Mall, Kochi, Kerala',
      'phone': '+91 9123456789'
    },
  ];

  double subtotal = 1499.00;
  double deliveryCharge = 49.00;

  @override
  Widget build(BuildContext context) {
    double total = subtotal + deliveryCharge;

    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      appBar: AppBar(
        title: const Text(
          "Place Order",
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
        ),

        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📍 Address Section
            const Text(
              "Select Delivery Address",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Column(
              children: List.generate(savedAddresses.length, (index) {
                final address = savedAddresses[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: RadioListTile(
                    value: index,
                    groupValue: selectedAddressIndex,
                    activeColor: Colors.deepPurple,
                    onChanged: (val) {
                      setState(() => selectedAddressIndex = val!);
                    },
                    title: Text(
                      address['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${address['address']}\n${address['phone']}",
                    ),
                  ),
                );
              }),
            ),

            // ➕ Add new address button
            TextButton.icon(
              onPressed: () {
                _showAddAddressDialog(context);
              },
              icon: const Icon(Icons.add_location_alt_rounded),
              label: const Text("Add New Address"),
            ),

            const Divider(height: 30),

            // 💸 Order Summary
            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            _buildSummaryRow("Subtotal", "₹${subtotal.toStringAsFixed(2)}"),
            _buildSummaryRow("Delivery Charge", "₹${deliveryCharge.toStringAsFixed(2)}"),
            const Divider(),
            _buildSummaryRow(
              "Total",
              "₹${total.toStringAsFixed(2)}",
              isBold: true,
            ),

            const SizedBox(height: 30),

            // 🛒 Place Order Button
            ElevatedButton(
              onPressed: () {
                _placeOrder(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Place Order",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }

  void _placeOrder(BuildContext context) {
    final address = savedAddresses[selectedAddressIndex];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "Order placed successfully! Delivering to ${address['address']}"),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showAddAddressDialog(BuildContext context) {
    final nameController = TextEditingController();
    final houseController = TextEditingController();
    final streetController = TextEditingController();
    final cityController = TextEditingController();
    final pincodeController = TextEditingController();
    final phoneController = TextEditingController();
    final altPhoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text("Add New Address"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _textField(nameController, "Full Name"),
              _textField(houseController, "House / Building Name"),
              _textField(streetController, "Street / Landmark"),
              _textField(cityController, "City"),
              _textField(pincodeController, "Pincode", keyboard: TextInputType.number),
              _textField(phoneController, "Phone", keyboard: TextInputType.phone),
              _textField(altPhoneController, "Alternate Phone (optional)",
                  keyboard: TextInputType.phone),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                savedAddresses.add({
                  'name': nameController.text,
                  'house': houseController.text,
                  'street': streetController.text,
                  'city': cityController.text,
                  'pincode': pincodeController.text,
                  'phone': phoneController.text,
                  'altPhone': altPhoneController.text,
                });
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Widget _textField(TextEditingController controller, String label,
      {TextInputType keyboard = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

}
