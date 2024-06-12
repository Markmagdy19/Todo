import 'package:chatt/ui/widgets/navibar.dart';
import 'package:chatt/ui/pages/auth.dart';
import 'package:chatt/ui/pages/chat.dart';
import 'package:chatt/ui/pages/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
/////////////////////////////////
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
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
    return MaterialApp(

      title: 'Flutter Demo',
      theme: ThemeData(




        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),


      home: StreamBuilder( stream: FirebaseAuth.instance.authStateChanges(),builder: ((context , snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const SplashScreen();
        }
        if(snapshot.hasData){
          return const Navigatebar();
        }
        return const AuthScreen();


      }),
      ),
    );
  }
}



