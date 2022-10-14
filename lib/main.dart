import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_app/views/transactions/transactions_view.dart';
import 'package:provider/provider.dart';
import 'core/constants/design_size.dart';
import 'core/init/locale_manager/lang_hive.dart';
import 'core/init/navigation/navigation_route.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/provider/provider_manager.dart';
import 'core/init/provider/theme_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;
  await Hive.initFlutter();
  Hive.registerAdapter(LangHiveAdapter());
  var box = await Hive.openBox('langBox');
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Future.delayed(const Duration(milliseconds: 2000), () {

    FlutterNativeSplash.remove();
  });
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR')],
      path: 'assets/lang', // <-- change the path of the translation files
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...ProviderManager.instance.singleProvider],
      child: ScreenUtilInit(
        designSize: AppDesignSize.portraitDesignSize,
        builder: (context, child) => ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
            builder: (context, _) {
              final themeProvider = Provider.of<ThemeProvider>(context);
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                themeMode: themeProvider.themeMode,
                theme: MyThemes.lightTheme,
                darkTheme: MyThemes.darkTheme,
                debugShowCheckedModeBanner: false,
                home:const TransactionsView(),
                onGenerateRoute: NavigationRoute.instance.generateRoute,
                navigatorKey: NavigationService.instance.navigatorKey,
              );
            }),
      ),
    );
  }
}
