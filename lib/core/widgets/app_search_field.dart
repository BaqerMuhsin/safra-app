import 'package:flutter/material.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../theme/app_fonts.dart';
import '../theme/app_theme.dart';
import 'app_huge_icon.dart';

/// Reusable search field used across list screens.
class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    this.controller,
    this.hintText = 'ابحث...',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.enabled = true,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool enabled;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      autofocus: autofocus,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      style: const TextStyle(
        fontFamily: AppFonts.somarSans,
        fontSize: 14,
        color: AppTheme.textStrong,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppTheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        prefixIcon: const Padding(
          padding: EdgeInsetsDirectional.only(start: 14, end: 8),
          child: AppHugeIcon(
            icon: HugeIconsStrokeRounded.search01,
            size: 18,
            color: AppTheme.textHint,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 24,
        ),
        suffixIcon: controller == null
            ? null
            : ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller!,
                builder: (context, value, _) {
                  if (value.text.isEmpty) return const SizedBox.shrink();
                  return IconButton(
                    tooltip: 'مسح',
                    onPressed: () {
                      controller!.clear();
                      onClear?.call();
                      onChanged?.call('');
                    },
                    icon: const AppHugeIcon(
                      icon: HugeIconsStrokeRounded.cancel01,
                      size: 16,
                      color: AppTheme.textHint,
                    ),
                  );
                },
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppTheme.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppTheme.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppTheme.primary, width: 1.5),
        ),
      ),
    );
  }
}
