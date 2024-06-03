import 'package:bgr_logistik/core/initial_binding.dart';
import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/splash/splash_screen.dart';
import 'package:flutter/services.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  initializeDateFormatting('id_ID');
  Intl.defaultLocale = 'id_ID';
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return GetMaterialApp(
      title: 'BGR Logistik',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      home: const SplashScreen(),
    );
  }
}
