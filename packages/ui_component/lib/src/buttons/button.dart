import 'package:flutter/material.dart';

/// 基本按鈕元件
class UIButton extends StatelessWidget {
  /// 建立一個標準按鈕
  const UIButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  }) : super(key: key);

  /// 按鈕文字
  final String text;
  
  /// 點擊事件處理
  final VoidCallback onPressed;
  
  /// 背景顏色 (預設使用主題色)
  final Color? backgroundColor;
  
  /// 文字顏色
  final Color? textColor;
  
  /// 邊角圓弧半徑
  final double borderRadius;
  
  /// 內部間距
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
} 