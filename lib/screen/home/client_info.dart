import 'package:advocate/utils/imports.dart';

class ClientInfo extends StatelessWidget {
  const ClientInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }

//   CollectionReference client = FirebaseFirestore.instance.collection('client');
//
//   return FutureBuilder<DocumentSnapshot>(
//     //Fetching data from the documentId specified of the student
//     future: students.doc(documentId).get(),
//     builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//       //Error Handling conditions
//       if (snapshot.hasError) {
//         return Text("Something went wrong");
//       }
//
//       if (snapshot.hasData && !snapshot.data!.exists) {
//         return Text("Document does not exist");
//       }
//
//       //Data is output to the user
//       if (snapshot.connectionState == ConnectionState.done) {
//         Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//         return Text("Full Name: ${data['full_name']} ${data['last_name']}");
//       }
//
//       return Text("loading");
//     },
//   );
// }
}
