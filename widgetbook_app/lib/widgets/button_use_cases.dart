import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ui_component/ui_component.dart';

// 按鈕樣式選項列表
final List<DsButtonStyle> buttonStyleOptions = [
  DsButtonStyle.filled,
  DsButtonStyle.elevated,
  DsButtonStyle.tonal,
  DsButtonStyle.outlined,
  DsButtonStyle.text,
];

// 按鈕大小選項列表
final List<DsButtonSize> buttonSizeOptions = [
  DsButtonSize.xSmall,
  DsButtonSize.small,
  DsButtonSize.medium,
  DsButtonSize.large,
  DsButtonSize.xLarge,
];

// 按鈕形狀選項列表
final List<DsButtonType> buttonTypeOptions = [
  DsButtonType.round,
  DsButtonType.square,
];

final buttonUseCases = [
  WidgetbookUseCase(
    name: '基本按鈕',
    builder: (context) {
      // 獲取各種控制參數
      final label = context.knobs.string(
        label: '按鈕文字',
        initialValue: '按鈕',
      );
      
      final showIcon = context.knobs.boolean(
        label: '顯示圖示',
        initialValue: false,
      );
      
      final enabled = context.knobs.boolean(
        label: '啟用',
        initialValue: true,
      );
      
      final buttonStyle = context.knobs.list<DsButtonStyle>(
        label: '按鈕樣式',
        options: buttonStyleOptions,
        initialOption: DsButtonStyle.filled,
        labelBuilder: (value) {
          switch (value) {
            case DsButtonStyle.filled:
              return '填充式';
            case DsButtonStyle.elevated:
              return '提升式';
            case DsButtonStyle.tonal:
              return '色調式';
            case DsButtonStyle.outlined:
              return '外框式';
            case DsButtonStyle.text:
              return '純文字';
          }
        },
      );
      
      final buttonSize = context.knobs.list<DsButtonSize>(
        label: '按鈕大小',
        options: buttonSizeOptions,
        initialOption: DsButtonSize.medium,
        labelBuilder: (value) {
          switch (value) {
            case DsButtonSize.xSmall:
              return '超小';
            case DsButtonSize.small:
              return '小';
            case DsButtonSize.medium:
              return '中';
            case DsButtonSize.large:
              return '大';
            case DsButtonSize.xLarge:
              return '超大';
          }
        },
      );
      
      final buttonType = context.knobs.list<DsButtonType>(
        label: '按鈕形狀',
        options: buttonTypeOptions,
        initialOption: DsButtonType.round,
        labelBuilder: (value) {
          switch (value) {
            case DsButtonType.round:
              return '圓形';
            case DsButtonType.square:
              return '方形';
          }
        },
      );
      
      // 根據選擇配置圖示
      Widget? leadingIcon;
      if (showIcon) {
        leadingIcon = SvgPicture.asset(
          'packages/ui_component/lib/src/buttons/icons/star_icon.svg',
          width: 20,
          height: 20,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        );
      }
      
      // 返回按鈕
      return Center(
        child: DsButton(
          label: label,
          onPressed: enabled ? () {} : null,
          showIcon: showIcon,
          leadingIcon: leadingIcon,
          size: buttonSize,
          buttonStyle: buttonStyle,
          buttonType: buttonType,
          enabled: enabled,
        ),
      );
    },
  ),
  
  // 預定義按鈕樣式
  WidgetbookUseCase(
    name: '填充按鈕 (Filled)',
    builder: (context) => Center(
      child: DsButton(
        label: '確認',
        onPressed: () {},
        buttonStyle: DsButtonStyle.filled,
      ),
    ),
  ),
  
  WidgetbookUseCase(
    name: '提升按鈕 (Elevated)',
    builder: (context) => Center(
      child: DsButton(
        label: '確認',
        onPressed: () {},
        buttonStyle: DsButtonStyle.elevated,
      ),
    ),
  ),
  
  WidgetbookUseCase(
    name: '色調按鈕 (Tonal)',
    builder: (context) => Center(
      child: DsButton(
        label: '確認',
        onPressed: () {},
        buttonStyle: DsButtonStyle.tonal,
      ),
    ),
  ),
  
  WidgetbookUseCase(
    name: '外框按鈕 (Outlined)',
    builder: (context) => Center(
      child: DsButton(
        label: '確認',
        onPressed: () {},
        buttonStyle: DsButtonStyle.outlined,
      ),
    ),
  ),
  
  WidgetbookUseCase(
    name: '文字按鈕 (Text)',
    builder: (context) => Center(
      child: DsButton(
        label: '確認',
        onPressed: () {},
        buttonStyle: DsButtonStyle.text,
      ),
    ),
  ),
  
  // 帶圖示的按鈕
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
  
  // 禁用狀態按鈕
  WidgetbookUseCase(
    name: '禁用按鈕',
    builder: (context) => Center(
      child: DsButton(
        label: '無法點擊',
        onPressed: null,
        enabled: false,
      ),
    ),
  ),
]; 