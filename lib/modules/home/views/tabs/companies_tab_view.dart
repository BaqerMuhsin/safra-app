import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/services/trips_service.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_page_header.dart';
import '../../../../core/widgets/app_search_field.dart';
import '../../../../core/widgets/company_card.dart';
import '../../../../data/models/company.dart';

class CompaniesTabView extends StatefulWidget {
  const CompaniesTabView({super.key});

  @override
  State<CompaniesTabView> createState() => _CompaniesTabViewState();
}

class _CompaniesTabViewState extends State<CompaniesTabView> {
  final _searchController = TextEditingController();
  final TripsService _trips = Get.find();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Company> get _filteredCompanies {
    final q = _query.trim();
    if (q.isEmpty) return _trips.companies;
    return _trips.companies
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
          const AppEmptyState(
            icon: HugeIconsStrokeRounded.building03,
            title: 'لا توجد نتائج مطابقة',
            message: 'جرّب اسم شركة أو مدينة أخرى',
          )
        else
          for (var i = 0; i < companies.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            CompanyCard(
              name: companies[i].name,
              location: companies[i].location,
              specialty: companies[i].specialty,
              tripsCountLabel: tripsCountLabel(
                _trips.byCompany(companies[i].id).length,
              ),
              ratingLabel: companies[i].rating,
              imageUrl: companies[i].imageUrl,
              onTap: () => Get.toNamed(
                AppRoutes.companyDetails,
                arguments: companies[i],
              ),
            ),
          ],
      ],
    );
  }
}
