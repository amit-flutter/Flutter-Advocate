import 'package:advocate/utils/imports.dart';

class ClientInfoController extends GetxController {
  static ClientInfoController instance = Get.find();
  final Rx<QueryDocumentSnapshot<Object?>?> clientInfo = (null as QueryDocumentSnapshot<Object?>?).obs;

  // getClientInfo() async {
  //   var collection = FirebaseFirestore.instance.collection(FirebaseController.instance.firebaseCollectionName);
  //   var docSnapShot = await collection.doc(ClientInfoController.instance.clientId.value).get();
  //   if (docSnapShot.exists) {
  //     Map<String,dynamic>? userInfo = docSnapShot.data();
  //   }
  // }
}
