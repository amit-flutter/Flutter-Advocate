import 'package:advocate/utils/imports.dart';

class AppCommonController extends GetxController {
  // Rx<PackageInfo> packageInfo = PackageInfo(appName: "", packageName: "", version: "", buildNumber: "").obs;

  @override
  Future<void> onInit() async {
    // packageInfo.value = await PackageInfo.fromPlatform();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
