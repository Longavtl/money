import 'app_flavor.dart';

abstract class AppConfigContract {
  AppFlavor get flavor;
  String get appName;
  String get baseUrl;
}
