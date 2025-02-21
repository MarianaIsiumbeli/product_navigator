import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_navigator/widgets/app_drawer.dart';

void main() {
  testWidgets('AppDrawer contains expected widgets and navigates correctly', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          drawer: const AppDrawer(), 
        ),
      ),
    );

    // Act
    await tester.tap(find.byIcon(Icons.menu)); 
    await tester.pumpAndSettle(); 

    // Assert
    expect(find.byType(DrawerHeader), findsOneWidget);

    // Assert
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    // Act
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle(); 

    // Assert
    expect(find.text('Home Page'), findsOneWidget);
  });
}