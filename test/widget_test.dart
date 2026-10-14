import 'package:bon_voice/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Bon Voice app loads home and selects the tapped preset', (tester) async {
    await tester.pumpWidget(const BonVoiceApp());

    expect(find.text('Bon Voice'), findsOneWidget);
    await tester.drag(find.byType(ListView).first, const Offset(0, -400));
    await tester.pumpAndSettle();
    expect(find.text('Presets'), findsOneWidget);
    expect(find.text('3 profiles'), findsOneWidget);

    await tester.ensureVisible(find.text('Bon Clean'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bon Clean'));
    await tester.pumpAndSettle();

    expect(find.text('Active profile'), findsOneWidget);
    expect(find.text('Voice profile'), findsNWidgets(2));
  });

  testWidgets('Settings rows can be tapped and preferences survive navigation', (tester) async {
    await tester.pumpWidget(const BonVoiceApp());
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    final micTileFinder = find.byKey(const ValueKey('setting-micMonitoring'));
    expect(micTileFinder, findsOneWidget);
    expect(tester.widget<SwitchListTile>(micTileFinder).value, isTrue);

    await tester.tap(find.text('Mic monitoring'));
    await tester.pumpAndSettle();

    expect(tester.widget<SwitchListTile>(micTileFinder).value, isFalse);
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getBool('settings.micMonitoring'), isFalse);

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(tester.widget<SwitchListTile>(micTileFinder).value, isFalse);
  });

  testWidgets('Voice, recorder, advanced settings, and install help are reachable', (tester) async {
    await tester.pumpWidget(const BonVoiceApp());

    await tester.tap(find.text('Voice'));
    await tester.pumpAndSettle();
    expect(find.text('Voice Engine'), findsOneWidget);
    expect(find.text('Input gain'), findsOneWidget);

    await tester.tap(find.text('Recorder'));
    await tester.pumpAndSettle();
    expect(find.text('Ready to record'), findsOneWidget);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('Recording in progress'), findsOneWidget);

    await tester.tap(find.byTooltip('Advanced audio settings'));
    await tester.pumpAndSettle();
    expect(find.text('Advanced DSP'), findsOneWidget);
    expect(find.text('Sustain'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('How to install'));
    await tester.pumpAndSettle();
    expect(find.text('Install Bon Voice'), findsOneWidget);
  });
}
