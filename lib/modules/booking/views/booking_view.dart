import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../core/theme/app_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_bottom_action_bar.dart';
import '../../../core/widgets/app_circle_icon_button.dart';
import '../../../core/widgets/app_huge_icon.dart';
import '../../../core/widgets/app_info_row.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/app_page_header.dart';
import '../../../core/widgets/app_surface.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../data/models/booking.dart';
import '../controllers/booking_controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    final trip = controller.trip;
    final textTheme = Theme.of(context).textTheme;

    return CustomScaffold(
      appBar: AppPageHeader(title: 'إتمام الحجز', onBack: Get.back),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppPageHeader.pagePadding,
                12,
                AppPageHeader.pagePadding,
                24,
              ),
              children: [
                AppSurface(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: SizedBox(
                          width: 76,
                          height: 76,
                          child: AppNetworkImage(
                            url: trip.imageUrl,
                            iconSize: 26,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              trip.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: AppFonts.elMessiri,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textStrong,
                                height: 1.25,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${trip.dateLabel} · ${trip.durationLabel}',
                              style: const TextStyle(
                                fontFamily: AppFonts.somarSans,
                                fontSize: 12,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text('عدد المسافرين', style: textTheme.titleMedium),
                const SizedBox(height: 10),
                AppSurface(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  child: Obx(
                    () => Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                travelersLabel(controller.travelers.value),
                                style: const TextStyle(
                                  fontFamily: AppFonts.somarSans,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textStrong,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                seatsLeftLabel(trip.seatsLeft),
                                style: const TextStyle(
                                  fontFamily: AppFonts.somarSans,
                                  fontSize: 12,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _StepButton(
                          icon: HugeIconsStrokeRounded.minusSign,
                          enabled: controller.travelers.value > 1,
                          onPressed: controller.decrement,
                        ),
                        SizedBox(
                          width: 44,
                          child: Text(
                            '${controller.travelers.value}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: AppFonts.elMessiri,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textStrong,
                            ),
                          ),
                        ),
                        _StepButton(
                          icon: HugeIconsStrokeRounded.plusSign,
                          enabled:
                              controller.travelers.value <
                              controller.maxTravelers,
                          onPressed: controller.increment,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text('بيانات المسافر الرئيسي', style: textTheme.titleMedium),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.nameController,
                  onChanged: controller.onNameChanged,
                  textInputAction: TextInputAction.done,
                  style: const TextStyle(
                    fontFamily: AppFonts.somarSans,
                    fontSize: 15,
                    color: AppTheme.textStrong,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'الاسم الكامل',
                    hintText: 'كما في الهوية',
                  ),
                ),
                if (controller.phone.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  AppSurface(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    child: AppInfoRow(
                      icon: HugeIconsStrokeRounded.smartPhone01,
                      label: 'رقم الهاتف',
                      value: controller.phone,
                      ltrValue: true,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                Text('طريقة الدفع', style: textTheme.titleMedium),
                const SizedBox(height: 10),
                Obx(
                  () => Column(
                    children: [
                      for (final method in PaymentMethod.values) ...[
                        if (method != PaymentMethod.values.first)
                          const SizedBox(height: 10),
                        _PaymentTile(
                          method: method,
                          selected: controller.paymentMethod.value == method,
                          onTap: () => controller.selectPayment(method),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text('ملخص السعر', style: textTheme.titleMedium),
                const SizedBox(height: 10),
                AppSurface(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  child: Obx(
                    () => Column(
                      children: [
                        AppInfoRow(
                          label: 'السعر للشخص',
                          value: trip.priceLabel,
                        ),
                        AppInfoRow(
                          label: 'عدد المسافرين',
                          value: '× ${controller.travelers.value}',
                        ),
                        const Divider(height: 12, color: AppTheme.border),
                        AppInfoRow(
                          label: 'الإجمالي',
                          value: controller.totalLabel,
                          emphasized: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppBottomActionBar(
            child: Obx(() {
              final loading = controller.isLoading.value;
              final enabled = controller.isValidName.value && !loading;

              return FilledButton(
                onPressed: enabled ? controller.confirm : null,
                style: FilledButton.styleFrom(
                  disabledBackgroundColor: loading
                      ? AppTheme.primary
                      : AppTheme.border,
                  disabledForegroundColor: AppTheme.textHint,
                ),
                child: loading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text('تأكيد الحجز · ${controller.totalLabel}'),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.enabled,
    required this.onPressed,
  });

  final List<List<dynamic>> icon;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppCircleIconButton(
      icon: icon,
      size: 38,
      iconSize: 18,
      backgroundColor: enabled ? AppTheme.primaryLight : AppTheme.background,
      iconColor: enabled ? AppTheme.primary : AppTheme.textHint,
      onPressed: enabled ? onPressed : null,
    );
  }
}

class _PaymentTile extends StatelessWidget {
  const _PaymentTile({
    required this.method,
    required this.selected,
    required this.onTap,
  });

  final PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppSurface.radius);

    return Material(
      color: selected ? AppTheme.primaryLight : AppTheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(
          color: selected ? AppTheme.primary : AppTheme.border,
          width: selected ? 1.5 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              AppHugeIcon(
                icon: method.icon,
                size: 22,
                color: selected ? AppTheme.primary : AppTheme.textSecondary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      method.label,
                      style: const TextStyle(
                        fontFamily: AppFonts.somarSans,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textStrong,
                      ),
                    ),
                    Text(
                      method.hint,
                      style: const TextStyle(
                        fontFamily: AppFonts.somarSans,
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? AppTheme.primary : Colors.transparent,
                  border: Border.all(
                    color: selected ? AppTheme.primary : AppTheme.textHint,
                    width: 1.5,
                  ),
                ),
                child: selected
                    ? const Center(
                        child: AppHugeIcon(
                          icon: HugeIconsStrokeRounded.tick02,
                          size: 14,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
