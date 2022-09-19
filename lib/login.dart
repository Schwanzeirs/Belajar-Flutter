import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginWidget extends StatelessWidget {
  var t = GlobalKey<FormState>();

  var t1 = TextEditingController(); 
  var t2 = TextEditingController(); 

  signIn()
  async {
    var email = t1.text;
    var password = t2.text;
    var fb = FirebaseAuth.instance;
    try{
      var user = 
      await fb.signInWithEmailAndPassword(email: email, password: password);
      return "OK";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: t,
          autovalidateMode: AutovalidateMode.disabled,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Image.asset(
                  "images/06.png",
                  width: 350,
                  height: 150,
                )),
              ),
              TextFormField(
                controller: t1,
                autofocus: true,
                maxLength: 40,
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
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  helperStyle: TextStyle(color: Colors.blueGrey),
                  counterText: "",
                  prefixIcon: Icon(Icons.mail),
                  suffixIcon: Icon(Icons.done),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                  hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.amber,
                      fontStyle: FontStyle.italic),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: t2,
                obscureText: true,
                maxLength: 20,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password harus diisi";
                  } else if (value.length < 3) {
                    return "Password minimal 3 karakter";
                  } else if (value.length > 8) {
                    return "Password maksimal 8 karakter";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    helperStyle: TextStyle(color: Colors.cyan),
                    hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.amber,
                        fontStyle: FontStyle.italic),
                    counterText: "",
                    labelText: "Your Password",
                    helperText: "Please input your valid password",
                    hintText: "Password"),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (t.currentState!.validate() == true) {
                      var result = await signIn();
                      print(result.toString());
                      if (result == "OK") {
                        Navigator.pushNamed(context, "home_page");
                        Fluttertoast.showToast(
                        msg: "Login Berhasil",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);;
                        }
                      else {
                        Fluttertoast.showToast(
                        msg: "Email/Password salah",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);;
                      } 
                      }
                    },
                  child: Text("Login")),
              TextButton(onPressed: () {
                Navigator.pushNamed(context, "register_page");
              }, child: Text("Register"))
            ],
          ),
        ),
      ),
    );
  }
}
