import 'package:advocate/utils/imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List _restaurantsData = [
    ["Loyal Fire", "5", "10"],
    ["Momento", "4", "12"],
    ["Zesty", "4.5", "2"],
    ["Pizzahut", "3", "5"],
  ];

  final List _searchResultData = [];

  void getMatch() {
    String value = _searchController.text;
    for (var item in _restaurantsData) {
      if (item[0].contains(value) || item[1] == value || item[2] == value && !_searchResultData.contains(item)) {
        setState(() => _searchResultData.add(item));
      }
      if (value == "") setState(() => _searchResultData.clear());
    }
  }

  void clearSearch() {
    setState(() {
      _searchController.text = "";
      _searchResultData.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Top Restaurant Near You 🍱")),
      body: Column(
        children: [
          ListTile(
            title: TextField(
              controller: _searchController,
              onChanged: (value) => getMatch(),
              decoration: const InputDecoration(
                hintText: "🔍  Search restaurant by Name, Km, Rating ",
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
              ),
            ),
            trailing: IconButton(icon: const Icon(Icons.clear), onPressed: () => clearSearch()),
          ),
          Expanded(
            child: _searchResultData.isEmpty
                ? RestaurantListView(listData: _restaurantsData)
                : RestaurantListView(listData: _searchResultData),
          ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () => Get.toNamed(RouteConst.kAddClient), child: const Icon(Icons.add)),
    );
  }
}

class RestaurantListView extends StatelessWidget {
  const RestaurantListView({super.key, required this.listData});

  final List listData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(listData[index][0]),
            leading: SizedBox(
              width: 50,
              child: Row(
                children: [
                  const Icon(Icons.star),
                  Text(listData[index][1]),
                ],
              ),
            ),
            trailing: Text("${listData[index][2]} Km"),
          );
        });
  }
}
