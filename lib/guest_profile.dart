import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'guest_edit.dart';

class GuestProfile extends StatefulWidget {
  final String? userID;
  const GuestProfile({super.key, required  this.userID});

  @override
  State<GuestProfile> createState() => _GuestProfileState();
}

class _GuestProfileState extends State<GuestProfile> {

  List<Map<String, dynamic>> data=[];
  Future<void> getData() async {
    print('Attempting to make HTTP request...');
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/guest_profile.php?id=${widget.userID}');
      print(url);
      final response = await http.get(url);
      print("ResponseStatus: ${response.statusCode}");
      print("Response: ${response.body}");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("ResponseData: $responseData");
        if (responseData is List) {
          // If responseData is a List (multiple records)
          final List<dynamic> itemGroups = responseData;
          setState(() {
            data = itemGroups.cast<Map<String, dynamic>>();
          });
          print('Data: $data');
        } else if (responseData is Map<String, dynamic>) {
          // If responseData is a Map (single record)
          setState(() {
            data = [responseData];
          });
          print('Data: $data');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
      print('HTTP request completed. Status code: ${response.statusCode}');
    } catch (e) {
      print('Error making HTTP request: $e');
      throw e; // rethrow the error if needed
    }
  }

  @override
  void initState() {

    getData();
    print("USER ID---${widget.userID}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Profile', style: TextStyle(color: Colors.white))),
        centerTitle: true,
        iconTheme:  const IconThemeData(
          color: Colors.white, // Set the color for the drawer icon
        ),
        actions: [
          IconButton(
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => GuestProfileEdit(
                  currentFirstName: data[0]["first_name"],
                  currentLastName: data[0]["last_name"],
                  currentCompanyName: data[0]["company_name"],
                  currentMobile: data[0]["mobile"],
                  currentEmail: data[0]["email"],
                  currentLocation: data[0]["place"],
                  currentBloodGroup: data[0]["blood_group"],
                  id: widget.userID
                )));
          },
              icon: const Icon(Icons.edit)),
        ]
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left:8.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/pro1.jpg"),
                  radius: 45,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 400,
                height: 230,
                decoration:   BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(50))
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 30),
                    const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Text("First Name", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Last Name", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Company Name", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Mobile", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Blood Group", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
                      ]
                    ),
                    const SizedBox(width: 20),
                    const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Text(":"),
                          Text(":"),
                          Text(":"),
                          Text(":"),
                          Text(":"),
                          Text(":"),
                          Text(":"),
                        ]
                    ),
                    SizedBox(width: 20),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),

                          Text(data.isNotEmpty ?"${data[0]['first_name']}":""),
                          Text(data.isNotEmpty ?"${data[0]['last_name']}":""),
                          Text(data.isNotEmpty ?"${data[0]['company_name']}":""),
                          Text(data.isNotEmpty ?"${data[0]['mobile']}":""),
                          Text(data.isNotEmpty ?"${data[0]['email']}":""),
                          Text(data.isNotEmpty ?"${data[0]['blood_group']}":""),
                          Text(data.isNotEmpty ?"${data[0]['place']}":""),
                        ]
                    )
                  ]
                ),

              )
            ]
          )
        )
      )
    );
  }
}