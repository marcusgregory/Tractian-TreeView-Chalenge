import 'package:flutter/material.dart';
import 'package:treeview_challenge/src/app/presentation/icons/tractian_icons_icons.dart';

import '../../domain/entities/company.entity.dart';

class CompanyCardWidget extends StatelessWidget {
  const CompanyCardWidget({
    super.key,
    required this.onTapCompany,
    required this.company,
  });

  final void Function(String) onTapCompany;
  final CompanyEntity company;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapCompany(company.id),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(
                TractianIcons.company,
                color: Colors.white,
              ),
              const SizedBox(
                width: 16.0,
              ),
              Flexible(
                child: Text(
                  '${company.name} Unit',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
