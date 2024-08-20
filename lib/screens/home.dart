// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_assignment/model/model.dart';
import 'package:flutter_assignment/screens/signin.dart';
import 'package:flutter_assignment/services/query.dart';

class Home extends StatefulWidget {
  Model model;
  Home({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String name;
  late int value;
  late Query query;
  @override
  void initState() {
    name = widget.model.name!;
    value = widget.model.value!;
    query = Query();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome  ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24),
            ),
            Text(
              name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignIn();
                    },
                  ),
                  (route) {
                    return false;
                  },
                );
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Current Value",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                value.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightGreen,
                        elevation: 1),
                    onPressed: () async {
                      var res = await query.updateData(Model(
                          name: name,
                          value: value + 1,
                          password: widget.model.password));
                      if (res > 0) {
                        setState(() {
                          value = value + 1;
                        });
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text(
                          "Something went wrong",
                          style: TextStyle(color: Colors.red),
                        )));
                      }
                    },
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red.shade400,
                        elevation: 1),
                    onPressed: () async {
                      if ((value - 1) < 0) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text(
                          "Value can not be negative",
                          style: TextStyle(color: Colors.red),
                        )));
                      } else {
                        var res = await query.updateData(Model(
                            name: name,
                            value: value - 1,
                            password: widget.model.password));
                        if (res > 0) {
                          setState(() {
                            value = value - 1;
                          });
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Text(
                            "Something went wrong",
                            style: TextStyle(color: Colors.red),
                          )));
                        }
                      }
                    },
                    child: const Text(
                      '-',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
