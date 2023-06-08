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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _clientNumberController = TextEditingController();
  List<PlatformFile?>? _pickedFile;
  UploadTask? _uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    setState(() => _pickedFile = result.files);
  }

  Future<void> submitForm() async {
    //Validate Form first
    final bool isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    _formKey.currentState!.save();

    //get all user data into variable
    List<String> fileUrl = [];
    String name = _nameController.text;
    String number = _clientNumberController.text;
    if (_pickedFile == null) return;
    for (var pickOneFile in _pickedFile!) {
      final path = 'file/$number/${pickOneFile!.name}';
      final file = File(pickOneFile.path!);

      //get firabase storage reference
      final ref = FirebaseStorage.instance.ref().child(path);
      _uploadTask = ref.putFile(file);
      setState(() {});
      final TaskSnapshot snapshot = await _uploadTask!.whenComplete(() {});
      fileUrl.add(await snapshot.ref.getDownloadURL());
    }

    //Add all data to firebase
    // Logger.logPrint(title: "Adding new Client", body: "$name - $number");
    await FirebaseController.instance.addNewClient(name, number, fileUrl);
    setState(() => _uploadTask = null);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const DefaultText(text: "New Client")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                        child: _pickedFile!.first!.extension! == "jpeg" ||
                                _pickedFile!.first!.extension! == "jpg" ||
                                _pickedFile!.first!.extension! == "png"
                            ? Image.file(File(_pickedFile!.first!.path!), fit: BoxFit.cover)
                            : const Icon(Icons.picture_as_pdf_outlined, size: 30, color: Colors.green),
                      ).radius()
                  ],
                ),
                //Submit Button
                WidgetConst.kHeightSpacer(heightMultiplier: 3),

                //Uploading ProgressBar
                Container(
                  height: 45,
                  child: StreamBuilder<TaskSnapshot>(
                    stream: _uploadTask?.snapshotEvents,
                    builder: (context, snapdhot) {
                      if (snapdhot.hasData) {
                        final data = snapdhot.data!;
                        double progress = data.bytesTransferred / data.totalBytes;
                        return SizedBox(
                          height: 50,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              LinearProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.grey,
                              ),
                              Center(
                                child: DefaultText(text: "${(100 * progress).roundToDouble()}%"),
                              )
                            ],
                          ),
                        );
                      } else {
                        return CustomElevatedButton(onPressed: () async => submitForm(), text: "Submit");
                      }
                    },
                  ),
                ).radius(8)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
