// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart'as http;
// import 'login.dart';
// import 'new_mpin.dart';
//
// class ForgotMPin extends StatelessWidget {
//   const ForgotMPin({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Forgot(),
//     );
//   }
// }
//
// class Forgot extends StatefulWidget {
//   const Forgot({Key? key}) : super(key: key);
//
//   @override
//   State<Forgot> createState() => _ForgotState();
// }
//
// class _ForgotState extends State<Forgot> {
//
//   final _formKey = GlobalKey<FormState>();
//
//   FirebaseAuth auth = FirebaseAuth.instance;
//   String verificationIDRecieved = "";
//
//   bool otpcodevisible = false;
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController otpCodeController = TextEditingController();
//
//   final TextEditingController mobileController = TextEditingController();
//   final TextEditingController newpasswordcontroller = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;final regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
//   GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//   String? userId;
//   String passwords ="";
//   String mobile ="";
//
//   Future _getDataFromDatabasae() async {
//     await  FirebaseFirestore.instance
//         .collection("Register")
//         .where("Mobile",isEqualTo: mobileController.text.trim())
//         .get()
//         .then((snapshot) async {
//       if (snapshot.docs.isNotEmpty) {
//         final data = snapshot.docs.first.data();
//         setState(() {
//
//           // passwords=data["Password"];
//
//         });
//       }
//     });
//
//   }
//   Future<void> updatePassword(String email, String password) async {
//     try {
//       final User? user = (await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       )).user;
//
//       final newPassword = newpasswordcontroller.text;
//
//       if (!regex.hasMatch(newPassword)) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text("Password must contain at least 8 characters, including at least one uppercase letter, one lowercase letter, one number, and one special character")));
//         return;
//       }
//
//       await user!.updatePassword(newPassword);
//
//       print("Password updated successfully");
//     } catch (e) {
//       print("Error updating password: $e");
//     }
//   }
//
//   @override
//   void initState() {
//     _getDataFromDatabasae();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Center(child: Text('Forgot M-Pin')),
//         centerTitle: true,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const Icon(Icons.cancel))
//         ],
//       ),
//
//       body: SingleChildScrollView(
//         child: Center(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//
//                 const SizedBox(height: 30,),
//                 Image.asset('assets/forgot-password.jpg',width: 300,),
//                 const SizedBox(height: 20,),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 0, 220, 0),
//                   child: Text('Forgot\n'
//                       'Password?',
//                       style: Theme.of(context).textTheme.headline4),
//                 ),
//                 const SizedBox(height: 20,),
//                 Text("Don't worry! it happens. Please enter the\n"
//                     "Mobile number associated with your account",
//                   style: Theme.of(context).textTheme.bodyText2,),
//                 const SizedBox(height: 30,),
//                 TextFormField(
//                   controller: mobileController,
//                   decoration: const InputDecoration(
//                     hintText: "Mobile Number",
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "* Enter your Mobile Number";
//                     } else if (value.length < 10) {
//                       return "Mobile Number should be 10 digits";
//                     } else {
//                       return null;
//                     }
//                   },
//
//                   keyboardType: TextInputType.number,
//                   inputFormatters: <TextInputFormatter>[
//                     FilteringTextInputFormatter.digitsOnly,
//                     LengthLimitingTextInputFormatter(10)
//                   ],
//                 ),
//                 SizedBox(height: 20,),
//                 Container(
//                   child: OutlinedButton(onPressed: () async {
//                     var collection = FirebaseFirestore.instance.collection('Register');
//                     var querySnapshot = await collection.where("Mobile",isEqualTo: mobileController.text).get();
//                     for (var queryDocumentSnapshot in querySnapshot.docs) {
//                       Map<String, dynamic> data = queryDocumentSnapshot.data();
//                       var name = data['Name'];
//                       var password = data['Password'];
//                       var mobiles= data["Mobile"];
//                       setState(() {
//                         passwords=password;
//                         mobile = mobiles;
//
//                       });
//                     }
//                     if(mobile != mobileController.text) {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Mobile Number Not Registered")));
//                     }
//
//                     if(mobile == mobileController.text)
//                       if (_formkey.currentState!.validate()) {
//                         showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 backgroundColor: Colors.grey[800],
//                                 title: Text(
//                                   "Confirm",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 content: Text(
//                                   "Do you want to send Password to your Mobile Number?",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 actions: <Widget>[
//                                   TextButton(
//                                       child: Text('Yes'),
//                                       onPressed: () async {
//
//                                         if (_formkey.currentState!
//                                             .validate()) {
//                                           String password = passwords;
//                                           String apikey =
//                                               "3fd55fb2b77b0a2980b2efe4a4ab8110";
//                                           String route = "2";
//                                           String senderid = "GoRubn";
//                                           String number =
//                                           mobileController.text.trim();
//                                           String sms =
//                                               "Welcome to GoRurban-Logistics made easier. Thanks for being our valuable customer. Your Password Is $password Regards GoRurban";
//                                           String templateid =
//                                               "1207163827477260339";
//                                           final encodedSms =
//                                           Uri.encodeComponent(sms);
//                                           final url = Uri.parse(
//                                               'http://sms.xesstechlink.com/api/smsapi?key=$apikey&route=$route&sender=$senderid&number=$number&sms=$encodedSms&templateid=$templateid');
//                                           try {
//                                             final response =
//                                             await http.get(url);
//                                             if (response.statusCode ==
//                                                 200) {
//                                               print(
//                                                   'SMS sent successfully');
//                                             } else {
//                                               // Request failed, handle the error here
//                                               print('Failed to send SMS');
//                                             }
//                                           } catch (error) {
//                                             // An error occurred, handle the exception here
//                                             print(
//                                                 'Error sending SMS: $error');
//                                           }
//
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       LoginSubClass()));
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(SnackBar(
//                                               content: Text(
//                                                   "Your Password Sent to Your Registered Mobile Number Successfully")));
//                                         }
//                                       }),
//                                   TextButton(
//                                     child: Text('No'),
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                   ),
//                                 ],
//                               );
//                             });
//                       }
//                   }, child: Text("Send Password")),
//                 ),
//                 const SizedBox(height: 20,),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void verifyCode() async {
//     final String username = phoneController.text.trim();
//     //  String retVal ="error";
//     //  OurUser _user = OurUser();
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationIDRecieved, smsCode: otpCodeController.text);
//     /* try {
//       UserCredential _authResult = await auth.signInWithCredential(credential);
//       if(_authResult.additionalUserInfo.isNewUser) {
//         currentUser.uid = _authResult.user?.uid;
//       }
//     }*/
//     await auth.signInWithCredential(credential).then((value) async {
//       // QuerySnapshot snap = await FirebaseFirestore.instance.collection("users")
//       //   .where("username", isEqualTo: username).get();
//       Navigator.push(
//         context, MaterialPageRoute(builder: (context) => const NewMpin()),
//       );
//       print("You are logged in Successfully");
//     });
//   }
//   void verifyNumber() {
//     auth.verifyPhoneNumber(phoneNumber: phoneController.text.toString(),
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await auth.signInWithCredential(credential).then((value) {
//             print("You are logged in Successfully");
//           });
//         },
//         verificationFailed: (FirebaseAuthException exception){
//           print(exception.message);
//           /* if(e.code == 'invalid-phone-number'){
//         print('Invalid phone number');
//       }*/
//         },
//         codeSent: (String verificationID, int? resendToken) async{
//           verificationIDRecieved = verificationID;
//           otpcodevisible = true;
//           setState(() {  });
//         },
//         codeAutoRetrievalTimeout: (String verificationID){
//         });
//   }
//
//   Future<void> resend() async{
//     PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
//         verificationId: verificationIDRecieved,
//         smsCode: otpCodeController.text.toString());
//     auth.signInWithCredential(phoneAuthCredential);
//   }
//
// }
//
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart'as http;

import 'login.dart';


class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController newpasswordcontroller = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? userId;


  String passwords ="";
  String mobile ="";
  String names ="";
  String membersid ="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  String helpnumber ="9788777788";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(centerTitle: true,
        leading: IconButton(icon:Icon( Icons.arrow_back),onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginSubClass()));

        },),
        title: Text("Reset M-Pin"),
      ),
      body: WillPopScope(
        onWillPop: ()async{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginSubClass()));
          SystemNavigator.pop();
          return true;
        },
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30,),
                Image.asset('assets/forgot-password.jpg',width: 300,),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 220, 0),
                  child: Text('Forgot\n'
                      'M-Pin?',
                      style: Theme.of(context).textTheme.headline4),
                ),
                const SizedBox(height: 20,),
                Text("Don't worry! it happens. Please enter the\n"
                    "Mobile number associated with your account",
                  style: Theme.of(context).textTheme.bodyText2,),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(width: 300,
                          child: TextFormField(
                            controller: mobileController,
                            decoration: const InputDecoration(
                              prefixText: "+91 ",
                              hintText: "Mobile Number",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* Enter your Mobile Number";
                              } else if (value.length < 10) {
                                return "Mobile Number should be 10 digits";
                              } else {
                                return null;
                              }
                            },

                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10)
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          child: OutlinedButton(onPressed: () async {



                            /*if(mobile != mobileController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Mobile Number Not Registered")));
                            }
                            if(mobile == mobileController.text)*/
                              if (_formkey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.grey[800],
                                        title: Text(
                                          "Confirm",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        content: Text(
                                          "Do you want to send M-Pin to your Mobile Number?"
                                              ,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                              child: Text('Yes'),
                                              onPressed: () async {
                                                if (_formkey.currentState!
                                                    .validate()) {
                                                  String name1 = names;
                                                  String memberids = membersid;
                                                  String password = passwords;
                                                  String apikey =
                                                      "3fd55fb2b77b0a2980b2efe4a4ab8110";
                                                  String route = "2";
                                                  String senderid = "GoRubn";
                                                  String number =
                                                  mobileController.text.trim();
                                                  String sms =
                                                  //"Hi {#var#} Login ID{#var#} and M-Pin is{#var#} Thank You GiBERODE";
                                                  //"Hi$name1 Login ID$memberids and M-Pin is$password Thank You GiBERODE";
                                                 "Welcome to GoRurban-Logistics made easier. Thanks for being our valuable customer. Your Password Is $password Regards GoRurban";
                                                  String templateid =
                                                      "1207163827477260339";
                                                  final encodedSms =
                                                  Uri.encodeComponent(sms);
                                                  final url = Uri.parse(
                                                      'http://sms.xesstechlink.com/api/smsapi?key=$apikey&route=$route&sender=$senderid&number=$number&sms=$encodedSms&templateid=$templateid');
                                                  try {
                                                    final response =
                                                    await http.get(url);
                                                    if (response.statusCode ==
                                                        200) {
                                                      print(
                                                          'SMS sent successfully');
                                                    } else {
                                                      // Request failed, handle the error here
                                                      print('Failed to send SMS');
                                                    }
                                                  } catch (error) {
                                                    // An error occurred, handle the exception here
                                                    print(
                                                        'Error sending SMS: $error');
                                                  }
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginSubClass()));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Your M-Pin Sent to Your Registered Mobile Number Successfully")));
                                                }
                                              }),
                                          TextButton(
                                            child: Text('No'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              }
                          }, child: Text("Send M-Pin")),
                        ),
                        const SizedBox(height: 20,),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
