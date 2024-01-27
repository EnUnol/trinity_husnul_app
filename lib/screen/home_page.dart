import 'package:flutter/material.dart';

import '../data/data_provider.dart';
import '../theme/color.dart';
import '../screen/contact_profile.dart';
import '../class/contact_profile_class.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late Color myColor;
  late Color appBarColor;
  late Size mediaSize;

  @override
  Widget build(BuildContext context) {
    myColor = AppColors.primaryColor;
    mediaSize = MediaQuery.of(context).size;
    appBarColor = AppColorsImp.infoTextColor;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appBarColor,
        title: Text(
          'Contacts',
          style: TextStyle(
            color: Colors.black, // Set your desired color for the title text
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.search,
              color: myColor), // Set your desired color for the icon
          onPressed: () {
            // Open the drawer or implement search functionality
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add,
                color: myColor), // Set your desired color for the icon
            onPressed: () {
              // Implement add functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.menu,
                color: myColor), // Set your desired color for the icon
            onPressed: () {
              // Open the drawer
              scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
        iconTheme: IconThemeData(
            color: myColor), // Set your desired color for other icons
      ),
      body: Stack(
        children: [
          _buildContactList(),
        ],
      ),
      endDrawer: _buildDrawer(context),
    );
  }

  Widget _buildContactList() {
    return FutureBuilder(
      // Load user data from JSON using DataProvider
      future: DataProvider().fetchData('assets/data/contact_data.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading indicator while data is being fetched
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text('No data available');
        } else {
          Map<String, dynamic> userData = snapshot.data as Map<String, dynamic>;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            padding: EdgeInsets.all(16.0),
            itemCount: userData['contact'].length,
            itemBuilder: (context, index) {
              var contact = userData['contact'][index];
              String title = contact['username'];
              String imagePath = contact['imagePath'];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactProfile(
                          profile: Profile(
                            firstName: contact['firstName'],
                            lastName: contact['lastName'],
                            email: contact['email'],
                            phoneNumber: contact['phone'],
                            dob: contact['DOB'],
                            imagePath: contact['imagePath'],
                          ),
                        ),
                      ),
                    );
                  },
                  child: _buildContactCard(title, imagePath),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildContactCard(String title, String imagePath) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 200.0,
        width: 170.0, // Adjust the height to achieve a 3:4 ratio
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        AppBar(
          automaticallyImplyLeading: false, // To remove the default back button
          title: Text('Menu'),
          actions: [
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                // Close the drawer
              },
            ),
          ],
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            // Navigate to the home screen
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Profile'),
          onTap: () {
            // Navigate to the profile screen
          },
        ),
        ListTile(
          leading: Icon(Icons.menu),
          title: Text('Menu'),
          onTap: () {
            // Navigate to the menu screen
          },
        ),
        Spacer(), // Adds space between menu items and the bottom
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () {
            // Implement logout functionality
            // Provider.of<AuthProvider>(context, listen: false).logout();
            // Navigator.of(context).pop();
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => LoginSignupPage()),
            // );
          },
        ),
      ],
    ),
  );
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
