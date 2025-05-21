<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# UI Component

Flutter UI元件庫，提供設計系統組件。

## 功能

- 基礎按鈕元件
- 主題管理
- 更多元件將陸續添加...

## 安裝

將以下內容添加到您的`pubspec.yaml`：

```yaml
dependencies:
  ui_component:
    path: ../packages/ui_component
```

## 使用方法

### 按鈕

```dart
import 'package:ui_component/ui_component.dart';

UIButton(
  text: '按鈕文字',
  onPressed: () {
    print('按鈕被點擊');
  },
);
```

### 主題

```dart
import 'package:ui_component/ui_component.dart';

MaterialApp(
  theme: UITheme.light,
  darkTheme: UITheme.dark,
  // ...
);
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
