import 'dart:io';
import 'dart:math';

import 'package:advocate/controller/network/firebase.dart';
import 'package:advocate/screen/widgets/small_widget.dart';
import 'package:advocate/utils/extension.dart';
import 'package:advocate/utils/imports.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddClient extends StatefulWidget {
  const AddClient({super.key});

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _clientNumberController = TextEditingController();
  PlatformFile? _pickedFile;
  UploadTask? _uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() => _pickedFile = result.files.first);
  }

  Future<void> submitForm() async {
    Get.back();

    String name = _nameController.text;
    String number = _clientNumberController.text;
    final path = 'file/$number/${_pickedFile!.name}';
    final file = File(_pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    _uploadTask = ref.putFile(file);

    final TaskSnapshot snapshot = await _uploadTask!.whenComplete(() {});
    final String urlDownload = await snapshot.ref.getDownloadURL();

    Logger.logPrint(title: "Adding new Client", body: "$name - $number");
    await FirebaseController.instance.addNewClient(name, number, urlDownload);
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
                CustomTextField(title: "Name", keyBoardType: TextInputType.text, textFieldController: _nameController),

                //Number
                WidgetConst.kHeightSpacer(),
                CustomTextField(
                    title: "Client Number",
                    keyBoardType: TextInputType.text,
                    textFieldController: _clientNumberController),

                //FilePicker
                WidgetConst.kHeightSpacer(heightMultiplier: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                        child: DefaultText(text: "Choose client documents", maxLines: 2, textAlign: TextAlign.start)),
                    Expanded(child: CustomElevatedButton(onPressed: selectFile, text: "Upload File")),
                    if (_pickedFile != null)
                      Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.only(left: 10),
                        child: _pickedFile!.extension! == "jpeg" ||
                                _pickedFile!.extension! == "jpg" ||
                                _pickedFile!.extension! == "png"
                            ? Image.file(File(_pickedFile!.path!), fit: BoxFit.cover)
                            : const Icon(Icons.picture_as_pdf_outlined, size: 30, color: Colors.green),
                      ).radius()
                  ],
                ),
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
