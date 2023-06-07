import 'package:advocate/controller/network/firebase.dart';
import 'package:advocate/screen/widgets/small_widget.dart';
import 'package:advocate/utils/imports.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'dart:convert';

class AddClient extends StatefulWidget {
  const AddClient({super.key});

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  TextEditingController nameController = TextEditingController();
  TextEditingController clientNumberController = TextEditingController();
  String base64File = "";

  Future<void> submitForm() async {
    Get.back();
    String name = nameController.text;
    String number = clientNumberController.text;
    Logger.logPrint(title: "Adding new Client", body: "$name - $number");
    await FirebaseController.instance.addNewClient(name, number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DefaultText(text: "New Client Info"),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                //Name
                WidgetConst.kHeightSpacer(),
                CustomTextField(title: "Name", keyBoardType: TextInputType.text, textFieldController: nameController),

                //Number
                WidgetConst.kHeightSpacer(),
                CustomTextField(
                    title: "Client Number",
                    keyBoardType: TextInputType.text,
                    textFieldController: clientNumberController),

                //FilePicker
                WidgetConst.kHeightSpacer(heightMultiplier: 2),
                FileUpload(),
                //Submit Button
                WidgetConst.kHeightSpacer(heightMultiplier: 3),
                CustomElevatedButton(onPressed: () async => submitForm(), text: "Submit")
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FileUpload extends StatelessWidget {
  FileUpload({super.key});

  DropzoneViewController? controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // if (events.isEmpty) {
        //   return;
        // } else {
        //   Logger.logPrint(title: "${events.first.name}");
        //   Logger.logPrint(title: await controller.getFileMIME(events));
        //   Logger.logPrint(title: "${await controller.getFileSize(events)}");
        //   Logger.logPrint(title: "${await controller.getFileData(events)}");
        // }
      },
      hoverColor: Colors.transparent,
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const DefaultText(text: "Choose client documents"),
              CustomElevatedButton(
                  onPressed: () async {
                    final events = await controller!.pickFiles();
                    print(events.first.name);
                  },
                  text: "Upload File"),
            ],
          )),
    );
  }
}
