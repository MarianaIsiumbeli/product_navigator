import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../search_state.dart';
import '../widgets/app_drawer.dart';
import '../widgets/authenticated_user.dart';
import '../widgets/seller_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _modelNameController = TextEditingController();

  void _clearForm() {
    _productNameController.clear();
    _modelNameController.clear();

    Provider.of<SearchState>(context, listen: false).clearForm();
  }

  void _search() {
    final productName = _productNameController.text.trim();
    final modelName = _modelNameController.text.trim();

    Provider.of<SearchState>(context, listen: false).searchProducts(
      productName: productName,
      modelName: modelName,
    );
  }

  // Function to determine the number of columns based on screen width
  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return 2        ; // Mobile (2 cards per row)
    } else if (screenWidth < 900) {
      return 3; // Tablet (3 cards per row)
    } else {
      return 4; // Desktop (4 cards per row)
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchState>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Search Products',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: const [
          UserAuthWidget(),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            TextField(
              controller: _modelNameController,
              decoration: const InputDecoration(
                labelText: 'Product Name or Model Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _search,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _clearForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Clear',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (searchState.isLoading) const CircularProgressIndicator(),
            if (searchState.feedbackMessage.isNotEmpty)
              Text(
                searchState.feedbackMessage,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              )
            else
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getCrossAxisCount(context), 
                    childAspectRatio: 0.7, // card height adjustment
                    mainAxisSpacing: 5, 
                    crossAxisSpacing: 5, 
                  ),
                  itemCount: searchState.searchResults.length,
                  itemBuilder: (context, index) {
                    final result = searchState.searchResults[index];
                    return SellerCard(
                      modelName: result['modelname'],
                      sellerName: result['sellername'],
                      price: result['price'],
                      producer: result['producer'],
                      averageRating: result['averageRating'],
                      reviews: result['reviews'],
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


