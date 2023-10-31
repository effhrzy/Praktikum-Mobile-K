import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mikan/view/widgets/bottom_nav_bar.dart';
import 'package:mikan/viewmodels/settings_view_model.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsViewModel viewModel = Get.put(SettingsViewModel());

    Future<void> pickImage(ImageSource source) async {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(source: source);

      if (pickedImage != null) {
        final File imageFile = File(pickedImage.path);
        viewModel.updateProfilePicture(imageFile);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          // Add any actions for the settings page's app bar here
        ],
        centerTitle: true,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.black, // Set the background color to black
        child: Center(
          // Add your settings content here
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              Obx(() {
                final File? profilePictureFile =
                    viewModel.profilePicture.value;
                return CircleAvatar(
                  backgroundImage: profilePictureFile != null
                      ? FileImage(profilePictureFile)
                      : const AssetImage('assets/images/default_user_icon.png') as ImageProvider,
                  radius: 50.0,
                );
              }),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Show a dialog or a bottom sheet to allow the user to choose between camera and gallery.
                  // Then call pickImage with the chosen source.
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.photo_library),
                            title: const Text('Choose from Gallery'),
                            onTap: () {
                              Navigator.pop(context);
                              pickImage(ImageSource.gallery);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo_camera),
                            title: const Text('Take a Photo'),
                            onTap: () {
                              Navigator.pop(context);
                              pickImage(ImageSource.camera);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Change Profile Picture'),
              ),
              // Name
              Obx(() {
                return Text(
                  viewModel.userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                );
              }),
              const SizedBox(height: 8.0),
              // Email
              Obx(() {
                return Text(
                  viewModel.userEmail,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                );
              }),
              const SizedBox(height: 16.0),
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text(
                  'My Orders',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  // Handle the My Orders navigation here
                },
              ),
              ListTile(
                leading: const Icon(Icons.credit_card),
                title: const Text(
                  'Payment Method',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  // Handle the Payment Method navigation here
                },
              ),
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text(
                  'My Books',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  // Handle the My Books navigation here
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text(
                  'Refer Friends',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  // Handle the Refer Friends navigation here
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
