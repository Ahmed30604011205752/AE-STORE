import 'package:ae_store/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('continues through onboarding slides and completes', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Elevate Your Style'), findsOneWidget);
    expect(find.text('LUMINOR CHRONO'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Made for Every Moment'), findsOneWidget);

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.text('A Better Way to Shop'), findsOneWidget);
    expect(find.text('Enter Salon'), findsOneWidget);

    await tester.tap(find.text('Enter Salon'));
    await tester.pump();
    expect(find.text('Welcome to AE Store'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
