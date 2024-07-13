import 'package:cloudnine/DataProvider/master.dart';
import 'package:cloudnine/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloudnine/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instance.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MasterDataProvider()..fetchMasterData()),
      ],
      child: MyApp(),
    ),
  );
  /*runApp(
    ChangeNotifierProvider(
      create: (context) => MasterDataProvider()..fetchMasterData(),
      child: MyApp(),
    ),
  );*/
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CloudNine',
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color(0xFF31274F)),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
