import 'package:flutter/material.dart';

import '../../../../core/widgets/app_page_header.dart';
import '../../../../core/widgets/app_search_field.dart';
import '../../../../core/widgets/company_card.dart';

class CompaniesTabView extends StatefulWidget {
  const CompaniesTabView({super.key});

  @override
  State<CompaniesTabView> createState() => _CompaniesTabViewState();
}

class _CompaniesTabViewState extends State<CompaniesTabView> {
  final _searchController = TextEditingController();
  String _query = '';

  static const _companies = [
    (
      name: 'سفره إكسبريس',
      location: 'بغداد',
      specialty: 'رحلات شاملة',
      trips: '24 رحلة',
      rating: '4.9',
      image:
          'https://images.unsplash.com/photo-1488085061387-422e29b40080?w=400&q=80',
    ),
    (
      name: 'كردستان للسياحة',
      location: 'أربيل',
      specialty: 'شمال العراق',
      trips: '18 رحلة',
      rating: '4.8',
      image:
          'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=400&q=80',
    ),
    (
      name: 'العتبات للنقل السياحي',
      location: 'النجف',
      specialty: 'عتبات مقدسة',
      trips: '32 رحلة',
      rating: '4.7',
      image:
          'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=400&q=80',
    ),
    (
      name: 'أهوار الجنوب',
      location: 'ذي قار',
      specialty: 'طبيعة وأهوار',
      trips: '12 رحلة',
      rating: '4.6',
      image:
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&q=80',
    ),
    (
      name: 'بصرة تورز',
      location: 'البصرة',
      specialty: 'جنوب العراق',
      trips: '15 رحلة',
      rating: '4.5',
      image:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400&q=80',
    ),
    (
      name: 'جبال دهوك',
      location: 'دهوك',
      specialty: 'مغامرات',
      trips: '9 رحلات',
      rating: '4.8',
      image:
          'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=400&q=80',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<
      ({
        String name,
        String location,
        String specialty,
        String trips,
        String rating,
        String image,
      })> get _filteredCompanies {
    final q = _query.trim();
    if (q.isEmpty) return _companies;
    return _companies
        .where(
          (c) =>
              c.name.contains(q) ||
              c.location.contains(q) ||
              c.specialty.contains(q),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final companies = _filteredCompanies;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppPageHeader.pagePadding,
        24,
        AppPageHeader.pagePadding,
        120,
      ),
      children: [
        Text(
          'شركات السياحة',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'تعرّف على أفضل الشركات المنظمة للرحلات',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        AppSearchField(
          controller: _searchController,
          hintText: 'ابحث عن شركة أو مدينة...',
          onChanged: (value) => setState(() => _query = value),
        ),
        const SizedBox(height: 20),
        if (companies.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Text('لا توجد نتائج مطابقة'),
            ),
          )
        else
          for (var i = 0; i < companies.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            CompanyCard(
              name: companies[i].name,
              location: companies[i].location,
              specialty: companies[i].specialty,
              tripsCountLabel: companies[i].trips,
              ratingLabel: companies[i].rating,
              imageUrl: companies[i].image,
              onTap: () {},
            ),
          ],
      ],
    );
  }
}
