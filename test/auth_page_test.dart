import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_navigator/pages/auth_page.dart';

void main() {
  group('AuthPage', () {
    testWidgets('should display email and password fields',
        (WidgetTester tester) async {
      // act
      await tester.pumpWidget(
        const MaterialApp(
          home: AuthPage(isLogin: true),
        ),
      );

      // assert
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(TextField).first, findsOneWidget);
      expect(find.byType(TextField).last, findsOneWidget);
    });

    testWidgets('should show error message on authentication failure',
        (WidgetTester tester) async {
      // arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: AuthPage(isLogin: true),
        ),
      );

      await tester.enterText(find.byType(TextField).first, 'test@example.com');
      await tester.enterText(find.byType(TextField).last, 'wrongpassword');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      await tester.pump(const Duration(seconds: 2));

      // assert
      expect(find.textContaining('Authentication failed'), findsOneWidget);
    });

    testWidgets('should reset password', (WidgetTester tester) async {
      // arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: AuthPage(isLogin: true),
        ),
      );

      // act
      final forgotPasswordButton = find.text('Forgot Password?');
      expect(forgotPasswordButton, findsOneWidget);
      await tester.tap(forgotPasswordButton);
      await tester.pump();

      // assert
      expect(find.byType(AlertDialog), findsOneWidget);
      final resetButton = find.descendant(
        of: find.byType(AlertDialog),
        matching: find.text('Reset'),
      );
      expect(resetButton, findsOneWidget);
      await tester.tap(resetButton);
      await tester.pump(); 
     
      expect(find.byType(SnackBar), findsOneWidget);     
    });

    testWidgets('should toggle between login and registration',
        (WidgetTester tester) async {
      // arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: AuthPage(isLogin: true),
        ),
      );

      // act   
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      
      await tester.tap(find.text('Create an account'));
      await tester.pump(); 

      // assert 
      expect(find.text('Register').first, findsOneWidget);
      expect(find.text('Have an account? Sign In'), findsOneWidget);

            await tester.tap(find.text('Have an account? Sign In'));
      await tester.pump(); 

      // assert
      expect(find.text('Sign In'), findsOneWidget);
    
    });
  });
}
