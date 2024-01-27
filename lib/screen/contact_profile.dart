import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../class/contact_profile_class.dart';
import '../theme/color.dart';
import '../data/data_provider.dart';

class ContactProfile extends StatefulWidget {
  final Profile profile;

  ContactProfile({required this.profile});

  @override
  _ContactProfileState createState() => _ContactProfileState();
}

class _ContactProfileState extends State<ContactProfile> {
  late Color myColor;
  late Color appBarColor;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController dobController;

  @override
  void initState() {
    super.initState();
    myColor = AppColors.primaryColor;
    appBarColor = AppColorsImp.infoTextColor;

    // Initialize controllers with existing profile values
    firstNameController = TextEditingController(text: widget.profile.firstName);
    lastNameController = TextEditingController(text: widget.profile.lastName);
    emailController = TextEditingController(text: widget.profile.email);
    phoneController = TextEditingController(text: widget.profile.phoneNumber);
    dobController = TextEditingController(text: widget.profile.dob);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appBarColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                double maxWidth = constraints.maxWidth;
                return Container(
                  constraints: BoxConstraints(
                    maxWidth: maxWidth,
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10.0),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: myColor,
                      fontSize: 18,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCircleImage(),
            SizedBox(height: 16.0),
            _informationContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleImage() {
    return CircleAvatar(
      radius: 60.0,
      backgroundImage: AssetImage(widget.profile.imagePath),
    );
  }

  Widget _informationContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelModule("Main Information"),
        _underlineSeizeBox(),
        _buildMainInformation(),
        SizedBox(height: 16.0),
        _labelModule("Sub Information"),
        _underlineSeizeBox(),
        _buildSubInformation(),
      ],
    );
  }

  Widget _underlineSeizeBox() {
    return SizedBox(
      height: 10,
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _labelModule(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _inputInformation(String labelName, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                labelName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 16.0),
          _textFieldInput(controller),
        ],
      ),
    );
  }

  Widget _textFieldInput(TextEditingController controller) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextField(
              controller: controller,
              style: TextStyle(
                fontSize: 16.0,
              ),
              decoration: InputDecoration(
                border: InputBorder.none, // Remove the outline
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainInformation() {
    return Column(
      children: [
        _inputInformation('First Name', firstNameController),
        _underlineSeizeBox(),
        _inputInformation('Last Name', lastNameController),
        _underlineSeizeBox(),
        SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildSubInformation() {
    return Column(
      children: [
        _inputInformation('Email', emailController),
        _underlineSeizeBox(),
        _inputInformation('Phone', phoneController),
        _underlineSeizeBox(),
        _inputInformation('DOB', dobController),
        _underlineSeizeBox(),
        SizedBox(height: 8.0),
      ],
    );
  }

  void _saveChanges() async {
    // // Update profile values with the edited text field values
    // widget.profile.firstName = firstNameController.text;
    // widget.profile.lastName = lastNameController.text;
    // widget.profile.email = emailController.text;
    // widget.profile.phoneNumber = phoneController.text;
    // widget.profile.dob = dobController.text;

    // // Get the existing id and username
    // String existingId = widget.profile.id;
    // String existingUsername = widget.profile.userName;
    // String existingImagePath = widget.profile.imagePath;

    // // Create a map with the updated profile data, including the existing id and username
    // Map<String, dynamic> updatedData = {
    //   'contact': [
    //     {
    //       'id': existingId,
    //       'username': existingUsername,
    //       'email': widget.profile.email,
    //       'firstName': widget.profile.firstName,
    //       'lastName': widget.profile.lastName,
    //       'DOB': widget.profile.dob,
    //       'phone': widget.profile.phoneNumber,
    //       'imagePath': existingImagePath,
    //     },
    //   ],
    // };

    // // Save changes to the JSON file
    // await DataProvider()
    //     .overwriteData('assets/data/contact_data.json', updatedData);

    // // Pop the page to navigate back
    Navigator.of(context).pop();
  }
}
