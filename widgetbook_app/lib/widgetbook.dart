import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_app/widgets/button_use_cases.dart';

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: '淺色主題',
              data: ThemeData.light(useMaterial3: true),
            ),
            WidgetbookTheme(
              name: '深色主題',
              data: ThemeData.dark(useMaterial3: true),
            ),
          ],
        ),
        DeviceFrameAddon(
          devices: [
            DeviceInfo.genericPhone(
              name: 'iPhone 13',
              platform: TargetPlatform.iOS,
              id: 'iphone-13',
              screenSize: const Size(390, 844),
            ),
            DeviceInfo.genericPhone(
              name: 'Galaxy S21',
              platform: TargetPlatform.android,
              id: 'galaxy-s21',
              screenSize: const Size(360, 800),
            ),
            DeviceInfo.genericTablet(
              name: 'iPad',
              platform: TargetPlatform.iOS,
              id: 'ipad',
              screenSize: const Size(768, 1024),
            ),
          ],
        ),
      ],
      directories: [
        WidgetbookFolder(
          name: 'UI元件',
          children: [
            WidgetbookFolder(
              name: '按鈕',
              children: [
                WidgetbookComponent(
                  name: 'DsButton',
                  useCases: buttonUseCases,
                ),
              ],
            ),
          ],
        ),
      ],
      appBuilder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          home: child,
        );
      },
    );
  }
} 