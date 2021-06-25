import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payflow/modules/barcodeScanner/barcodeScanner_page.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/insertBoleto/insertBoleto_page.dart';
import 'package:payflow/modules/splash/splash_page.dart';
import 'package:payflow/shared/models/user_model.dart';

import 'modules/login/login_page.dart';
import 'shared/themes/appcolors.dart';

class AppWidget extends StatelessWidget {
  // This widget is the root of your application.

  AppWidget() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: AppColors.primary,
          primarySwatch: Colors.orange,
        ),
        initialRoute: '/',
        routes: {
          "/": (context) => SpalshPage(),
          "/home": (context) => HomePage(
                user: ModalRoute.of(context)!.settings.arguments as UserModel,
              ),
          "/login": (context) => LoginPage(),
          "/barcodescanner": (context) => BarcodeScannerPage(),
          "/insertBoleto": (context) => InsertBoletoPage(
                barcode: ModalRoute.of(context) != null
                    ? ModalRoute.of(context)!.settings.arguments.toString()
                    : "",
              ),
        });
  }
}
