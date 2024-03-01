import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home.dart';
import 'home1.dart';

class GibMembers extends StatelessWidget {
  final String userType;
  final String? userId;

   GibMembers({Key? key, required this.userType, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Members(
        userId: userId,
        userType: userType,
      ),
    );
  }
}

class Members extends StatefulWidget {
  final String userType;
  final String? userId;
   Members({Key? key, required this.userType, required this.userId}) : super(key: key);

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {
  String name = "";     // search bar
  String type = "Member";
  final fieldText = TextEditingController();
  void clearText() {
    fieldText.clear();
  }
  bool isVisible = false;
  bool titleVisible = true;
  String documentid = "";
  List<Map<String, dynamic>> data=[];
  Future<void> getData() async {
    print('Attempting to make HTTP request...');
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/gib_members.php?member_type=${widget.userType}');
      print(url);
      final response = await http.get(url);
      print("ResponseStatus: ${response.statusCode}");
      print("Response: ${response.body}");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("ResponseData: $responseData");
        final List<dynamic> itemGroups = responseData;
        setState(() {});
         data = itemGroups.cast<Map<String, dynamic>>();
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
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage(userType: widget.userType, userID: widget.userId,)));
            },
            icon: const Icon(Icons.arrow_back)),
        iconTheme:  const IconThemeData(
          color: Colors.white, // Set the color for the drawer icon
        ),
        title: Column(
          children: [
            Visibility(
                visible: titleVisible,
                child: Center(child: Text('GIB MEMBERS', style: Theme.of(context).textTheme.bodySmall))),
            Visibility(
              visible: isVisible,
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Center(
                  child: TextField(
                    onChanged: (val){         //search bar
                      setState(() {
                        name = val ;
                      });
                    },
                    controller: fieldText,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: clearText,
                        ),
                        hintText: 'Search'
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                isVisible = true;
                titleVisible = false;
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
               itemCount: data.length,
               itemBuilder: (context, i) {

               //  if(documentid != thisitem["Uid"]) {
                   if (name.isEmpty) {
                     return Center(
                       child: Column(
                         children: [
                           const SizedBox(height: 5,),
                           InkWell(
                             onTap: () {
                               /*Navigator.push(context, MaterialPageRoute(
                                   builder: (context) =>
                                       Details(thisitem['id'])));*/
                             },
                             child: Container(
                               width: 350,
                               height: 80,
                               padding: const EdgeInsets.all(5.0),
                               decoration: const BoxDecoration(
                                 border: Border(
                                   bottom: BorderSide(
                                       color: Colors.green, width: 1),
                                 ),
                                 // borderRadius: BorderRadius.circular(10.0)
                               ),
                               child: ListTile(
                                 leading:
                                 SizedBox(
                                   height: 80,
                                   child: CircleAvatar(
                                     /*backgroundImage: Image
                                         .network("${thisitem['Image']}")
                                         .image,*/
                                     //  radius: 50,
                                   ),
                                 ),
                                 /* SizedBox(
                                 height: 80.0,
                                 width: 80.0, // fixed width and height
                                 child: Image.network('${thisitem['Image']}', fit: BoxFit.cover,),
                               ),*/
                                 /* const CircleAvatar(
                                           backgroundImage: AssetImage(
                                             'assets/profile.jpg',),
                                          // radius: 40,
                                         ),*/
                                 title: Text('${data[i]['first_name']} ${data[i]['last_name']}'),
                                 subtitle: Text(
                                     '${data[i]['company_name']}'),
                                 // subtitle: Text(documentSnapshot['Company Name']),
                                 trailing: IconButton(
                                     onPressed: () async {
                                       final call = Uri.parse(
                                           "tel://${data[i]['mobile']}");
                                       if (await canLaunchUrl(call)) {
                                         launchUrl(call);
                                       } else {
                                         throw 'Could not launch $call';
                                       }
                                     },
                                     icon: const Icon(
                                       Icons.call, color: Colors.green,)),
                               ),
                             ),
                           ),

                         ],
                       ),
                     );
                   }


                   /*    return Visibility(
                     visible: (documentid.isNotEmpty) ? false : true ,
                     child: Center(
                       child: Column(
                         children: [
                           const SizedBox(height: 5,),
                           InkWell(
                             onTap: () {
                               Navigator.push(context, MaterialPageRoute(
                                   builder: (context) => Details(thisitem['id'])));
                             },
                             child: Container(
                               width: 350,
                               height: 80,
                               padding: const EdgeInsets.all(5.0),
                               decoration: const BoxDecoration(
                                 border: Border(
                                   bottom: BorderSide(color: Colors.green, width: 1),
                                 ),
                                 // borderRadius: BorderRadius.circular(10.0)
                               ),
                               child: ListTile(
                                 leading:
                                 SizedBox(
                                   height: 80,
                                   child: CircleAvatar(
                                     backgroundImage: Image.network("${thisitem['Image']}").image,
                                     //  radius: 50,
                                   ),
                                 ),
                                 /* SizedBox(
                                 height: 80.0,
                                 width: 80.0, // fixed width and height
                                 child: Image.network('${thisitem['Image']}', fit: BoxFit.cover,),
                               ),*/
                                 /* const CircleAvatar(
                                           backgroundImage: AssetImage(
                                             'assets/profile.jpg',),
                                          // radius: 40,
                                         ),*/
                                 title: Text('${thisitem['First Name']}'),
                                 subtitle: Text('${thisitem['Company Name']}'),
                                 // subtitle: Text(documentSnapshot['Company Name']),
                                 trailing: IconButton(
                                     onPressed: () async {
                                       final call = Uri.parse("tel://${thisitem['Mobile']}");
                                       if (await canLaunchUrl(call)) {
                                         launchUrl(call);
                                       } else {
                                         throw 'Could not launch $call';
                                       }
                                     },
                                     icon: const Icon(
                                       Icons.call, color: Colors.green,)),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                   );*/


                   if (data[i]['first_name']
                       .toString()
                       .toLowerCase().startsWith(name.toLowerCase()) ||
                       data[i]['company_name']
                           .toString()
                           .toLowerCase().startsWith(name.toLowerCase())) {
                     return
                       Center(
                         child: InkWell(
                           onTap: () {
                             /*Navigator.push(context, MaterialPageRoute(
                                 builder: (context) =>
                                     Details(thisitem['id'])));*/
                           },
                           child: Container(
                             width: 350,
                             height: 80,
                             padding: const EdgeInsets.all(5.0),
                             decoration: const BoxDecoration(
                               border: Border(
                                 bottom: BorderSide(
                                     color: Colors.green, width: 1),
                               ),
                               // borderRadius: BorderRadius.circular(10.0)
                             ),
                             child: ListTile(
                               leading: SizedBox(
                                 height: 80.0,
                                 width: 80.0, // fixed width and height
                                 /*child: Image.network(
                                   '${thisitem['Image']}',
                                   fit: BoxFit.cover,),*/
                               ),
                               /* const CircleAvatar(
                                         backgroundImage: AssetImage(
                                           'assets/profile.jpg',),
                                        // radius: 40,
                                       ),*/
                               title: Text('${data[i]['first_name']}'),
                               subtitle: Text(
                                   '${data[i]['company_name']}'),
                               // subtitle: Text(documentSnapshot['Company Name']),
                               trailing: IconButton(
                                   onPressed: () async {
                                     final call = Uri.parse(
                                         "tel://${data[i]['mobile']}");
                                     if (await canLaunchUrl(call)) {
                                       launchUrl(call);
                                     } else {
                                       throw 'Could not launch $call';
                                     }
                                   },
                                   /* onPressed: () {
                                   launch("tel://${thisitem['Mobile']}");
                                 },*/
                                   icon: const Icon(
                                     Icons.call, color: Colors.green,)),
                             ),
                           ),
                         ),
                       );
                   }
                // }
                 return Container();
               }
                )
      /* body: StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection("Register").snapshots(),
   /* (name != "") ?
          FirebaseFirestore.instance.collection('Register')
              //.where("Type", isEqualTo: type)
              .orderBy('First Name')
              .startAt([name])
              .endAt(['$name\uf8ff'])
          .snapshots()
          : FirebaseFirestore.instance.collection("Register")
        .where("Type", isEqualTo: type).snapshots(), */  //search bar
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          QuerySnapshot<Object?>? querySnapshot = streamSnapshot.data;
          List<QueryDocumentSnapshot> documents = querySnapshot!.docs;

          List<Map> items = documents.map((e) => {
            "id": e.id,
            "First Name": e['First Name'],
            "Company Name": e['Company Name'],
            "Mobile": e['Mobile']
          }).toList();
          return ListView.builder(
              itemCount: items.length,
              // itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = streamSnapshot.data!.docs[index].data();
                Map thisitem = items[index];
                // final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Details(thisitem['id'])));
                        },
                        child: Container(
                          width: 350,
                          height: 80,
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.green, width: 1),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                           child: ListTile(
                                leading: SizedBox(
                                    height: 80.0,
                                    width: 80.0, // fixed width and height
                                    child: Image.network('${thisitem['Image']}', fit: BoxFit.cover,),
                                ),
                               /* const CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/profile.jpg',),
                                 // radius: 40,
                                ),*/
                                title: Text('${thisitem['First Name']}'),
                                subtitle: Text('${thisitem['Company Name']}'),
                               // subtitle: Text(documentSnapshot['Company Name']),
                                trailing: IconButton(
                                    onPressed: () {
                                      launch("tel://${thisitem['Mobile']}");
                                    },
                                    icon: const Icon(
                                      Icons.call, color: Colors.green,)),
                              )
                         /* child: Row(
                           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CircleAvatar(
                                backgroundImage: AssetImage('assets/profile.jpg'),
                                radius: 40,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('${thisitem['First Name']}\n'
                                    '${thisitem['Company Name']}',
                                  style: Theme.of(context).textTheme.bodyText1,),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                    onPressed: () {
                                      launch("tel://'${thisitem['Mobile']}'");
                                    },
                                    icon: const Icon(Icons.call,color: Colors.green,)),
                              )
                            ],
                          ),*/
                        ),
                      ),
                      // const SizedBox(height: 5,)
                    ],
                  ),
                );
              }
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ),*/
    );
  }
}

