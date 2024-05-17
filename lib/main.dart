import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/colors.dart';
import 'core/themes/theme_change.dart';
import 'screen/splash/ChatSplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://pssndfxvudrocrnaiaml.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBzc25kZnh2dWRyb2NybmFpYW1sIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTUzMTg4OTIsImV4cCI6MjAzMDg5NDg5Mn0.FEd1uE1diq03hzp3_zbH_-4VtTxoyDNa0MuvLAB9hD0',
  );
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeChange(ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: bgColor,
          primarySwatch: Colors.blue,
          textTheme:
              const TextTheme(bodyMedium: TextStyle(color: Colors.black54)),
          fontFamily: "Gordita")),
      child: const ThemeWrapaper(),
    );
  }
}

class ThemeWrapaper extends StatelessWidget {
  const ThemeWrapaper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatApp()
    );
  }
}
