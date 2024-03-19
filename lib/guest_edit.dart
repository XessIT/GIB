import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'guest_profile.dart';

class GuestProfileEdit extends StatefulWidget {
  final String? currentFirstName;
  final String? currentLastName;
  final String? currentCompanyName;
  final String? currentMobile;
  final String? currentEmail;
  final String? currentLocation;
  final String? currentBloodGroup;
  final String? id;
  const GuestProfileEdit({super.key,
    required this.currentFirstName,
    required this.currentLastName,
    required this.currentCompanyName,
    required this.currentMobile,
    required this.currentEmail,
    required this.currentLocation,
    required this.currentBloodGroup,
    required this.id});

  @override
  State<GuestProfileEdit> createState() => _GuestProfileEditState();
}

class _GuestProfileEditState extends State<GuestProfileEdit> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController companynamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  String blood = "Blood Group";
  final RegExp _alphabetPattern = RegExp(r'^[a-zA-Z]+$');
  ///capital letter starts code
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }
  @override
  void initState() {
    firstnamecontroller = TextEditingController(text: widget.currentFirstName);
    lastnamecontroller = TextEditingController(text: widget.currentLastName);
    locationcontroller = TextEditingController(text: widget.currentLocation);
    mobilecontroller = TextEditingController(text: widget.currentMobile);
    emailcontroller = TextEditingController(text: widget.currentEmail);
    companynamecontroller = TextEditingController(text: widget.currentCompanyName);
    blood = widget.currentBloodGroup!;
    super.initState();
  }

  Future<void> Edit() async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/guest_profile.php');
      // final url = Uri.parse('http://192.168.29.129/API/offers.php');
      final response = await http.put(
        url,
        body: jsonEncode({
          "first_name": firstnamecontroller.text,
          "last_name": lastnamecontroller.text,
          "company_name": companynamecontroller.text,
          "place": locationcontroller.text,
          "mobile": mobilecontroller.text,
          "email": emailcontroller.text,
          "blood_group": blood,
          "id": widget.id
        }),
      );
      print(url);
      print("ResponseStatus: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Offers response: ${response.body}");
        Navigator.push(context,
          MaterialPageRoute(builder: (context)=> GuestProfile(userID: widget.id)),);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Profile Successfully Updated")));
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error during signup: $e");
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile', style: TextStyle(color:Colors.white)),
        centerTitle: true,
        iconTheme:  const IconThemeData(
          color: Colors.white, // Set the color for the drawer icon
        ),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children:  [
                const SizedBox(height: 20,),
                InkWell(
                  child: CircleAvatar(
                    /*backgroundImage: pickedimage == null ? NetworkImage(imageUrl!)
                        : Image.file(pickedimage!).image,*/
                    radius: 50,
                  ),
                  onTap: () {
                    showModalBottomSheet(context: context, builder: (ctx){
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.camera_alt),
                            title: const Text("With Camera"),
                            onTap: () async {
                            //  pickImageFromCamera();
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.storage),
                            title: const Text("From Gallery"),
                            onTap: () {
                             // pickImageFromGallery();
                              //  pickImageFromDevice();
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
                  },
                ),

                const SizedBox(height: 20,width: 10,),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: firstnamecontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Enter your First Name';
                      } else if (!_alphabetPattern.hasMatch(value)) {
                        return '* Enter Alphabets only';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      String capitalizedValue = capitalizeFirstLetter(value);
                      firstnamecontroller.value = firstnamecontroller.value.copyWith(
                        text: capitalizedValue,
                       // selection: TextSelection.collapsed(offset: capitalizedValue.length),
                      );
                    },
                    decoration: const InputDecoration(
                      labelText: "First Name",
                      suffixIcon: Icon(Icons.account_circle),
                    ),
                    inputFormatters: [AlphabetInputFormatter(),
                      LengthLimitingTextInputFormatter(20),
                    ],
                  ),
                ),
                // First Name textfield ends

                // Last Name textfield starts
                const SizedBox(height: 15,),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: lastnamecontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Enter your Last Name';
                      } else if (!_alphabetPattern.hasMatch(value)) {
                        return '* Enter Alphabets only';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      String capitalizedValue = capitalizeFirstLetter(value);
                      lastnamecontroller.value = lastnamecontroller.value.copyWith(
                        text: capitalizedValue,
                       // selection: TextSelection.collapsed(offset: capitalizedValue.length),
                      );
                    },
                    decoration: const InputDecoration(
                      labelText: "Last Name",
                      hintText: "Last Name",
                      suffixIcon: Icon(Icons.account_circle),
                    ),
                    inputFormatters: [AlphabetInputFormatter(),
                      LengthLimitingTextInputFormatter(20),
                    ],
                  ),
                ),
                // Last Name textfield ends

                // Company name textfield starts
                const SizedBox(height: 15,),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: companynamecontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Enter your Company Name/Occupation';
                      } else if (_alphabetPattern.hasMatch(value)) {
                        return null;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      String capitalizedValue = capitalizeFirstLetter(value);
                      companynamecontroller.value = companynamecontroller.value.copyWith(
                        text: capitalizedValue,
                       // selection: TextSelection.collapsed(offset: capitalizedValue.length),
                      );
                    },

                    decoration: const InputDecoration(
                      labelText: "Company Name/Occupation",
                      hintText: "Company Name/Occupation",
                      suffixIcon: Icon(Icons.business),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                    ],
                  ),
                ),
                // Company name textfield ends

                // Email textfield starts here
                const SizedBox(height: 15,),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: emailcontroller,
                    validator: (value) {
                      if (value == null || value
                          .trim()
                          .isEmpty) {
                        return '* Enter your Email';
                      }
                      // Check if the entered email has the right format
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return '* Enter a valid Email Address';
                      }
                      // Return null if the entered email is valid
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Email",
                      suffixIcon: Icon(Icons.mail),
                    ),
                  ),
                ),
                // Email textfield ends here

                // Mobile number textfield starts here
                const SizedBox(height: 15,),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: mobilecontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Enter your Mobile Number';
                      }
                      else if(value.length<10){
                        return "* Mobile should be 10 digits";
                      }
                      return null;
                    },

                    decoration: const InputDecoration(
                      labelText: "Mobile Number",
                      hintText: "Mobile Number",
                      prefixText: '+91 ',
                      prefixStyle: TextStyle(color: Colors.blue), // Set the color here
                      suffixIcon: Icon(Icons.phone_android),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                  ),
                ),
                // Mobile number textfield ends here

                // Blood group drop down button starts
                const SizedBox(height: 15,),
                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    value: blood,
                    hint: const Text("Blood Group"),
                    icon: const Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    items: <String>[
                      "Blood Group",
                      "A+",
                      "A-",
                      "A1+",
                      "A1-",
                      "A2+",
                      "A2-",
                      "A1B+",
                      "A1B-",
                      "A2B+",
                      "A2B-",
                      "AB+",
                      "AB-",
                      "B+",
                      "B-",
                      "O+",
                      "O-",
                      "BBG",
                      "INRA"
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value));
                    }
                    ).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        blood = newValue!;
                      });
                    },
                    validator: (value) {
                      if (blood == 'Blood Group') return '* Select Blood Group';
                      return null;
                    },
                  ),
                ),
                // Blood group dropdown button ends here

                // Location textfield starts
                const SizedBox(height: 15,),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: locationcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '* Enter your location';
                      } else if (!_alphabetPattern.hasMatch(value)) {
                        return'* Enter Alphabets only';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      String capitalizedValue = capitalizeFirstLetter(value);
                      locationcontroller.value = locationcontroller.value.copyWith(
                        text: capitalizedValue,
                       // selection: TextSelection.collapsed(offset: capitalizedValue.length),
                      );
                    },

                    decoration: const InputDecoration(
                      labelText: "Location",
                      hintText: "Location",
                      suffixIcon: Icon(Icons.location_on_rounded),
                    ),
                    inputFormatters: [AlphabetInputFormatter(),
                      LengthLimitingTextInputFormatter(25),
                    ],
                  ),
                ),
                // Location textfield ends

                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Login button starts
                    MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)  ),
                        minWidth: 130,
                        height: 50,
                        color: Colors.green[800],
                        onPressed: (){
                           if (_formKey.currentState!.validate()) {
                             Edit();
                            }
                          /*if(type == null){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Please Select the Type")));
                          }
                          else if (_formKey.currentState!.validate()) {
                            Editoffers();
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> OfferList(userId: widget.user_id)),);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Successfully Updated a Offer")));
                          }*/
                        },
                        child: const Text('Update',
                          style: TextStyle(color: Colors.white),)),
                    // Update button ends

                    // Cancel button starts
                    MaterialButton(
                        minWidth: 130,
                        height: 50,
                        color: Colors.orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)  ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel',
                          style: TextStyle(color: Colors.white),)),
                    // Cancel button ends
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlphabetInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Filter out non-alphabetic characters
    String filteredText = newValue.text.replaceAll(RegExp(r'[^a-zA-Z]'), '');

    return newValue.copyWith(text: filteredText);
  }
}