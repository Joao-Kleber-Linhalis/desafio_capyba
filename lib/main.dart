import 'package:desafio_capyba/core/routes/app_routes.dart';
import 'package:desafio_capyba/features/auth/presentation/screens/auth_screen.dart';
import 'package:desafio_capyba/features/auth/provider/auth_provider.dart';
import 'package:desafio_capyba/features/create/presentation/screens/create_screen.dart';
import 'package:desafio_capyba/features/home/provider/home_provider.dart';
import 'package:desafio_capyba/features/index/presentation/index_screen.dart';
import 'package:desafio_capyba/features/presentation/auth_or_home_screen.dart';
import 'package:desafio_capyba/features/presentation/splash_screen.dart';
import 'package:desafio_capyba/features/profile/presentation/profile_screen.dart';
import 'package:desafio_capyba/features/restricted/provider/restricted_provider.dart';
import 'package:desafio_capyba/features/wheel/presentation/wheel_screen.dart';
import 'package:desafio_capyba/firebase_options.dart';
import 'package:desafio_capyba/shared/constants/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, HomeProvider>(
          create: (_) => HomeProvider(),
          update: (_, auth, previous) => HomeProvider(
            auth.isAuth,
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, RestrictedProvider>(
          create: (_) => RestrictedProvider(),
          update: (_, auth, previous) => RestrictedProvider(
            auth.isAuth,
            auth.isEmailVerified,
            auth.userModel.restrictedItems,
          ),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.appBarBackgroundColor,
          ),
        ),
        routes: {
          AppRoutes.SPLASH: (context) => const SplashScreen(),
          AppRoutes.AUTH_OR_HOME: (context) => const AuthOrHomeScreen(),
          AppRoutes.AUTH_SCREEN: (context) => const AuthScreen(),
          AppRoutes.PROFILE_SCREEN: (context) => const ProfileScreen(),
          AppRoutes.INDEX_SCREEN: (context) => const IndexScreen(),
          AppRoutes.CREATE_SCREEN: (context) => const CreateScreen(),
          AppRoutes.WHEEL_SCREEN: (context) => const WheelScreen(),
        },
      ),
    );
  }
}
