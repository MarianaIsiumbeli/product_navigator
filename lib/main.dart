import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/lists_page.dart';
import 'app_state.dart';
import 'search_state.dart'; 
import 'pages/home_page.dart';
import 'pages/auth_page.dart';
import 'pages/search_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState()),
        ChangeNotifierProvider(create: (context) =>SearchState()), 
      ],
      child: Consumer<AppState>(
        builder: (context, appState, child) {
          return MaterialApp(
            title: 'Product Navigator',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.lightBlue,
                brightness:
                    appState.isDarkMode ? Brightness.dark : Brightness.light,
              ),
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor:
                  appState.isDarkMode ? Colors.black : Colors.white,
              appBarTheme: AppBarTheme(
                backgroundColor:
                    appState.isDarkMode ? Colors.black : Colors.lightBlue,
                foregroundColor: Colors.white,
              ),
              textTheme: const TextTheme(
                titleLarge: TextStyle(color: Colors.white),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => const HomePage(),
              '/auth': (context) => const AuthPage(isLogin: true),
              '/search': (context) => const SearchPage(),
              '/lists': (context) =>  const ListsPage(),
            },
          );
        },
      ),
    );
  }
}
