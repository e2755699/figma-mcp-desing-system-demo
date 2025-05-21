import 'package:flutter/material.dart';
import 'package:widgetbook_app/widgetbook.dart';

void main() {
  runApp(const HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const WidgetbookApp();
} 