import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class BusinessHistory extends StatefulWidget {
  final String? userType;
  final String? userId;
  const BusinessHistory({Key? key, required this.userType, required this.userId}) : super(key: key);

  @override
  State<BusinessHistory> createState() => _BusinessHistoryState();
}

class _BusinessHistoryState extends State<BusinessHistory> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Business History", style: Theme.of(context).textTheme.bodySmall,),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),

        body: Column(
          children: [
            const TabBar(
                isScrollable: true,
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: 'Pending',),
                  Tab(text: 'Successful',),
                  Tab(text: 'UnSuccessful',)
                ]),
            Expanded(
              child: TabBarView(
                children: [
                  Pending(userType: widget.userType, userId: widget.userId),
                  Completed(userType: widget.userType, userId: widget.userId),
                  Unsuccessful(userType: widget.userType, userId: widget.userId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Completed extends StatefulWidget {
  final String? userType;
  final String? userId;
  const Completed({super.key, required this.userType, required this.userId});

  @override
  State<Completed> createState() => _CompletedState();
}


class _CompletedState extends State<Completed> {
  String? name = "";
  String? mobile = "";
  String? successreason="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  String status = "Successful";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:/* ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    Map fromitem = [index] as Map;
                    if (fromitem["To Mobile"] == mobile ||
                        fromitem["Mobile"] == mobile) {
                      return Center(
                        child: Column(
                          children: [
                            ExpansionTile(
                              leading:fromitem["Mobile"]!=mobile ? Icon(Icons.call_made, color: Colors.green[800],):
                              const Icon(Icons.call_received, color: Colors.red,),
                              title: fromitem["Mobile"] != mobile ? Text(
                                  "${fromitem["Name"]}") :
                              Text("${fromitem["To Name"]}"),

                              children: [
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:  [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                      child: Text('Referrer Name  :'"${fromitem["Referrer Name"]}"),
                                    ),

                                  ],
                                ),

                                const SizedBox(height: 10,),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children:  [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                        child: Text('Purpose  :  '"${fromitem["Purpose"]}"),
                                      ),
                                    ]

                                ),

                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:  [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                      child: Text('Feedback   : '"${fromitem["Successful Reason"]}"),
                                    ),

                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:  [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                      child:  Text('Date   :'"${fromitem["Date"]}"),
                                    ),

                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }
                    return Container();
                  }

              )*/
      Center(
        child: Column(
          children: [
            ExpansionTile(
              leading: Icon(Icons.call_made, color: Colors.green[800],),
              title: Text("Bhuvana"),

              children: [
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text('Referrer Name  :'"Nasreen"),
                    ),

                  ],
                ),

                const SizedBox(height: 10,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  [
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Text('Purpose  :  '"Purpose"),
                      ),
                    ]

                ),

                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text('Feedback   : '"Successful Reason"),
                    ),

                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child:  Text('Date   :'"Date"),
                    ),

                  ],
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
class Pending extends StatefulWidget {
  final String? userType;
  final String? userId;
  const Pending({super.key, required this.userType, required this.userId});

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {

  String? uid="";
  String? mobile ="";
  String? firstname ="";
  String? fetchMobile ="";
  List<Map<String,dynamic>>userdata=[];
  Future<void> fetchData() async {
    print("with user id ${widget.userId}");
    try {
      //http://localhost/GIB/lib/GIBAPI/user.php?table=registration&id=$userId
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/registration.php?table=registration&id=${widget.userId}');
      final response = await http.get(url);
      print("fetch url:$url");

      if (response.statusCode == 200) {
        print("fetch status code:${response.statusCode}");
        print("fetch body:${response.body}");
        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>) {
          setState(() {
            userdata = responseData.cast<Map<String, dynamic>>();
            if (userdata.isNotEmpty) {
              setState(() {
                fetchMobile = userdata[0]["mobile"]??"";
              });
              getData();
            }
          });
        } else {
          // Handle invalid response data (not a List)
          print('Invalid response data format');
        }
      } else {
        // Handle non-200 status code
        //  print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other errors
      print('Error: $error');
    }
  }
  String status = "Pending";
  List<Map<String, dynamic>> data=[];
  Future<void> getData() async {
    print('Attempting to make HTTP request...');
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/business_slip.php?table=business_slip&mobile=$fetchMobile&status=$status');
      print("gib members url =$url");
      final response = await http.get(url);
      print("gib members ResponseStatus: ${response.statusCode}");
      print("gib members Response: ${response.body}");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("gib members ResponseData: $responseData");
        final List<dynamic> itemGroups = responseData;
        setState(() {});
        data = itemGroups.cast<Map<String, dynamic>>();
        print('gib members Data: $data');
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
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: /*Center(
          child: Column(
            children: [
              ExpansionTile(
                leading:
                    const Icon(Icons.call_made, color: Colors.red,),
                title:
                     Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Text('Nasreen'),
                        ],
                      ),
                    ),

                    IconButton(
                        onPressed: () async {
                          final call = Uri.parse("tel://""1234567890");
                          if (await canLaunchUrl(call)) {
                            launchUrl(call);
                          } else {
                            throw 'Could not launch $call';
                          }
                        },
                        icon: const Icon(Icons.call,color: Colors.green,)),
                  ],
                ),

                children: [


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Text("Referrer Name :"'"Baby"'),
                      ),
                      IconButton(
                          onPressed: () async {
                            final call = Uri.parse("tel://""1234567876543");
                            if (await canLaunchUrl(call)) {
                              launchUrl(call);
                            } else {
                              throw 'Could not launch $call';
                            }
                          },
                          icon: const Icon(Icons.call,color: Colors.green,)),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Text("Purpose : " 'Purpose'),
                      ),
                    ],
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child:  Text('Date   :'"Date"),

                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Text('Reason  : '"Hold Reason"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )*/
                 ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return Center(
                          child: Column(
                            children: [
                              ExpansionTile(
                                leading: data[i]["Tomobile"] == fetchMobile
                                    ? Icon(Icons.call_received, color: Colors.green[800],)
                                    : const Icon(Icons.call_made, color: Colors.red,),
                                title:
                                //data[i]["mobile"] == mobile ?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Padding(
                                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 30,),
                                          Text('${data[i]["Toname"]}\n'),
                                        ],
                                      ),
                                    ),

                                    IconButton(
                                        onPressed: () async {
                                          final call = Uri.parse("tel://""${data[i]["Tomobile"]}");
                                          if (await canLaunchUrl(call)) {
                                            launchUrl(call);
                                          } else {
                                            throw 'Could not launch $call';
                                          }
                                        },
                                        icon: const Icon(Icons.call,color: Colors.green,)),
                                  ],
                                ),
                                    /*: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${data[i]["First Name"]}\n'),
                                    IconButton(
                                        onPressed: () async {
                                          final call = Uri.parse("tel://""${data[i]["Mobile"]}");
                                          if (await canLaunchUrl(call)) {
                                            launchUrl(call);
                                          } else {
                                            throw 'Could not launch $call';
                                          }
                                        },
                                        icon: const Icon(Icons.call,color: Colors.green,)),
                                  ],
                                ),*/
                                children: [
                                  data[i]['type'] != 'Self' ?Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                        child: Text("Referree Name :"'${data[i]["referree_name"]}\n'),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            final call = Uri.parse("tel://""${data[i]["referree_mobile"]}");
                                            if (await canLaunchUrl(call)) {
                                              launchUrl(call);
                                            } else {
                                              throw 'Could not launch $call';
                                            }
                                          },
                                          icon: const Icon(Icons.call,color: Colors.green,)),
                                    ],
                                  ) : Container(),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                        child: Text("Purpose : " '${data[i]["purpose"]}\n'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                        child:  Text('Date   :'"${data[i]["createdOn"]}"),

                                      ),
                                    ],
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                        child: Text('Reason  : '"${data[i]["Hold Reason"]}"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      return Container();
                    }
                )
    );

  }
}

