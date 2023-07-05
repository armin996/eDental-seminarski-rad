import 'dart:io';
import 'package:edental/helpers/navigation_routes.dart';
import 'package:edental/models/theme.dart';
import 'package:edental/providers/appointmentProvider.dart';
import 'package:edental/providers/auth.dart';
import 'package:edental/providers/authService.dart';
import 'package:edental/providers/dentist.dart';
import 'package:edental/providers/paymentService.dart';
import 'package:edental/providers/ratingService.dart';
import 'package:edental/providers/treatmentProvider.dart';
import 'package:edental/providers/userProvider.dart';
import 'package:edental/screens/auth/auth_screen.dart';
import 'package:edental/screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart'
    show JsonMapper, jsonSerializable, JsonProperty;

import 'main.mapper.g.dart' show initializeJsonMapper;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  await dotenv.load();
  Stripe.publishableKey = dotenv.env['PUBLISHABLE_KEY']!;
  HttpOverrides.global =
      MyHttpOverrides(); // if using flutter in web, comment this line
  initializeJsonMapper();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, RatingService>(
            create: (context) => RatingService(),
            update: (context, value, previous) => RatingService(
                username: value.user != null ? value.user!.username : '',
                password: value.user != null ? value.user!.password : ''),
          ),
          ChangeNotifierProxyProvider<Auth, UserService>(
            create: (ctx) => UserService(),
            update: (context, value, previous) => UserService(
              username: value.user != null ? value.user!.username : '',
              password: value.user != null ? value.user!.password : '',
            ),
          ),
          ChangeNotifierProxyProvider<Auth, TreatmentProvider>(
            create: (context) => TreatmentProvider('', ''),
            update: (context, value, previous) =>
                TreatmentProvider(value.user?.username, value.user?.password),
          ),
          ChangeNotifierProxyProvider<Auth, DentistProvider>(
            create: (_) => DentistProvider(null),
            update: (context, value, previous) => DentistProvider(value.user),
          ),
          ChangeNotifierProxyProvider<Auth, AppointmentProvider>(
              create: (_) => AppointmentProvider(null),
              update: (_, value, appointments) =>
                  AppointmentProvider(value.user)),
          ChangeNotifierProxyProvider<Auth, PaymentService>(
              create: (_) => PaymentService(userId: 0),
              update: (_, value, appointments) => PaymentService(
                  userId: value.user?.id ?? 0,
                  username: value.user?.username,
                  password: value.user?.password))
        ],
        child: Consumer<Auth>(
            builder: ((context, value, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                home: value.isAuthenticated
                    ? TabScreen()
                    : const AuthScreen()))));
  }
}
