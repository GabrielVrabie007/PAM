import 'package:flutter_test/flutter_test.dart';

import 'package:lab2_gemstore/main.dart';
import 'package:lab2_gemstore/widgets/section_header.dart';

void main() {
  testWidgets('homepage afiseaza titlul si cele trei sectiuni', (tester) async {
    await tester.pumpWidget(const GemStoreApp());

    expect(find.text('GemStore'), findsOneWidget);
    expect(find.text('Feature Products'), findsOneWidget);
    expect(find.text('Recommended'), findsOneWidget);
    expect(find.text('Top Collection'), findsOneWidget);
    expect(find.byType(SectionHeader), findsNWidgets(3));
  });
}
