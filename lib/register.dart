import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterWidget extends StatefulWidget {
  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  var isChecked = false;
  var isObsecured = true;

  var k = GlobalKey<FormState>();

  var t1 = TextEditingController(); // email
  var t2 = TextEditingController(); // password

  signUp()
  async {
    var fb = FirebaseAuth.instance;
    await fb.createUserWithEmailAndPassword(email: t1.text, password: t2.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: k,
            autovalidateMode: AutovalidateMode.disabled,
            child: ListView(
              children: [
                Text('Register'),
                Divider(),
                TextFormField(
                    autofocus: true,
                    controller: t1,
                    maxLength: 30,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      } else if (value.length < 5) {
                        return "Email minimum 5 character(s)";
                      } else if (value.contains("@") == false) {
                        return "Email invalid format";
                      } else if (value.contains(".") == false) {
                        return "Email invalid format";
                      } else if (EmailValidator.validate(value) == false) {
                        return "Email invalid format";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      labelText: "Your Email",
                      helperText: "Please input your valid email",
                      hintText: "Email",
                      counterText: "",
                      prefixIcon: Icon(Icons.email),
                      suffixIcon: Icon(Icons.check),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                    obscureText: isObsecured,
                    maxLength: 10,
                    controller: t2,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password harus diisi";
                      } else if (value.length < 3) {
                        return "Password minimal 3 karakter";
                      } else if (value.length > 8) {
                        return "Password maksimal 10 karakter";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Your Password",
                      hintText: "Password",
                      counterText: "",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            if (isObsecured == true) {
                              isObsecured = false;
                            } else {
                              isObsecured = true;
                            }
                            setState(() {});
                          },
                          child: Icon(Icons.remove_red_eye)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                    obscureText: isObsecured,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password harus diisi";
                      } else if (value.length < 3) {
                        return "Password minimal 3 karakter";
                      } else if (value.length > 8) {
                        return "Password maksimal 10 karakter";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Re-enter your password",
                      hintText: "Password",
                      counterText: "",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            if (isObsecured == true) {
                              isObsecured = false;
                            } else {
                              isObsecured = true;
                            }
                            setState(() {});
                          },
                          child: Icon(Icons.remove_red_eye)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                    )),
                Row(
                  children: [
                    Checkbox(
                        value: isChecked,
                        onChanged: (val) {
                          isChecked = val!;

                          setState(() {});
                        }),
                    Text("I Agree with term and condition")
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      if (k.currentState!.validate() == true) {
                          signUp();
                          Fluttertoast.showToast(
                          msg: "Register Berhasil",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                        Navigator.pushNamed(context, "login_page");
                      }
                    },
                    child: Text("Register"))
              ],
            ),
          ),
        ));
  }
}
