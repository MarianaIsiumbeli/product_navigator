import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchState extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _feedbackMessage = '';
  String get feedbackMessage => _feedbackMessage;

  List<Map<String, dynamic>> _searchResults = [];
  List<Map<String, dynamic>> get searchResults => _searchResults;

  Future<void> searchProducts({
    String productName = '',
    String modelName = '',
  }) async {
    if (productName.isEmpty && modelName.isEmpty) {
      _feedbackMessage = 'Please enter a search.';
      _searchResults = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    _feedbackMessage = '';
    notifyListeners();

    try {
      List<Map<String, dynamic>> results = [];

      Query query = _firestore.collection('products');

      if (productName.isNotEmpty) {
        query = query.where('name', isEqualTo: productName);
      }

      final querySnapshot = await query.get();

      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final models = data['models'] as List<dynamic>? ?? [];
        final producer = data['producer'] ?? 'No Producer';

        for (var model in models) {
          if (modelName.isEmpty ||
              (model['modelname'] as String?)!
                  .toLowerCase()
                  .contains(modelName.toLowerCase())) {
            final sellers = model['sellers'] as List<dynamic>? ?? [];
            for (var seller in sellers) {
              results.add({
                'producer': producer,
                'productname': data['name'] ?? 'No Name',
                'modelname': model['modelname'] ?? 'No Model',
                'sellername': seller['sellername'] ?? 'No Seller',
                'price': (seller['price'] as num?)?.toDouble() ?? 0.0,
                'averageRating':
                    (seller['averagerating'] as num?)?.toDouble() ?? 0.0,
                'reviews': List<String>.from(seller['reviews'] ?? []),
              });
            }
          }
        }
      }

      if (results.isEmpty) {
        _feedbackMessage = 'No results found.';
      } else {
        _searchResults = results;
      }
    } catch (e) {
      _feedbackMessage = 'Error searching products: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearchResults() {
    _searchResults = [];
    notifyListeners();
  }

  void clearFeedbackMessage() {
    _feedbackMessage = '';
    notifyListeners();
  }

  void clearForm() {
    clearSearchResults();
    clearFeedbackMessage();
  }
}
