// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/app_theme.dart';
import 'package:ae_store/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('light theme uses AppColors', () {
    expect(AppTheme.lightTheme.colorScheme.primary, AppColors.primary);
  });

  testWidgets('app opens on the splash screen', (tester) async {
    await tester.pumpWidget(const AEStore());
    await tester.pump(const Duration(milliseconds: 1900));

    expect(find.text('ENTER SALON'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
