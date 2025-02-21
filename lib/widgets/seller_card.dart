import 'package:flutter/material.dart';
import '../pages/product_details.dart';

class SellerCard extends StatelessWidget {
  final String sellerName;
  final double price;
  final double averageRating;
  final String producer;
  final String modelName;
  final List<String> reviews;

  const SellerCard({
    super.key,
    required this.sellerName,
    required this.price,
    required this.averageRating,
    required this.producer,
    required this.modelName,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final TextScaler textScaler = MediaQuery.of(context).textScaler;

    double adjustedFontSize(double baseFontSize) {
      double scaledFontSize = textScaler.scale(baseFontSize);
      ;
      return scaledFontSize.clamp(12.0, 24.0);
    }

    return Center(
      child: Card(
        margin: EdgeInsets.all(screenWidth * 0.03),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(
                  sellerName: sellerName,
                  price: price,
                  averageRating: averageRating,
                  producer: producer,
                  modelName: modelName,
                  reviews: reviews,
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(screenHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  modelName,
                  style: TextStyle(
                    fontSize: adjustedFontSize(18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  sellerName,
                  style: TextStyle(
                    fontSize: adjustedFontSize(14),
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'CAD ${price.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: adjustedFontSize(16),
                    color: const Color.fromARGB(255, 219, 61, 26),
                  ),
                ),
                Text(
                  'Producer: $producer',
                  style: TextStyle(fontSize: adjustedFontSize(14)),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: adjustedFontSize(20),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: TextStyle(fontSize: adjustedFontSize(14)),
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
}
