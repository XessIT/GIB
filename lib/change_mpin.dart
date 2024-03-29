import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'login.dart';
import 'package:http/http.dart'as http;


class ChangeMPin extends StatelessWidget {

  final String userType;
  String? userID;
   ChangeMPin({
     Key? key,
     required this.userType,
     required this. userID,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Change(userType: userType, userID: userID),
    );
  }
}

class Change extends StatefulWidget {
  final String userType;
  String? userID;
   Change({
     Key? key,
     required this.userType,
     required this. userID,
   }) : super(key: key);

  @override
  State<Change> createState() => _ChangeState();
}

class _ChangeState extends State<Change> {
  bool _isObscure = true;
  var Password=" ";
  final _formKey = GlobalKey<FormState>();
  TextEditingController oldpassword = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
String passwordCheck="";
  String getmobile ="";
  List dynamicdata=[];

  Future<void> fetchData(String userId) async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/id_base_details_fetch.php?id=$userId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>) {
          setState(() {
            dynamicdata = responseData.cast<Map<String, dynamic>>();
            if (dynamicdata.isNotEmpty) {
              setState(() {
              passwordCheck = dynamicdata[0]["password"];
              getmobile = dynamicdata[0]["mobile"];
              print("get mobile :$getmobile\n---------- password : $passwordCheck " );
              });
            }
          });
        } else {
          print('Invalid response data format');
        }
      } else {
        // Handle non-200 status code
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other errors
      print('Error: $error');
    }
  }


  Future updatedetails(String password, String id) async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/change_mpin.php');

      final response = await http.post(
        url,
        body: {
          'password': password,
          'id': id,
        },
      );

      if (response.statusCode == 200) {
        print("Response Status: ${response.statusCode}");
        print("Response Body: ${response.body}");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or server errors
      print('Error making HTTP request: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData(widget.userID.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar starts
      appBar: AppBar(
        // Appbar title
        title: const Center(child: Text('Change M-Pin')),
        leading:IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  Home(userType: '', userId: '',)));
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      // Appbar ends

      // Main content starts here
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30,),
                Image.asset('assets/reset-password.jpg',width: 300,),
                const SizedBox(height: 15,),
                // New password textfield starts
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: oldpassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "* Enter Old M-Pin";
                      }
                      else if (value.length < 6) {
                       return "M-Pin should Be 6 Character";
                      }else if(passwordCheck!= value){
                        return "Old Password is Incorrect ";
                      }
                      else if (oldpassword.value == passwordController.value){
                        return "Old And New Password Not Be Same ";
                      }
                      else if (oldpassword.value != passwordController.value){
                        return null;
                      }
                      else {
                        return null;
                      }
                    },
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      labelText: 'Old M-Pin',
                      hintText: 'Enter your Old M-Pin',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6)
                    ],
                  ),),
                const SizedBox(height: 15,),

                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "* Enter New M-Pin";
                      } else if (value.length < 6) {
                        return "M-Pin should Be 6 Character";
                      } else {
                        return null;
                      }
                    },
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      labelText: 'New M-Pin',
                      hintText: 'Enter your New M-Pin',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6)
                    ],
                  ),),
                // New password textfield ends here

                // Confirm password textfield starts here
                const SizedBox(height: 15,),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: confirmpassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "* Enter Confirm M-Pin";
                      } else if (passwordController.value != confirmpassword.value) {
                        return "M-Pin Doesn't match";
                      } else if (passwordController.value == confirmpassword.value){
                        return null;
                      } else {
                        return null;
                      }
                    },
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      labelText: 'Confirm M-Pin',
                      hintText: 'Enter your Confirm M-Pin',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6)
                    ],
                  ),),
                // Confirm password textfield ends here

                const SizedBox(height: 30,),
                // Submit button starts here
                MaterialButton(
                  color: Colors.green,
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        setState(() {

                          Password = passwordController.text;
                        });
                        updatedetails(confirmpassword.text, widget.userID.toString());
                      }

                    },
                    child: const Text('SUBMIT',style: TextStyle(color: Colors.white),)
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
      // Main content ends here
    );
  }
}

