import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  
  /// 色調式按鈕
  tonal,
  
  /// 外框式按鈕
  outlined,
  
  /// 純文字按鈕
  text,
}

/// 按鈕形狀
enum DsButtonType {
  /// 圓形
  round,
  
  /// 方形
  square,
}

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
          disabledBackgroundColor: colors.disabledBackgroundColor,
          disabledForegroundColor: colors.disabledForegroundColor,
          padding: padding,
          elevation: buttonStyle == DsButtonStyle.elevated ? 2 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
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
  
  /// 獲取按鈕顏色
  _ButtonColors _getButtonColors(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    switch (buttonStyle) {
      case DsButtonStyle.filled:
        return _ButtonColors(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
        );
      case DsButtonStyle.elevated:
        return _ButtonColors(
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.primary,
          disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
        );
      case DsButtonStyle.tonal:
        return _ButtonColors(
          backgroundColor: colorScheme.secondaryContainer,
          foregroundColor: colorScheme.onSecondaryContainer,
          disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
        );
      case DsButtonStyle.outlined:
        return _ButtonColors(
          backgroundColor: Colors.transparent,
          foregroundColor: colorScheme.primary,
          disabledBackgroundColor: Colors.transparent,
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
        );
      case DsButtonStyle.text:
        return _ButtonColors(
          backgroundColor: Colors.transparent,
          foregroundColor: colorScheme.primary,
          disabledBackgroundColor: Colors.transparent,
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
        );
    }
  }
  
  /// 獲取按鈕圓角
  BorderRadius _getBorderRadius() {
    double radius;
    
    switch (buttonType) {
      case DsButtonType.round:
        radius = 100;
        break;
      case DsButtonType.square:
        radius = 4;
        break;
    }
    
    return BorderRadius.circular(radius);
  }
  
  /// 獲取按鈕內間距
  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case DsButtonSize.xSmall:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case DsButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case DsButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 10);
      case DsButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 28, vertical: 12);
      case DsButtonSize.xLarge:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 14);
    }
  }
  
  /// 獲取按鈕高度
  double _getHeight() {
    switch (size) {
      case DsButtonSize.xSmall:
        return 32;
      case DsButtonSize.small:
        return 40;
      case DsButtonSize.medium:
        return 48;
      case DsButtonSize.large:
        return 56;
      case DsButtonSize.xLarge:
        return 64;
    }
  }
  
  /// 獲取圖示大小
  double _getIconSize() {
    switch (size) {
      case DsButtonSize.xSmall:
        return 16;
      case DsButtonSize.small:
        return 18;
      case DsButtonSize.medium:
        return 20;
      case DsButtonSize.large:
        return 22;
      case DsButtonSize.xLarge:
        return 24;
    }
  }
  
  /// 獲取文字樣式
  TextStyle _getTextStyle(BuildContext context) {
    final baseTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      letterSpacing: 0.0714,
    );
    
    switch (size) {
      case DsButtonSize.xSmall:
        return baseTextStyle.copyWith(fontSize: 14);
      case DsButtonSize.small:
        return baseTextStyle.copyWith(fontSize: 14);
      case DsButtonSize.medium:
        return baseTextStyle.copyWith(fontSize: 16);
      case DsButtonSize.large:
        return baseTextStyle.copyWith(fontSize: 16);
      case DsButtonSize.xLarge:
        return baseTextStyle.copyWith(fontSize: 18);
    }
  }
}

/// 按鈕顏色設定
class _ButtonColors {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color disabledBackgroundColor;
  final Color disabledForegroundColor;
  
  const _ButtonColors({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.disabledBackgroundColor,
    required this.disabledForegroundColor,
  });
} 