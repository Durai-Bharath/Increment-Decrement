import 'package:flutter/material.dart';
import 'package:flutter_assignment/model/model.dart';
import 'package:flutter_assignment/screens/signin.dart';
import 'package:flutter_assignment/services/query.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isSame = true;
  late Query query;
  bool isPasswordSame() {
    if (password.text == confirmPassword.text &&
        password.text.isNotEmpty &&
        confirmPassword.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    query = Query();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Align(
        alignment: Alignment.center,
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome !!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: username,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter username',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: password,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'password',
                ),
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: confirmPassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Confirm password',
                ),
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            isSame
                ? SizedBox()
                : const Text(
                    "Passwords do not match.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 16),
                  ),
            SizedBox(
              height: 40,
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  elevation: 1),
              onPressed: () async {
                setState(() {
                  isSame = isPasswordSame();
                });
                if (isSame) {
                  var result = await query.isUserNameExist(username.text);

                  if (!result) {
                    var res = await query.insertUser(Model(
                        name: username.text,
                        password: password.text,
                        value: 0));

                    if (res) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SignIn();
                        },
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Center(
                        child: Text(
                          "Something went wrong ",
                          style: TextStyle(color: Colors.red),
                        ),
                      )));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Center(
                      child: Text(
                        "username already exists",
                        style: TextStyle(color: Colors.red),
                      ),
                    )));
                  }
                }
                // var _data = Data();
                // _data.Title = _titleController.text;
                // _data.Category = _categoryController.text;
                // _data.Description = _descriptionController.text;
                // _data.Date = _dateController.text;
                // _data.Time = _timeController.text;
                // var result = await query.SaveData(_data);
                // print(result);
                // }
              },
              child: const Text(
                'SIGN UP',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account ?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ));
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
