import 'package:flutter/material.dart';
import 'package:ui_component/ui_component.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Figma MCP Demo',
      theme: UITheme.light,
      darkTheme: UITheme.dark,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Figma MCP Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'UI元件庫演示',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 48),
            UIButton(
              text: '標準按鈕',
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            UIButton(
              text: '紅色按鈕',
              backgroundColor: Colors.red,
              textColor: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
