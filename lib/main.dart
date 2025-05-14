import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:registration_ieee/user_model/user_model.dart';
import 'package:registration_ieee/views/splash_screen.dart';

import 'const/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
 await Hive.openBox<UserModel>(user);

  runApp(const RegistrationApp());
}

class RegistrationApp extends StatelessWidget {
  const RegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Splash(),
        );
  }
}
