import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'new_list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProductDetailsPage extends StatelessWidget {
  final String sellerName;
  final double price;
  final double averageRating;
  final String producer;
  final String modelName;
  final List<String> reviews;

  const ProductDetailsPage({
    super.key,
    required this.sellerName,
    required this.price,
    required this.averageRating,
    required this.producer,
    required this.modelName,
    required this.reviews,
  });

  void _showAddToListDialog(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown_user';
    final listsJson = prefs.getString('savedLists_$userId');
    final List<Map<String, dynamic>> savedLists = listsJson != null
        ? List<Map<String, dynamic>>.from(json.decode(listsJson))
        : [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose List'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _createNewList(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  minimumSize: const Size(170, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'New List',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ...savedLists.map((list) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _addProductToList(context, list);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    minimumSize: const Size(170, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    list['title'] ?? 'Unnamed List',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _createNewList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewListPage(
          initialProduct:
              '$modelName - $sellerName - CAD ${price.toStringAsFixed(2)}',
          listName: '',
        ),
      ),
    );
  }

  Future<void> _addProductToList(
      BuildContext context, Map<String, dynamic> list) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown_user';

    final listId = list['id'] ?? 'unknown_list';
    final productsString = list['products'] ?? '';
    final List<String> products = productsString.isNotEmpty
        ? List<String>.from(productsString.split(','))
        : [];

    products.add('$modelName - $sellerName - CAD ${price.toStringAsFixed(2)}');

    final updatedList = {
      ...list,
      'products': products.join(','),
    };

    final listsJson = prefs.getString('savedLists_$userId');
    final List<Map<String, dynamic>> savedLists = listsJson != null
        ? List<Map<String, dynamic>>.from(json.decode(listsJson))
        : [];

    final updatedLists = savedLists.map((existingList) {
      if (existingList['id'] == listId) {
        return updatedList;
      }
      return existingList;
    }).toList();

    await prefs.setString('savedLists_$userId', json.encode(updatedLists));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
         content: Text('Product added to list successfully!'),
    backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              modelName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Seller: $sellerName',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'CAD ${price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 155, 61, 42),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Producer: $producer',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                const SizedBox(width: 4),
                Text(
                  averageRating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Reviews:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...reviews.map((review) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    review,
                    style: const TextStyle(fontSize: 16),
                  ),
                )),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showAddToListDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Add to List',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
