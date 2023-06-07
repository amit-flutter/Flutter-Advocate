import 'package:advocate/utils/imports.dart';

class FirebaseController extends GetxController {
  static FirebaseController instance = Get.find();

  String firebaseCollectionName = 'client';
  late final CollectionReference client;
  late Stream<QuerySnapshot> clientInfoStream;

  @override
  void onInit() {
    client = FirebaseFirestore.instance.collection(firebaseCollectionName);
    clientInfoStream =
        FirebaseFirestore.instance.collection(firebaseCollectionName).orderBy('time', descending: true).snapshots();
    super.onInit();
  }

  //Add new data to firebase
  Future<void> addNewClient(String name, String number) {
    return client
        .add({'name': name, 'number': number, "time": DateTime.now()})
        .then((value) => Logger.logPrint(title: "Client Added"))
        .catchError((error) => Logger.logPrint(title: "Error: While Client Add", body: error.toString()));
  }

  searchClient(String searchKey) {
    clientInfoStream = FirebaseFirestore.instance.collection(firebaseCollectionName).snapshots();
    print(searchKey);
  }
}
