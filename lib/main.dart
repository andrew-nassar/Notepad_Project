import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:untitled2/homepage.dart';
import 'package:untitled2/core/sizeconfig/sizeconig.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize database when app starts.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Untitled 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      
      // إجبار التطبيق على اللغة الإنجليزية والاتجاه من اليسار لليمين (LTR) دائماً
      locale: const Locale('en', 'US'),
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      fallbackLocale: const Locale('en', 'US'),

      // استخدام Builder لضمان تهيئة Sizeconfig بعد إنشاء الـ MediaQuery بنجاح
      home: Builder(
        builder: (innerContext) {
          Sizeconig().init(innerContext); 
          return const Homepage();
        },
      ),
    );
  }
}