import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:chat_app/controllers/appwrite_controllers.dart';
import 'package:chat_app/providers/user_data_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _nameKey = GlobalKey<FormState>();

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  FilePickerResult? _filePickerResult;
  late String? imageID = "";
  late String? userID = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        Provider.of<UserDataProvider>(context, listen: false)
            .loadDataFromLocalDB();
        imageID = Provider.of<UserDataProvider>(context, listen: false)
            .getProfilePicture;
        userID =
            Provider.of<UserDataProvider>(context, listen: false).getUserID;

        // Set the text controllers only once during initialization
        // _nameController.text =
        //     Provider.of<UserDataProvider>(context, listen: false).getUsername;
        // _phoneController.text =
        //     Provider.of<UserDataProvider>(context, listen: false)
        //         .getPhoneNumber;
      }
    });
  }

  const final static void int dynamic bool status

  // open file picker
  void _openFilePicker() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    setState(() {
      _filePickerResult = result;
    });
  }

  Future uploadImage() async {
    try {
      if (_filePickerResult != null && _filePickerResult!.files.isNotEmpty) {
        PlatformFile file = _filePickerResult!.files.first;
        final fileBytes = await File(file.path!).readAsBytes();
        final inputFile =
            InputFile.fromBytes(bytes: fileBytes, filename: file.name);
        //check if image exists
        if (imageID != null && imageID != "") {
          await updateImagefromBucket(oldImage: imageID!, image: inputFile)
              .then((value) {
            if (value != null) {
              imageID = value;
            }
          });
        }
        // create new image and upload to bucket
        else {
          await saveImageToBucket(image: inputFile).then((value) {
            if (value != null) {
              imageID = value;
            }
          });
        }
      } else {
        debugPrint("something went wrong");
      }
    } on AppwriteException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> dataPassed =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Consumer<UserDataProvider>(builder: (context, value, child) {
      // _nameController.text = value.getUsername;
      _phoneController.text = value.getPhoneNumber;
      return Scaffold(
        appBar: AppBar(
          title: Text(
              dataPassed["title"] == "edit" ? "Update Profile" : "Add Details"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .1,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.height * .175,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: _filePickerResult != null
                        ? Image(
                                image: FileImage(
                                    File(_filePickerResult!.files.first.path!)))
                            .image
                        : const Image(image: AssetImage("assets/user.png"))
                            .image,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 32,
                    child: IconButton(
                      onPressed: () {
                        _openFilePicker();
                      },
                      style: IconButton.styleFrom(backgroundColor: Colors.blue),
                      icon: const Icon(
                        Icons.edit_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Form(
              key: _nameKey,
              child: TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value!.isEmpty) return "name cannot be blank!";
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Enter your name",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                hintText: "Phone number",
                enabled: false,
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
            const SizedBox(height: 45),
            FilledButton(
              onPressed: () async {
                if (_nameKey.currentState!.validate()) {
                  // upload image if file is picked
                  await uploadImage();
                }
                // save data to database user collection
                await updateUserData(imageID ?? "",
                    userID: userID!, name: _nameController.text);
              },
              child: const Text("Update"),
            ),
          ],
        ),
      );
    });
  }
}
