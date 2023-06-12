import 'package:advocate/utils/extension.dart';
import 'package:advocate/utils/imports.dart';
import 'package:any_link_preview/any_link_preview.dart';

class ClientInfo extends StatefulWidget {
  const ClientInfo({super.key});

  @override
  State<ClientInfo> createState() => _ClientInfoState();
}

class _ClientInfoState extends State<ClientInfo> {
  late TextEditingController _nameController;
  late TextEditingController _clientNumberController;
  late QueryDocumentSnapshot<Object?> userInfo;
  bool isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    setState(() => isLoading = true);
    userInfo = ClientInfoController.instance.clientInfo.value!;
    _nameController = TextEditingController(text: userInfo['name']);
    _clientNumberController = TextEditingController(text: userInfo['number']);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const DefaultText(text: "Client Info")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    //Name
                    WidgetConst.kHeightSpacer(),
                    CustomTextField(
                      title: "Name",
                      keyBoardType: TextInputType.text,
                      textFieldController: _nameController,
                      validation: (value) {
                        if (value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z]").hasMatch(value)) {
                          return 'Enter a valid name!';
                        }
                        return null;
                      },
                    ),

                    //Number
                    WidgetConst.kHeightSpacer(),
                    CustomTextField(
                      title: "Client Number",
                      keyBoardType: TextInputType.text,
                      textFieldController: _clientNumberController,
                      validation: (value) {
                        if (value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z_#@!-]").hasMatch(value)) {
                          return 'Enter a valid client number!';
                        }
                        return null;
                      },
                    ),

                    //Pdf documents
                    Container(
                      height: 500,
                      child: ListView.builder(
                          itemCount: userInfo['fileUrl'].length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                child: Image.network(
                                  userInfo['fileUrl'][index],
                                  errorBuilder: (context, obj, share) {
                                    return Icon(Icons.file_copy_rounded);
                                  },
                                ),
                              ).radius(),
                            );
                          }),
                    ),

                    //Save
                    WidgetConst.kHeightSpacer(heightMultiplier: 2),
                    CustomElevatedButton(onPressed: () {}, text: "Save")
                  ],
                ),
              ),
            ),
    );
  }
}
