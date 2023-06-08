import 'package:advocate/controller/network/firebase.dart';
import 'package:advocate/screen/widgets/small_widget.dart';
import 'package:advocate/utils/imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchKey = '';

  @override
  void initState() {
    Get.put(FirebaseController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Top Restaurant Near You 🍱")),
      body: Column(
        children: [
          //Search Bar
          ListTile(
            title: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => searchKey = value),
              decoration: const InputDecoration(
                hintText: "🔍  Search restaurant by Name, Km, Rating ",
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => setState(() {
                searchKey = "";
                _searchController.clear();
              }),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseController.instance.clientInfoStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) return const Text('Something went wrong');

                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        if (searchKey.isEmpty) return HomeClientCard(snapshot.data!.docs[index]);
                        if (snapshot.data!.docs[index]['name'].toString().contains(searchKey)) {
                          return HomeClientCard(snapshot.data!.docs[index]);
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
                  }

                  return const Text("loading");
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () => Get.toNamed(RouteConst.kAddClient), child: const Icon(Icons.add)),
    );
  }
}

class HomeClientCard extends StatelessWidget {
  const HomeClientCard(this.snapShotData, {super.key});

  final QueryDocumentSnapshot<Object?> snapShotData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(3),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0"
                ".3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            WidgetConst.kWidthSpacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultText(
                  text: snapShotData['name'].toString().capitalizeFirst!,
                  style: Get.textTheme.titleLarge!,
                ),
                DefaultText(
                  text: snapShotData['number'].toString(),
                  style: Get.textTheme.titleMedium!,
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.keyboard_arrow_right_rounded),
          ],
        ),
      ),
    );
  }
}