class Unsuccessful extends StatefulWidget {
  final String? userType;
  final String? userId;
  const Unsuccessful({super.key, required this.userType, required this.userId});

  @override
  State<Unsuccessful> createState() => _UnsuccessfulState();
}

class _UnsuccessfulState extends State<Unsuccessful> {

  String? uid="";
  String? mobile ="";
  String? firstname ="";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  String status = "Rejected";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   Center(
        child: Column(
          children: [
            ExpansionTile(
              leading: Icon(Icons.call_made, color: Colors.green[800],),

              title:Text("Bhuvana"),

              children: [
                const SizedBox(height: 10,),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text('Referrer Name  :Baby'),
                    ),

                  ],
                ),

                const SizedBox(height: 10,),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:  [
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Text('Purpose  :  Purpose'),
                      ),
                    ]

                ),

                const SizedBox(height: 10,),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text('UnSuccessful Reason  :UnSuccessful Reason '),
                    ),

                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text('Date   :Date'),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      /*ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    Map fromitem = [index] as Map;
                    if (fromitem["To Mobile"] == mobile ||
                        fromitem["Mobile"] == mobile) {
                      return Center(
                        child: Column(
                          children: [
                            ExpansionTile(
                              leading:fromitem["Mobile"]!=mobile ? Icon(Icons.call_made, color: Colors.green[800],):
                              const Icon(Icons.call_received, color: Colors.red,),

                              title: fromitem["Mobile"] != mobile ? Text(
                                  "${fromitem["Name"]}") :
                              Text("${fromitem["To Name"]}"),

                              children: [
                                const SizedBox(height: 10,),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children:  [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                      child: Text('Referrer Name  :'"${fromitem["Referrer Name"]}"),
                                    ),

                                  ],
                                ),

                                const SizedBox(height: 10,),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children:  [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                        child: Text('Purpose  :  '"${fromitem["Purpose"]}"),
                                      ),
                                    ]

                                ),

                                const SizedBox(height: 10,),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children:  [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                      child: Text('UnSuccessful Reason  : '"${fromitem["UnSuccessful Reason"]}"),
                                    ),

                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                      child: Text('Date   :'"${fromitem["Date"]}"),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }
                    return Container();
                  }

              )*/

    );
  }
}



