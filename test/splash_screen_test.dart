import 'package:ae_store/core/Token/token.dart';
import 'package:ae_store/features/splash/presentation/screens/splash_screen.dart';
import 'package:ae_store/screens/bottom_nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('restores an authenticated session after app restart', (
    tester,
  ) async {
    final originalToken = token;
    token = 'persisted-test-token';
    addTearDown(() => token = originalToken);

    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
    await tester.pump(const Duration(milliseconds: 1900));
    await tester.pumpAndSettle();

    expect(find.byType(BottomNavigationBarScreen), findsOneWidget);
    expect(find.byType(SplashScreen), findsNothing);
    expect(token, 'persisted-test-token');
  });

  testWidgets('shows the AE Store splash screen after its entrance animation', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
    await tester.pump(const Duration(milliseconds: 1900));

    expect(find.text("MAISON D'ÉLÉGANCE"), findsOneWidget);
    expect(find.text('AE'), findsOneWidget);
    expect(find.text('AE STORE'), findsOneWidget);
    expect(find.text('HAUTE HORLOGERIE & ACCESSORIES'), findsOneWidget);
    expect(find.text('ENTER SALON'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('ENTER SALON'));
    await tester.pumpAndSettle();

    expect(find.text('AE STORE • EDITION 01'), findsOneWidget);
    expect(find.text('Elevate Your Style'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
