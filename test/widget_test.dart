// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ressources_relationnelles_v2/main.dart';

void main() {
  testWidgets('bouton connexion', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap the profil icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.account_circle));
    await tester.pump();

    // Verify bouton connexion.
    expect(find.text('Connexion'), findsOneWidget);
  });
}
