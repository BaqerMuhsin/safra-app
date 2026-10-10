import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../core/services/session_service.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/app_feedback.dart';
import '../../../core/widgets/app_bottom_action_bar.dart';
import '../../../core/widgets/app_info_row.dart';
import '../../../core/widgets/app_page_header.dart';
import '../../../core/widgets/app_surface.dart';
import '../../../core/widgets/custom_scaffold.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final SessionService _session = Get.find();
  late final _nameController = TextEditingController(text: _session.name.value);

  bool get _canSave {
    final name = _nameController.text.trim();
    return name.length >= 3 && name != _session.name.value.trim();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _save() {
    _session.name.value = _nameController.text.trim();
    Get.back();
    showAppSnack('تم حفظ الملف الشخصي');
  }

  @override
  Widget build(BuildContext context) {
    final name = _nameController.text.trim();
    final initial = name.isEmpty
        ? _session.initial
        : String.fromCharCodes(name.runes.take(1));

    return CustomScaffold(
      appBar: AppPageHeader(title: 'الملف الشخصي', onBack: Get.back),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppPageHeader.pagePadding,
                20,
                AppPageHeader.pagePadding,
                24,
              ),
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 44,
                    backgroundColor: AppTheme.primaryLight,
                    child: Text(
                      initial,
                      style: const TextStyle(
                        fontFamily: AppFonts.elMessiri,
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                TextField(
                  controller: _nameController,
                  onChanged: (_) => setState(() {}),
                  textInputAction: TextInputAction.done,
                  style: const TextStyle(
                    fontFamily: AppFonts.somarSans,
                    fontSize: 15,
                    color: AppTheme.textStrong,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'الاسم الكامل',
                    hintText: 'اكتب اسمك',
                  ),
                ),
                if (_session.phone.value.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  AppSurface(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    child: AppInfoRow(
                      icon: HugeIconsStrokeRounded.smartPhone01,
                      label: 'رقم الهاتف',
                      value: _session.phone.value,
                      ltrValue: true,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'رقم الهاتف مرتبط بحسابك ولا يمكن تغييره من هنا.',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
          AppBottomActionBar(
            child: FilledButton(
              onPressed: _canSave ? _save : null,
              style: FilledButton.styleFrom(
                disabledBackgroundColor: AppTheme.border,
                disabledForegroundColor: AppTheme.textHint,
              ),
              child: const Text('حفظ التغييرات'),
            ),
          ),
        ],
      ),
    );
  }
}
