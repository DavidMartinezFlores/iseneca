import 'package:flutter/material.dart';
import 'package:iseneca/conf/providers/users_provider.dart';
import 'package:iseneca/presentation/screens/loggin_screen.dart';
import 'package:iseneca/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider()..fillUserList())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: const AppTheme().getTheme(),
        home: const LogginScreen(),
      ),
    );
  }
}
