import 'package:advocate/utils/imports.dart';

class RouteConst {
  /// Routes name to directly navigate the route by its name

  static const String kSplash = "/splash";
  static const String kLogin = "/login";
  static const String kHome = "/home";
  static const String kAddClient = "/add-client";
  static const String kClientInfo = "/client-info";

  /// Add this list variable into your GetMaterialApp as the value of getPages parameter.
  /// You can get the reference to the above GetMaterialApp code.
  final List<GetPage> _getPages = [
    GetPage(name: kSplash, page: () => const SplashScreen()),
    GetPage(name: kLogin, page: () => const LoginScreen()),
    GetPage(name: kHome, page: () => const HomeScreen()),
    GetPage(name: kAddClient, page: () => const AddClient()),
    GetPage(name: kClientInfo, page: () => const ClientInfo()),
  ];

  get routePages => _getPages;
}
