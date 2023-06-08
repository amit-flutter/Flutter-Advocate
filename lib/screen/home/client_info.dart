import 'package:advocate/utils/imports.dart';

class ClientInfo extends StatefulWidget {
  const ClientInfo({super.key});

  @override
  State<ClientInfo> createState() => _ClientInfoState();
}

class _ClientInfoState extends State<ClientInfo> {
  final TextEditingController _nameController = TextEditingController(text: "Amit");
  final TextEditingController _clientNumberController = TextEditingController(text: "#2323");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const DefaultText(text: "Client Info")),
      body: SingleChildScrollView(
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

              //Save
              WidgetConst.kHeightSpacer(heightMultiplier: 2),
              CustomElevatedButton(onPressed: (){}, text: "Save")
            ],
          ),
        ),
      ),
    );
  }
}
