import 'package:flutter/material.dart';

/// 앱 전체에서 사용하는 텍스트 스타일 정의
class AppTextStyles {
  /// 매우 큰 제목 스타일 (예: 화면 메인 제목)
  static TextStyle heading1(BuildContext context) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor.withOpacity(0.8),
      );

  /// 중간 제목 스타일 (예: 섹션 제목)
  static TextStyle heading2(BuildContext context) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor.withOpacity(0.8),
      );

  /// 작은 제목 스타일 (예: 카드 내부 제목)
  static TextStyle heading3(BuildContext context) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor.withOpacity(0.8),
      );

  /// 일반 텍스트 스타일
  static const TextStyle body = TextStyle(
    fontSize: 16,
    height: 1.5,
    color: Color(0xFF333333),
  );

  /// 강조 텍스트 스타일
  static TextStyle bodyEmphasis(BuildContext context) => TextStyle(
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).primaryColor,
      );

  /// 보조 텍스트 스타일 (예: 부가 설명)
  static const TextStyle caption = TextStyle(
    fontSize: 14,
    color: Color(0xFF8080B2),
  );

  /// 매우 작은 보조 텍스트 스타일
  static const TextStyle captionSmall = TextStyle(
    fontSize: 12,
    color: Color(0xFF8080B2),
  );
}
