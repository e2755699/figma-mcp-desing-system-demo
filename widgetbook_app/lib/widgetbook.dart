import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: '淺色主題',
              data: ThemeData.light(),
            ),
            WidgetbookTheme(
              name: '深色主題',
              data: ThemeData.dark(),
            ),
          ],
        ),
      ],
      directories: [],
      appBuilder: (context, widget) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: widget,
        );
      },
    );
  }
} 