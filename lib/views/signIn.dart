import 'package:chat_app/helper/helperfunction.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/chatroom_screen.dart';
import 'package:chat_app/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailtextedittingcontroller =
      new TextEditingController();
  TextEditingController passwordtextedittingcontroller =
      new TextEditingController();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final formkey = GlobalKey<FormState>();
  bool isloading = false;
  QuerySnapshot userinfosnapshot;
  SignMeIn() async {
    if (formkey.currentState.validate()) {
      setState(() {
        isloading = true;
      });
      HelperFunction.saveUserEmailsharedpreferneces(
          emailtextedittingcontroller.text);
      databaseMethods
          .getuserbyUserEmail(emailtextedittingcontroller.text)
          .then((val) {
        userinfosnapshot = val;
        HelperFunction.saveUserNamesharedpreferneces(
            userinfosnapshot.documents[0].data['name']);
      });
      authMethods.SignInwithEmailandPassword(emailtextedittingcontroller.text,
              passwordtextedittingcontroller.text)
          .then((value) {
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
            Spacer(),
            Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailtextedittingcontroller,
                    style: TextStyle(color: Colors.white),
                    decoration: Customised_InputDecoration("email"),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "required"),
                      EmailValidator(errorText: "email not correct")
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
                      RequiredValidator(errorText: "required"),
                      LengthRangeValidator(
                          min: 8, max: 18, errorText: "atleast 8 characters")
                    ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Text(
                "Forget password?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                SignMeIn();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue),
                child: Text(
                  "Sign In",
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
                  "Sign In with Google",
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
                    "Don't have an account? ",
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
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "SignUp now",
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
