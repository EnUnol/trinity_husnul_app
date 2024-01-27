import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../auth/auth_cubit.dart';
import '../data/data_provider.dart';
import '../theme/color.dart';
import '../theme/assets.dart';

class LoginSignupPage extends StatefulWidget {
  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final DataProvider dataProvider = DataProvider();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late Color myColor;
  late Size mediaSize;
  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    myColor = AppColors.primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
            color: myColor,
            image: DecorationImage(
                image: AssetImage(Assets.loginPageBg),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                    myColor.withOpacity(0.3), BlendMode.dstATop))),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Positioned(top: 80, child: _topWidget()),
                Positioned(bottom: 0, child: _bottomWidget()),
              ],
            )));
  }

  // top screen items
  Widget _topWidget() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopify_outlined,
            size: 100,
            color: Colors.white,
          ),
          Text(
            "My Contact List App",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  // bottom screen items
  Widget _bottomWidget() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: _LoginForm(),
        ),
      ),
    );
  }

  //Login Form
  Widget _LoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome",
          style: TextStyle(
              color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        _secondaryText("Please login with your information"),
        _builderBlock()
      ],
    );
  }

  //secondary Text Properties
  Widget _secondaryText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.grey,
      ),
    );
  }

  //block builder
  Widget _builderBlock() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input fields for email and password
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            _inputPassword(passwordController, isPassword: true),
            SizedBox(height: 16),
            //remember forgot
            _rememberForgot(),
            SizedBox(height: 16),
            // Login button
            _loginButton(context),
            SizedBox(height: 25),
            _loginOption(),
            SizedBox(height: 20),
          ],
        );
      },
    );
  }

  //password field input
  Widget _inputPassword(TextEditingController passwordController,
      {isPassword = false}) {
    return TextField(
      controller: passwordController,
      obscureText: true, // for password
      decoration: InputDecoration(
          labelText: 'Password',
          suffixIcon:
              isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.done)),
    );
  }

  //login button
  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // Validate input and call login method
        String email = emailController.text;
        String password = passwordController.text;

        if (email.isNotEmpty && password.isNotEmpty) {
          Map<String, dynamic> userData = await dataProvider
              .fetchData('assets/data/credentials/user_data.json');

          // Check if the user exists in the fetched data
          if (_validateUser(email, password, userData)) {
            context.read<AuthCubit>().login();
            Get.toNamed('/home');
          } else {
            // Handle invalid credentials
            // Show an error message or use Get.snackbar() for a temporary message
            Get.snackbar(
                'Invalid Credentials', 'Please check your email and password');
          }
        } else {
          // Handle empty input fields
          // Show an error message or use Get.snackbar() for a temporary message
          Get.snackbar('Empty Fields', 'Email and password cannot be empty');
        }
      },
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          shadowColor: myColor,
          minimumSize: const Size.fromHeight(60)),
      child: Text('Login'),
    );
  }

  //remember or forgot
  Widget _rememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: rememberUser,
                onChanged: (value) {
                  setState(() {
                    rememberUser = value!;
                  });
                }),
            _secondaryText("Remember me"),
          ],
        ),
        TextButton(
            onPressed: () {}, child: _secondaryText("I forgot my password")),
      ],
    );
  }

  Widget _loginOption() {
    return Center(
      child: Column(
        children: [
          _secondaryText("Or login with"),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(icon: Image.asset(Assets.google)),
              Tab(icon: Image.asset(Assets.facebook)),
              Tab(icon: Image.asset(Assets.github)),
            ],
          )
        ],
      ),
    );
  }

  // Helper method to validate user credentials
  bool _validateUser(
      String email, String password, Map<String, dynamic>? userData) {
    print('Entered Email: $email');
    print('Entered Password: $password');

    if (userData == null || !userData.containsKey('users')) {
      print('Error: userData is null or does not contain "users" key.');
      return false;
    }

    var users = userData['users'];
    if (users is! List) {
      print("Error: 'users' key does not contain a List");
      return false;
    }

    for (var user in users) {
      if (user != null &&
          user['email'] == email &&
          user['password'] == password) {
        return true;
      }
    }

    print("User not found for email: $email, password: $password");
    return false;
  }
}
