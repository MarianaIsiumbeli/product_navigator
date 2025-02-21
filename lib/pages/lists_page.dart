import 'package:flutter/material.dart';
import 'package:product_navigator/widgets/app_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../widgets/authenticated_user.dart';
import 'list_details_page.dart';
import 'new_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({super.key});

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  List<Map<String, dynamic>> _lists = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLists();
  }

  Future<void> _loadLists() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown_user';
    final listsJson = prefs.getString('savedLists_$userId');

    // if (listsJson != null) {
    //   setState(() {
    //     _lists = List<Map<String, dynamic>>.from(json.decode(listsJson));
    //   });
    // }

    setState(() {
      _lists = listsJson != null
          ? List<Map<String, dynamic>>.from(json.decode(listsJson))
          : [];
      _isLoading = false;
    });
  }

  Future<void> _deleteList(String listId) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown_user';
    // final listsJson = prefs.getString('savedLists_$userId');

    // if (listsJson != null) {
    //   final List<Map<String, dynamic>> lists =
    //       List<Map<String, dynamic>>.from(json.decode(listsJson));
    //   lists.removeWhere((list) => list['id'] == listId);

    //   await prefs.setString('savedLists_$userId', json.encode(lists));

    //   setState(() {
    //     _lists = lists;
    //   });
    // }

    _lists.removeWhere((list) => list['id'] == listId);
    await prefs.setString('savedLists_$userId', json.encode(_lists));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('List deleted successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    setState(() {}); // Refresh UI
  }

  void _navigateToListDetails(String listId) async {
    final list = _lists.firstWhere((list) => list['id'] == listId);
    final updatedList = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListDetailsPage(
          listTitle: list['title'] ?? 'Unnamed List',
          products: list['products'] ?? '',
          sellerName: list['seller'] ?? '',
          price: list['price'] ?? 0.0,
          modelName: list['modelName'] ?? '',
          listId: listId,
        ),
      ),
    );

    if (updatedList != null) {
      setState(() {
        int existingIndex = _lists.indexWhere((l) => l['id'] == listId);
        if (existingIndex != -1) {
          _lists[existingIndex] =
              updatedList; // 🔥 FIX: Update instead of adding duplicate
        }
      });
    }
  }

  String _calculateTotalCost(String products) {
    final productList = products.split(',');
    double totalCost = 0.0;
    for (String product in productList) {
      final parts = product.split(' - CAD ');
      if (parts.length == 2) {
        final priceStr = parts[1];
        final price = double.tryParse(priceStr) ?? 0.0;
        totalCost += price;
      }
    }
    return totalCost.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Lists'),
        backgroundColor: Colors.lightBlue,
        actions: const [
          UserAuthWidget(),
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _lists.isEmpty
              ? const Center(child: Text('No lists available'))
              : ListView.builder(
                  itemCount: _lists.length,
                  itemBuilder: (context, index) {
                    final list = _lists[index];
                    return ListTile(
                      title: Text(
                        list['title'] ?? 'Unnamed List',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'Products: ${list['products']?.split(',').length ?? 0}\n',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'Total: CAD ${_calculateTotalCost(list['products'] ?? '')}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 255, 121, 112),
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Delete List'),
                                content: const Text(
                                    'Are you sure you want to delete this list?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await _deleteList(list['id']);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      onTap: () => _navigateToListDetails(list['id']),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewListPage(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
