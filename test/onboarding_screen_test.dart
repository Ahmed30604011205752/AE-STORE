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
    expect(find.text('AE SIGNATURE'), findsOneWidget);
    final firstImage = tester.widget<Image>(find.byType(Image).first);
    expect(
      (firstImage.image as AssetImage).assetName,
      'assets/images/onBoarding1_img.png',
    );
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Made for Every Moment'), findsOneWidget);
    final secondImage = tester.widget<Image>(find.byType(Image).first);
    expect(
      (secondImage.image as AssetImage).assetName,
      'assets/images/onBoarding2_img.png',
    );

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('A Better Way to Shop'), findsOneWidget);
    final thirdImage = tester.widget<Image>(find.byType(Image).first);
    expect(
      (thirdImage.image as AssetImage).assetName,
      'assets/images/onBoarding3_img.png',
    );
    expect(find.text('Enter Salon'), findsOneWidget);

    await tester.tap(find.text('Enter Salon'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
