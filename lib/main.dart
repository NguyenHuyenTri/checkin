import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:vao_ra/blocs/lang/select_language_notifier.dart';
import 'package:vao_ra/pages/pages.dart';
import 'package:vao_ra/routes/router.gr.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';

import 'blocs/authentication/authentication.dart';
import 'blocs/blocs.dart';
import 'blocs/navigation_bloc_a.dart';
import 'models/models.dart';
import 'models/notification_user.dart';
import 'repositories/auth_prodiver.dart';
import 'shares/shares.dart';

/**
 * @author datnq
 * @Date: 28/01/2021
 *
 * Modification Logs
 * DATE   		AUTHOR 		DESCRIPTION
 * ------------------------------------
 * 28/01/2021	DatNQ		  create project
 */

AppStore appStore = AppStore();

void main() async {
  // SharedPreferences.setMockInitialValues({});
  WidgetsFlutterBinding.ensureInitialized();

  // appStore.setDarkMode(await getBool(isDarkModeOnPref));

  // SharedPreferences preferences = await SharedPreferences.getInstance();

  // WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]);
  // await preferences.clear();
  // runApp(MyApp());

  await Sentry.init(
    (options) {
      options.dsn =
          'https://4bf5c729f81b4d45b52e426d448d46cd@o562031.ingest.sentry.io/5700090';
    },
    appRunner: () => runApp(
      // Injects the Authentication service
      RepositoryProvider<AuthProvider>(
        create: (context) {
          return AuthProvider();
        },
        // Injects the Authentication BLoC
        child: BlocProvider<AuthenticationBloc>(
          create: (context) {
            final authService = RepositoryProvider.of<AuthProvider>(context);
            return AuthenticationBloc(authService)..add(AppLoaded());
          },
          // child: MyApp(),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => NotificationGlobalCount()),
              ChangeNotifierProvider<SelectLanguageNotifier>(
                  create: (_) => SelectLanguageNotifier()),
            ],
            child: MyApp(),
          ),
        ),
      ),
      // MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     future: Future.delayed(Duration(seconds: 3)),
  //     builder: (context, AsyncSnapshot snapshot) {
  //       // Show splash screen while waiting for app resources to load:
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return MaterialApp(
  //           debugShowCheckedModeBanner: false,
  //           home: ItimeSplashScreen(),
  //         );
  //       } else {
  //         // Loading is done, return the app:
  //         return MaterialApp(
  //           title: 'Flutter Demo',
  //           debugShowCheckedModeBanner: false,
  //           localizationsDelegates: [
  //             GlobalMaterialLocalizations.delegate,
  //             GlobalWidgetsLocalizations.delegate,
  //             GlobalCupertinoLocalizations.delegate,
  //           ],
  //           theme: ThemeData(
  //             appBarTheme: AppBarTheme(
  //               elevation: 0, // This removes the shadow from all App Bars.
  //             ),
  //             fontFamily: 'OpenSans',
  //             visualDensity: VisualDensity.adaptivePlatformDensity,
  //             unselectedWidgetColor: itime_main_color,
  //             cursorColor: itime_main_color,
  //             accentColor: itime_main_color,
  //             primaryColor: itime_main_color,
  //             splashColor: itime_main_color,
  //           ),
  //           supportedLocales: [
  //             const Locale('vi', "VN"),
  //             const Locale('en', "US"),
  //           ],
  //           home: MyNavigationRoot(),
  //         );
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0, // This removes the shadow from all App Bars.
        ),
        fontFamily: 'OpenSans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        unselectedWidgetColor: itime_main_color,
        cursorColor: itime_main_color,
        accentColor: itime_main_color,
        primaryColor: itime_main_color,
        splashColor: itime_main_color,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('vi', "VN"),
        const Locale('en', "US"),
      ],
      home: I18n(
        initialLocale: Locale('vi', "VN"),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              // show home page
              return MyNavigationRoot();
              // return HomePage(
              //   user: state.user,
              // );
            }
            // otherwise show login page
            return ItimeLogin();
          },
        ),
      ),
    );
  }
}

class MyNavigationRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBlocA(),
      child: MaterialApp(
        title: 'Bottom Navigation Demo',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0, // This removes the shadow from all App Bars.
          ),
          fontFamily: 'OpenSans',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          unselectedWidgetColor: itime_main_color,
          cursorColor: itime_main_color,
          accentColor: itime_main_color,
          primaryColor: itime_main_color,
          splashColor: itime_main_color,
        ),
        supportedLocales: [
          const Locale('vi', "VN"),
          const Locale('en', "US"),
        ],
        builder: ExtendedNavigator.builder(
          router: AppRouter(),
          initialRoute: Routes.root,
        ),
      ),
    );
  }
}
