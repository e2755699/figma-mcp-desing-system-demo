# widgetbook_app


# Figma MCP 元件整合指南

本文檔詳細說明如何使用 Figma Developer MCP 從 Figma 設計中抓取元件，並將其整合到 Flutter 元件庫及 Widgetbook 中。

## 目錄

1. [前置準備](#前置準備)
2. [從 Figma 獲取元件資訊](#從-figma-獲取元件資訊)
3. [實作元件](#實作元件)
4. [在 Widgetbook 中展示元件](#在-widgetbook-中展示元件)
5. [使用範例](#使用範例)

## 前置準備

確保您已完成以下設置：

1. **設置專案結構**：
   - 主專案根目錄
   - `packages/ui_component` 元件庫
   - `widgetbook_app` 元件展示應用

2. **配置 Figma Developer MCP**：
   - 在 `.vscode/settings.json` 中配置 MCP 設定
   - 添加您的 Figma API Token

```json
{
  "mcpServers": {
    "figma-developer-mcp": {
      "command": "npx",
      "args": [
        "-y",
        "figma-developer-mcp",
        "--stdio"
      ],
      "env": {
        "FIGMA_API_KEY": "<your-figma-api-key>"
      }
    }
  }
}
```

3. **配置 Flutter 依賴**：
   - 確保 `ui_component` 包含必要的依賴，例如 `flutter_svg`
   - 確保 `widgetbook_app` 引用了 `ui_component`

## 從 Figma 獲取元件資訊

### 1. 獲取元件數據

使用 MCP Figma API 獲取元件信息：

```dart
// 1. 使用功能函數獲取Figma元件數據
mcp_figma-developer-mcp_get_figma_data(
  fileKey: "vNsplMqtajLAdaEoCX1rWf", // Figma 文件 ID
  nodeId: "2-727" // 元件節點 ID
)
```

這將返回元件的詳細信息，包括：
- 元件名稱、類型
- 元件屬性（變體、尺寸、樣式）
- 子元素和布局信息
- 顏色、文字樣式等

### 2. 下載元件資源

如果元件包含圖標或圖片，可以下載這些資源：

```dart
// 2. 下載元件中使用的圖標或圖片
mcp_figma-developer-mcp_download_figma_images(
  fileKey: "vNsplMqtajLAdaEoCX1rWf",
  localPath: "/packages/ui_component/lib/src/buttons/icons",
  nodes: [
    {
      "nodeId": "I2:727;57994:2327;57994:1164", 
      "fileName": "star_icon.svg"
    }
  ],
  scale: 2
)
```

確保創建必要的目錄結構：

```bash
mkdir -p packages/ui_component/lib/src/buttons/icons
```

## 實作元件

### 1. 分析元件變體和屬性

根據 Figma 數據，確定元件需要哪些參數：

- 確定變體（例如：大小、樣式、形狀）
- 確定可自定義屬性（例如：文本、顏色、圖標）
- 確定交互行為（例如：點擊事件）

### 2. 建立元件枚舉和類型

為元件的變體和屬性創建枚舉：

```dart
/// 按鈕大小
enum DsButtonSize {
  /// 超小型
  xSmall,
  
  /// 小型
  small,
  
  /// 中型
  medium,
  
  /// 大型
  large,
  
  /// 超大型
  xLarge,
}

/// 按鈕型式
enum DsButtonStyle {
  /// 填充式按鈕
  filled,
  
  /// 提升式按鈕
  elevated,
  
  // ... 其他樣式
}

/// 按鈕形狀
enum DsButtonType {
  /// 圓形
  round,
  
  /// 方形
  square,
}
```

### 3. 實作元件類

實作符合 Figma 設計的元件類：

```dart
/// 設計系統按鈕
class DsButton extends StatelessWidget {
  /// 建立一個設計系統按鈕
  const DsButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.showIcon = false,
    this.leadingIcon,
    this.size = DsButtonSize.medium,
    this.buttonStyle = DsButtonStyle.filled,
    this.buttonType = DsButtonType.round,
    this.enabled = true,
  }) : super(key: key);

  /// 按鈕文字
  final String label;
  
  /// 點擊事件處理
  final VoidCallback? onPressed;
  
  /// 是否顯示圖示
  final bool showIcon;
  
  /// 按鈕前方圖示
  final Widget? leadingIcon;
  
  /// 按鈕大小
  final DsButtonSize size;
  
  /// 按鈕型式
  final DsButtonStyle buttonStyle;
  
  /// 按鈕形狀
  final DsButtonType buttonType;
  
  /// 是否啟用
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    // ... 元件實作
  }
  
  // ... 輔助方法
}
```

### 4. 按照 Figma 設計實作元件樣式和行為

實作元件的樣式、尺寸和行為：

```dart
@override
Widget build(BuildContext context) {
  // 依據按鈕大小設定內間距和字體大小
  final padding = _getPadding();
  final textStyle = _getTextStyle(context);
  final containerHeight = _getHeight();
  final iconSize = _getIconSize();
  
  // 依據樣式設定顏色
  final colors = _getButtonColors(context);
  
  // 依據形狀設定圓角
  final borderRadius = _getBorderRadius();
  
  return SizedBox(
    height: containerHeight,
    child: ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.backgroundColor,
        foregroundColor: colors.foregroundColor,
        // ... 其他樣式設定
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showIcon && leadingIcon != null) ...[
            SizedBox(
              width: iconSize,
              height: iconSize,
              child: leadingIcon,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: textStyle,
          ),
        ],
      ),
    ),
  );
}
```

### 5. 實作輔助方法

根據變體設置不同的樣式：

```dart
// 獲取按鈕顏色
_ButtonColors _getButtonColors(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  
  switch (buttonStyle) {
    case DsButtonStyle.filled:
      // 填充按鈕顏色
    case DsButtonStyle.elevated:
      // 提升按鈕顏色
    // ... 其他樣式
  }
}

// 獲取按鈕圓角
BorderRadius _getBorderRadius() {
  switch (buttonType) {
    case DsButtonType.round:
      // 圓形按鈕圓角
    case DsButtonType.square:
      // 方形按鈕圓角
  }
}

// 獲取按鈕內間距
EdgeInsetsGeometry _getPadding() {
  switch (size) {
    case DsButtonSize.xSmall:
      // 超小型按鈕內間距
    // ... 其他尺寸
  }
}

// ... 其他輔助方法
```

### 6. 導出元件

在 `ui_component.dart` 中導出元件：

```dart
// 在 lib/ui_component.dart 中
library ui_component;

export 'src/buttons/button.dart';
export 'src/buttons/ds_button.dart'; // 新增這一行
export 'src/theme/theme.dart';
```

## 在 Widgetbook 中展示元件

### 1. 在 widgetbook_app 中建立展示用例

創建 `button_use_cases.dart` 文件：

```dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ui_component/ui_component.dart';

// 元件變體選項列表
final List<DsButtonStyle> buttonStyleOptions = [
  DsButtonStyle.filled,
  DsButtonStyle.elevated,
  // ... 其他選項
];

// ... 其他選項列表

final buttonUseCases = [
  WidgetbookUseCase(
    name: '基本按鈕',
    builder: (context) {
      // 添加 knob 控制
      final label = context.knobs.string(
        label: '按鈕文字',
        initialValue: '按鈕',
      );
      
      // ... 其他 knob 參數
      
      return Center(
        child: DsButton(
          // ... 元件參數
        ),
      );
    },
  ),
  
  // ... 其他用例
];
```

### 2. 配置 Widgetbook

更新 `widgetbook.dart` 文件：

```dart
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
            // ... 主題設定
          ],
        ),
        DeviceFrameAddon(
          devices: [
            // ... 裝置設定
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
```

### 3. 建立入口文件

更新 `main.dart` 文件：

```dart
import 'package:flutter/material.dart';
import 'package:widgetbook_app/widgetbook.dart';

void main() {
  runApp(const WidgetbookApp());
}
```

## 使用範例

### 元件使用示例

在專案中使用設計系統元件：

```dart
import 'package:flutter/material.dart';
import 'package:ui_component/ui_component.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('示例頁面')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DsButton(
              label: '標準按鈕',
              onPressed: () {},
            ),
            SizedBox(height: 16),
            DsButton(
              label: '外框按鈕',
              buttonStyle: DsButtonStyle.outlined,
              onPressed: () {},
            ),
            // ... 其他元件示例
          ],
        ),
      ),
    );
  }
}
```

### 運行 Widgetbook

使用以下命令運行 Widgetbook 查看元件：

```bash
cd widgetbook_app
flutter run -d chrome
```

## 完整流程總結

1. **從 Figma 獲取元件數據與資源**
   - 使用 MCP 獲取元件詳細信息
   - 下載必要的圖標和圖片資源

2. **分析元件特性**
   - 確定變體、尺寸和樣式
   - 確定可自定義屬性

3. **實作元件**
   - 建立必要的枚舉和類型
   - 實作元件類
   - 按照 Figma 設計實作樣式和行為

4. **在 Widgetbook 中展示**
   - 創建各種用例
   - 添加 knob 控制參數
   - 設置 Widgetbook 配置

5. **測試與使用**
   - 運行 Widgetbook 測試元件
   - 在專案中使用元件

遵循此流程，您可以輕鬆地從 Figma 設計中獲取元件並將其整合到 Flutter 專案中。

## 實際案例 - 從 Figma 抓取圖標按鈕

以下是我們在此專案中實現的一個實際案例：

### 1. 從 Figma 獲取設計信息

我們從 Figma 文件中抓取了一個按鈕元件的設計資訊：

```dart
// 使用 MCP Figma API 獲取按鈕元件信息
mcp_figma-developer-mcp_get_figma_data(
  fileKey: "vNsplMqtajLAdaEoCX1rWf",
  nodeId: "2:727"
)
```

從返回的數據中，我們可以看到這個按鈕具有以下特性：
- 圓形外觀（borderRadius: 100px）
- 帶有星形圖標
- 尺寸為 XSmall
- 使用填充樣式（Filled）
- 主色為 #6750A4
- 文字為白色，字體大小 14px，字重 500

### 2. 下載星形圖標

我們下載了按鈕中使用的星形圖標：

```dart
// 下載星形圖標
mcp_figma-developer-mcp_download_figma_images(
  fileKey: "vNsplMqtajLAdaEoCX1rWf",
  localPath: "lib/src/buttons/icons",
  nodes: [
    {
      "nodeId": "I2:727;57994:2327;57994:1164;54616:25410", 
      "fileName": "star_icon.svg"
    }
  ],
  scale: 2
)
```

### 3. 實作元件

根據從 Figma 獲取的信息，我們實現了按鈕元件，支持多種變體：

```dart
// 在 packages/ui_component/lib/src/buttons/ds_button.dart 中

@override
Widget build(BuildContext context) {
  return SizedBox(
    height: _getHeight(),
    child: ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: _getButtonColors(context).backgroundColor,
        foregroundColor: _getButtonColors(context).foregroundColor,
        padding: _getPadding(),
        elevation: buttonStyle == DsButtonStyle.elevated ? 2 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: _getBorderRadius(),
          side: buttonStyle == DsButtonStyle.outlined
              ? BorderSide(color: Theme.of(context).colorScheme.outline)
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showIcon && leadingIcon != null) ...[
            SizedBox(
              width: _getIconSize(),
              height: _getIconSize(),
              child: leadingIcon,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: _getTextStyle(context),
          ),
        ],
      ),
    ),
  );
}
```

### 4. 在 Widgetbook 中展示

我們在 Widgetbook 中展示了這個按鈕元件的各種變體：

```dart
// 在 widgetbook_app/lib/widgets/button_use_cases.dart 中

final buttonUseCases = [
  WidgetbookUseCase(
    name: '帶圖示的按鈕',
    builder: (context) => Center(
      child: DsButton(
        label: '我的最愛',
        onPressed: () {},
        showIcon: true,
        leadingIcon: SvgPicture.asset(
          'packages/ui_component/lib/src/buttons/icons/star_icon.svg',
          width: 20,
          height: 20,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    ),
  ),
  // ... 其他用例
];
```

### 5. 實際效果

用戶可以在 Widgetbook 中預覽按鈕的不同風格和狀態：
- 不同大小（XSmall 到 XLarge）
- 不同樣式（Filled、Elevated、Tonal、Outlined、Text）
- 不同形狀（圓形、方形）
- 啟用/禁用狀態
- 帶圖標/不帶圖標

### 6. 元件在主應用中的使用

在主應用中使用該按鈕元件非常簡單：

```dart
// 在應用頁面中
DsButton(
  label: '我的最愛',
  onPressed: () {
    // 點擊處理邏輯
  },
  showIcon: true,
  leadingIcon: SvgPicture.asset(
    'packages/ui_component/lib/src/buttons/icons/star_icon.svg',
    colorFilter: ColorFilter.mode(
      Theme.of(context).colorScheme.onPrimary,
      BlendMode.srcIn,
    ),
  ),
)
```
