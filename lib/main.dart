import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/app/data/injection/app_dependency.injection.dart';
import 'src/app/presentation/pages/asset_tree.page.dart';
import 'src/app/presentation/pages/company_list.page.dart';
import 'src/app/presentation/app_theme/my_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const TreeViewApp());
}

class TreeViewApp extends StatelessWidget {
  const TreeViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tractian TreeView Challenge',
      debugShowCheckedModeBanner: false,
      initialRoute: CompanyListPage.routePath,
      initialBinding: AppDependencyInjection(),
      theme: myTheme,
      getPages: [
        GetPage(
          name: CompanyListPage.routePath,
          page: () => const CompanyListPage(),
        ),
        GetPage(
          name: AssetTreePage.routePath,
          page: () => const AssetTreePage(),
        ),
      ],
    );
  }
}
