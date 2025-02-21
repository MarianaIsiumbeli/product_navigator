import 'package:flutter/material.dart';
import 'package:product_navigator/pages/lists_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/authenticated_user.dart';
import 'search_page.dart';

class ListDetailsPage extends StatefulWidget {
  final String listTitle;
  final String sellerName;
  final double price;
  final String modelName;
  final String? listId;
  final String products;

  const ListDetailsPage({
    super.key,
    required this.listTitle,
    required this.sellerName,
    required this.price,
    required this.modelName,
    this.listId,
    required this.products,
  });

  @override
  State<ListDetailsPage> createState() => _ListDetailsPageState();
}

class _ListDetailsPageState extends State<ListDetailsPage> {
  late String _listTitle;
  late List<String> _products;

  @override
  void initState() {
    super.initState();
    _listTitle = widget.listTitle;
    _products =
        widget.products.split(',').map((product) => product.trim()).toList();
  }

  void _addProduct(String product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }


  void _showSaveTitleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController titleController =
            TextEditingController(text: _listTitle);
        return AlertDialog(
          title: const Text('Enter List Title'),
          content: TextField(
            controller: titleController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter list title',
            ),
            onChanged: (value) {
              setState(() {
                _listTitle = value;
              });
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                //Navigator.pop(context);
                if (!mounted) {
                  return; 
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveList() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown_user';

    final updatedList = {
      'id': widget.listId ?? DateTime.now().toString(),
      'title': _listTitle.isNotEmpty ? _listTitle : 'Untitled List',
      'modelName': widget.modelName,
      'seller': widget.sellerName,
      'price': widget.price,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'userId': userId,
      'products': _products.join(','),
    };

    final listsJson = prefs.getString('savedLists_$userId');
    List<Map<String, dynamic>> savedLists = listsJson != null
        ? List<Map<String, dynamic>>.from(json.decode(listsJson))
        : [];

    int existingIndex =
        savedLists.indexWhere((list) => list['id'] == widget.listId);
    if (existingIndex != -1) {
      savedLists[existingIndex] = updatedList;
    } else {
      savedLists.add(updatedList);
    }

    await prefs.setString('savedLists_$userId', json.encode(savedLists));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('List updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context, updatedList);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Details'),
        actions: const [UserAuthWidget()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'List name: $_listTitle',
              style: const TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 16, 73, 119),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Table Header
            const Divider(thickness: 2, color: Color.fromARGB(255, 16, 73, 119)),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Model',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 16, 73, 119),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Seller',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 16, 73, 119),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 16, 73, 119),
                      ),
                    ),
                  ),
                  SizedBox(width: 40), 
                ],
              ),
            ),
            const Divider(thickness: 2, color: Color.fromARGB(255, 16, 73, 119)),

            // Product List Table
            Expanded(
              child: ListView.separated(
                itemCount: _products.length,
                separatorBuilder: (context, index) => const Divider(color: Colors.grey, thickness: 1),
                itemBuilder: (context, index) {
                  final parts = _products[index].split(' - ');
                  final modelName = parts.isNotEmpty ? parts[0] : '';
                  final seller = parts.length > 1 ? parts[1] : '';
                  final price = parts.length > 2 ? parts[2] : '';

                  return Row(
                    children: [
                      Expanded(flex: 3, child: Text(modelName, style: const TextStyle(fontSize: 16))),
                      Expanded(flex: 3, child: Text(seller, style: const TextStyle(fontSize: 16))),
                      Expanded(
                        flex: 2,
                        child: Text(
                          price,
                          style: const TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteProduct(index),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Buttons
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SearchPage()),
                    );
                    if (result != null) {
                      _addProduct(result);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    'Add Product',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () async {
                    await _saveList();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const ListsPage()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    'Update List',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
