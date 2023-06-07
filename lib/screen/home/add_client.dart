import 'package:advocate/screen/widgets/small_widget.dart';
import 'package:advocate/utils/imports.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class AddClient extends StatefulWidget {
  const AddClient({super.key});

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  TextEditingController nameController = TextEditingController();
  TextEditingController clientNumberController = TextEditingController();

  void submitForm() {
    String name = nameController.text;
    String number = clientNumberController.text;
    print("Name--> $name Number--> $number");
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
            padding: const EdgeInsets.all(8.0),
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
      child: SizedBox(
        height: 200,
        width: 300,
        child: Stack(
          children: [
            DropzoneView(
              onCreated: (controller) => this.controller = controller,
              onDrop: (dynamic ev) => print('Drop: ${ev.name}'),
            ),
            Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.2),
                      blurRadius: 10.0, // soften the shadow
                      spreadRadius: 5.0, //extend the shadow
                      offset: const Offset(2, 2),
                    )
                  ],
                  // border: Border.all(strokeAlign: 2, color: Colors.white, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.cloud_upload_outlined, size: 40),
                    CustomElevatedButton(
                        onPressed: () async {
                          final events = await controller!.pickFiles();
                          print(events.first.name);
                        },
                        text: "Upload File"),
                    const DefaultText(text: "or drop file"),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
