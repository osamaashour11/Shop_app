import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/shop_layout/shop_layout.dart';
import 'package:flutter_shop_app/modules/login_screen/Login_screen.dart';
import 'package:flutter_shop_app/modules/splach_screen/splach_screen.dart';
import 'package:flutter_shop_app/shared/constants/bloc_observer.dart';
import 'package:flutter_shop_app/shared/constants/constants.dart';
import 'package:flutter_shop_app/shared/network/local/shared_preferences/cache_helper.dart';
import 'package:flutter_shop_app/shared/network/remote/dio/dio_helper.dart';
import 'package:flutter_shop_app/shared/shop_bloc/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  onBoarding == true ? onBoarding : onBoarding = false;

  Widget? widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      onBoarding == true
          ? widget = LoginScreen()
          : widget = const SplashScreen();
    }
  }
  runApp(MyApp(
    widget: widget!,
  ));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  MyApp({
    required this.widget,
  }) : super();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopAppCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoritesData()
            ..getUserData(),
        ),
      ],
      child: MaterialApp(
        title: 'Shop App',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: defultApplicationColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.00,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            titleTextStyle: TextStyle(
              color: defultApplicationColor,
            ),
            iconTheme: IconThemeData(
              color: defultApplicationColor,
            ),
            actionsIconTheme: IconThemeData(
              color: defultApplicationColor,
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            elevation: 0.00,
            backgroundColor: Colors.white,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: widget,
      ),
    );
  }
}
