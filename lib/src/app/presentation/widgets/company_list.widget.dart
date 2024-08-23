import 'package:flutter/material.dart';

import '../../domain/entities/company.entity.dart';
import 'company_card.widget.dart';

class CompanyListWidget extends StatelessWidget {
  const CompanyListWidget({
    super.key,
    required this.onTapCompany,
    required this.companies,
  });

  final void Function(String) onTapCompany;
  final List<CompanyEntity> companies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: companies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: SizedBox(
              height: 76,
              width: MediaQuery.of(context).size.width,
              child: CompanyCardWidget(
                company: companies[index],
                onTapCompany: onTapCompany,
              ),
            ),
          );
        });
  }
}
