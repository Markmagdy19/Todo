import 'package:chatt/db/db_helper.dart';
import 'package:chatt/ui/utils/theme_provider.dart';
import 'package:chatt/ui/widgets/navibar.dart';
import 'package:chatt/ui/pages/auth.dart';
import 'package:chatt/ui/pages/chat.dart';
import 'package:chatt/ui/pages/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:chatt/models/services/Localization.dart';

import 'generated/l10n.dart';

/////////////////////////////////
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  const FlutterLocalization();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale:Locale("ar"),

      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
          ? darkThemeData
          : lightThemeData,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            return const Navigatebar();
          }
          return const AuthScreen();
        }),
      ),
    );
  }
}

var lightThemeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.light,
  ),
  useMaterial3: true,
  brightness: Brightness.light,
);
var darkThemeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
  brightness: Brightness.dark,
);
