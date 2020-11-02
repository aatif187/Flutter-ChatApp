import 'package:chat_app/helper/helperfunction.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'chatroom_screen.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernametextedittingcontroller =
      new TextEditingController();
  TextEditingController emailtextedittingcontroller =
      new TextEditingController();
  TextEditingController passwordtextedittingcontroller =
      new TextEditingController();
  bool isloading = false;
  final formkey = GlobalKey<FormState>();
  AuthMethods authmethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  signmeUp() {
    if (formkey.currentState.validate()) {
      setState(() {
        isloading = true;
      });
      authmethods.SignUpwithEmailandPassword(emailtextedittingcontroller.text,
              passwordtextedittingcontroller.text)
          .then((value) {
        Map<String, String> userMap = {
          "name": usernametextedittingcontroller.text,
          "email": emailtextedittingcontroller.text,
        };
        HelperFunction.saveUserEmailsharedpreferneces(
            emailtextedittingcontroller.text);
        HelperFunction.saveUserNamesharedpreferneces(
            usernametextedittingcontroller.text);
        databaseMethods.UploadUserInfo(userMap);
        HelperFunction.saveUserLoggedInsharedpreferneces(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Default_appbar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: <Widget>[
            Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: usernametextedittingcontroller,
                    style: TextStyle(color: Colors.white),
                    decoration: Customised_InputDecoration("username"),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "requird"),
                      LengthRangeValidator(
                          min: 6,
                          max: 17,
                          errorText: "username must be of 6 characters")
                    ]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: emailtextedittingcontroller,
                    style: TextStyle(color: Colors.white),
                    decoration: Customised_InputDecoration("email"),
                    validator: MultiValidator([
                      EmailValidator(errorText: "email not correct"),
                      RequiredValidator(errorText: "required")
                    ]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: passwordtextedittingcontroller,
                    style: TextStyle(color: Colors.white),
                    decoration: Customised_InputDecoration("password"),
                    validator: MultiValidator([
                      LengthRangeValidator(
                          min: 8, max: 18, errorText: "atleast 8 chacters"),
                      RequiredValidator(errorText: "required")
                    ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                //todo
                signmeUp();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                padding: EdgeInsets.symmetric(vertical: 16),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Sign Up with Google",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.toggle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Login now",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
