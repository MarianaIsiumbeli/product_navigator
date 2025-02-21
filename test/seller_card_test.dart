import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_navigator/pages/product_details.dart';
import 'package:product_navigator/widgets/seller_card.dart';

void main() {
  testWidgets('SellerCard displays correct data and navigates on tap', (WidgetTester tester) async {
    // Test data
    const sellerName = 'John Doe';
    const price = 99.99;
    const averageRating = 4.5;
    const producer = 'Wallmart';
    const modelName = 'Iphone 13';
    final reviews = <String>['Excellent', 'Good'];

    // Wrap your widget tree with MaterialApp to handle navigation
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SellerCard(
            sellerName: sellerName,
            price: price,
            averageRating: averageRating,
            producer: producer,
            modelName: modelName,
            reviews: reviews,
          ),
        ),
      ),
    );

    // Verify that the SellerCard displays the correct data
    expect(find.text(modelName), findsOneWidget);
    expect(find.text(sellerName), findsOneWidget);
    expect(find.text('CAD ${price.toStringAsFixed(2)}'), findsOneWidget);
    expect(find.text('Producer: $producer'), findsOneWidget);
    expect(find.text(averageRating.toStringAsFixed(1)), findsOneWidget);

    // Tap the SellerCard to trigger navigation
    await tester.tap(find.byType(SellerCard));
    await tester.pumpAndSettle();

    // Check if the ProductDetailsPage is displayed
    expect(find.byType(ProductDetailsPage), findsOneWidget);

    // Verify that the data passed to ProductDetailsPage is correct
    final ProductDetailsPage productDetailsPage = tester.widget(find.byType(ProductDetailsPage));
    expect(productDetailsPage.sellerName, equals(sellerName));
    expect(productDetailsPage.price, equals(price));
    expect(productDetailsPage.averageRating, equals(averageRating));
    expect(productDetailsPage.producer, equals(producer));
    expect(productDetailsPage.modelName, equals(modelName));
    expect(productDetailsPage.reviews, equals(reviews));
  });
}
