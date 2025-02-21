import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/authenticated_user.dart';
import 'search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NewListPage extends StatefulWidget {
  final String? initialProduct;
  final String? listName;

  const NewListPage({super.key, this.initialProduct, this.listName});

  @override
  State<NewListPage> createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  final List<String> _products = [];
  String? _listName;
  String? sellerName;
  double? price;
  String? modelName;
  late List<String> reviews;

  @override
  void initState() {
    super.initState();
    if (widget.initialProduct != null) {
      _products.add(widget.initialProduct!);
    }
    _listName = widget.listName ?? 'New list';
    reviews = [];
  }

  void _addProduct(String product) {
    setState(() {
      _products.add(product);
    });
  }

  void _showSaveOrClearDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('Save or Clear List'),
          content: const Text('Do you want to save to list?'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showSaveTitleDialog();
              },
              child: const Text('Save List'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _clearList();
              },
              child: const Text('Clear List'),
            ),
          ],
        );
      },
    );
  }

  void _showSaveTitleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter List Title'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter list title',
            ),
            onChanged: (value) {
              _listName = value;
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _saveList();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveList() async {
    if (_listName == null || _listName!.isEmpty) {
      _listName = 'No name';
    }

    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? 'unknown_user';

    final newList = {
      'id': DateTime.now().toString(),
      'title': _listName!,
      'seller': sellerName ?? 'Unknown Seller',
      'price': price ?? 0.0,
      'modelName': modelName ?? 'Unknown Model',
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'userId': userId,
      'products': _products.join(','),
    };

    final prefs = await SharedPreferences.getInstance();
    final String? listsJson = prefs.getString('savedLists_$userId');
    List<Map<String, dynamic>> savedLists = listsJson != null
        ? List<Map<String, dynamic>>.from(json.decode(listsJson))
        : [];

    savedLists.add(newList);
    await prefs.setString('savedLists_$userId', json.encode(savedLists));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('List saved successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _clearList() {
    setState(() {
      _products.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_listName'),
        actions: const <Widget>[
          UserAuthWidget(),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_listName != null && _listName!.isNotEmpty)
              Text(
                _listName!,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_listName == null || _listName!.isEmpty) {
                      _showSaveOrClearDialog();
                    } else {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(),
                        ),
                      );
                      if (result != null && result is String) {
                        _addProduct(result);
                      }
                    }
                  },
                  child: const Text('Add Product'),
                ),
                const SizedBox(width: 10), 
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchPage(),
                      ),
                    );
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_products[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
