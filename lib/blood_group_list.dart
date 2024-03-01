import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'member_details.dart';

class BloodGroupList extends StatelessWidget {
  const BloodGroupList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // body: BloodList(),
    );
  }
}

class BloodList extends StatefulWidget {
  final String? bloods;
  const BloodList({Key? key,
    required this.bloods}) : super(key: key);

  @override
  State<BloodList> createState() => _BloodListState();
}
class _BloodListState extends State<BloodList> {

  @override
  void initState() {
    blood = widget.bloods!;
    getData();
    // TODO: implement initState
    super.initState();
  }
  String blood ="";

/*String? notneed;
  ownblood(User CurrentUser)async {
   notneed = (await FirebaseFirestore.instance.collection("Register").doc(CurrentUser.uid).get()) as String?;
  }

 bool visible= true;

  nvisible()async {
    visible =  FirebaseFirestore.instance.collection("Register")
        .doc(FirebaseAuth.instance.currentUser!.uid).snapshots()
    as bool;

  }
  String iscurrentuser=" ";
  Future<void> getRole() {
    return FirebaseFirestore.instance
        .collection('Register')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        iscurrentuser= snapshot.data()!['Uid'];
      } else {
        print('Document does not exist on the database');
      }
    });
  }*/

  String? mobile = "";
  String documentid = "";

  List<Map<String, dynamic>> data=[];
  Future<void> getData() async {
    print('Attempting to make HTTP request...');
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/gib_members.php');
      print(url);
      final response = await http.get(url);
      print("ResponseStatus: ${response.statusCode}");
      print("ALL Response: ${response.body}");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("ResponseData: $responseData");
        final List<dynamic> itemGroups = responseData;
        setState(() {});
        // data = itemGroups.cast<Map<String, dynamic>>();
        // Filter data based on user_id
        List<dynamic> filteredData = itemGroups.where((item) => item['blood_group'] == blood).toList();
        // Call setState() after updating data
        setState(() {
          // Cast the filtered data to the correct type
          data = filteredData.cast<Map<String, dynamic>>();
        });
        print('Data: $data');
      } else {
        print('Error: ${response.statusCode}');
      }
      print('HTTP request completed. Status code: ${response.statusCode}');
    } catch (e) {
      print('Error making HTTP request: $e');
      throw e; // rethrow the error if needed
    }

  }
  String getmobile="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(blood, style: Theme.of(context).textTheme.bodySmall)),
          centerTitle: true,
          iconTheme:  const IconThemeData(
            color: Colors.white, // Set the color for the drawer icon
          ),
        ),
        body: data.isEmpty
            ? Center(child: Text("Data not found", style: TextStyle(color: Colors.black)))
         : ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
            String getMobile = data[i]["mobile"];
            return
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      Visibility(
                        //visible: visible=false,
                        child: InkWell(
                          child: Container(
                              width: 350,
                              height: 80,
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.green, width: 1),
                                  borderRadius: BorderRadius.circular(
                                      10.0)
                              ),
                              child: ListTile(
                                leading: SizedBox(
                                  height: 80.0,
                                  width: 80.0, // fixed width and height
                                  /* child: Image.network(
                                          '${thisitem['Image']}',
                                          fit: BoxFit.cover,),*/
                                ),
                                /* const CircleAvatar(
                                    backgroundImage: AssetImage(
                                      'assets/profile.jpg',),
                                   // radius: 40,
                                  ),*/
                                title: Text('${data[i]['first_name']} ${data[i]['last_name']}'),
                                subtitle: Text(
                                    '${data[i]['companyname']}'),
                                // subtitle: Text(documentSnapshot['Company Name']),
                                trailing: IconButton(
                                    onPressed: () {
                                      launch(
                                          "tel://'${data[i]['mobile']}'");
                                    },
                                    icon: const Icon(
                                      Icons.call, color: Colors.green,)),
                              )
                          ),
                        ),
                      ),
                      // const SizedBox(height: 5,)
                    ],
                  ),
                );

            }


        )

    );
  }
}



