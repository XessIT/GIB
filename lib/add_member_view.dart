import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AddMemberView extends StatelessWidget {
  final String userType;
  String? userID;
  AddMemberView({Key? key,
    required this.userType,
    required this. userID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(

          // Appbar title
          title:  Center(child: Text("MEMBER'S STATUS",style: Theme.of(context).textTheme.bodySmall,)),
          centerTitle: true,
          iconTheme:  IconThemeData(
            color: Colors.white, // Set the color for the drawer icon
          ),
        ),
        body: Center(
          child: Column(
            children: [
              const Center(
                child: TabBar(
                  tabAlignment: TabAlignment.center,
                    isScrollable: true,
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(text: 'Pending',),
                      Tab(text: 'Approved',),
                      Tab(text: 'Rejected',)
                    ]),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    PendingView(userID:userID,userType:userType),
                    ApprovedView(userID:userID,userType:userType),
                    RejectedView(userID:userID,userType:userType),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class PendingView extends StatefulWidget {
  final String userType;
  String? userID;
  PendingView({Key? key,
    required this.userType,
    required this. userID,  }) : super(key: key);

  @override
  State<PendingView> createState() => _PendingViewState();
}

class _PendingViewState extends State<PendingView> {

  String mobile ="";
   String phone = "";
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

                mobile=dynamicdata[0]["mobile"];
                phone = mobile;
                print("Mobile:$mobile");
              });
            }
          });
        } else {
          // Handle invalid response data (not a List)
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



  List AdminRightsdata=[];
  String admin_rights = "Pending";


  Future<void> fetchDataAdminRightsbase() async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/id_base_details_fetch.php?referrer_mobile=$mobile && admin_rights=$admin_rights');
      print("mo: $mobile");
      print("ar: $admin_rights");
      print(url);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print("response Status: ${response.statusCode}");
        print("response body: ${response.body}");
        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>) {
          setState(() {
            AdminRightsdata = responseData.cast<Map<String, dynamic>>();
            if (AdminRightsdata.isNotEmpty) {
              setState(() {
                print("admin_rights Pending data =$AdminRightsdata");
              });
            }
          });
        } else {
          // Handle invalid response data (not a List)
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
  @override
  void initState() {
    // TODO: implement initState
    if (widget.userID != null && widget.userID!.isNotEmpty) {
      fetchData(widget.userID.toString()).then((_) {
        // Ensure that fetchData is completed before calling fetchDataAdminRightsbase
        fetchDataAdminRightsbase();
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: AdminRightsdata.length,
            itemBuilder: (context, i) {
              if (mobile.isNotEmpty) {
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 5,),
                      Container(
                        width: 350,
                        height: 80,
                        padding: const EdgeInsets.all(5.0),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.orange, width: 1),
                          ),
                        ),
                        child: ListTile(
                          leading:
                          SizedBox(
                            height: 80,
                            child: CircleAvatar(
                            ),
                          ),
                          title: Text('${AdminRightsdata[i]['first_name']} ${AdminRightsdata[i]['last_name']}'),
                          subtitle: Text(
                              '${AdminRightsdata[i]['company_name']}'),
                          trailing: IconButton(
                              onPressed: () async {
                                final call = Uri.parse(
                                    "tel://${AdminRightsdata[i]['mobile']}");
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

                    ],
                  ),
                );
              }
            }
        )


    );
  }
}
class ApprovedView extends StatefulWidget {
  final String userType;
  String? userID;
   ApprovedView({Key? key,
     required this.userType,
     required this. userID,
   }) : super(key: key);

  @override
  State<ApprovedView> createState() => _ApprovedViewState();
}

class _ApprovedViewState extends State<ApprovedView> {
  String mobile ="";
  String phone = "";
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

                mobile=dynamicdata[0]["mobile"];
                phone = mobile;
                print("Mobile:$mobile");
              });
            }
          });
        } else {
          // Handle invalid response data (not a List)
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



  List AdminRightsdata=[];
  String admin_rights = "Accepted";


  Future<void> fetchDataAdminRightsbase() async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/id_base_details_fetch.php?referrer_mobile=$mobile && admin_rights=$admin_rights');
      print("mo: $mobile");
      print("ar: $admin_rights");
      print(url);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print("response Status: ${response.statusCode}");
        print("response body: ${response.body}");
        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>) {
          setState(() {
            AdminRightsdata = responseData.cast<Map<String, dynamic>>();
            if (AdminRightsdata.isNotEmpty) {
              setState(() {
                print("admin_rights Accepted data =$AdminRightsdata");
              });
            }
          });
        } else {
          // Handle invalid response data (not a List)
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
  @override
  void initState() {
    // TODO: implement initState
    if (widget.userID != null && widget.userID!.isNotEmpty) {
      fetchData(widget.userID.toString()).then((_) {
        fetchDataAdminRightsbase();
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: AdminRightsdata.length,
            itemBuilder: (context, i) {

              if (mobile.isNotEmpty) {
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 5,),
                      Container(
                        width: 350,
                        height: 80,
                        padding: const EdgeInsets.all(5.0),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.green, width: 1),
                          ),
                        ),
                        child: ListTile(
                          leading:
                          SizedBox(
                            height: 80,
                            child: CircleAvatar(
                            ),
                          ),
                          title: Text('${AdminRightsdata[i]['first_name']} ${AdminRightsdata[i]['last_name']}'),
                          subtitle: Text(
                              '${AdminRightsdata[i]['company_name']}'),
                          trailing: IconButton(
                              onPressed: () async {
                                final call = Uri.parse(
                                    "tel://${AdminRightsdata[i]['mobile']}");
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

                    ],
                  ),
                );
              }
            }
        )
    );
  }
}



class RejectedView extends StatefulWidget {
  final String userType;
  String? userID;
   RejectedView({Key? key,
     required this.userType,
     required this. userID,
   }) : super(key: key);

  @override
  State<RejectedView> createState() => _RejectedViewState();
}

class _RejectedViewState extends State<RejectedView> {
  String mobile ="";
  String phone = "";
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

                mobile=dynamicdata[0]["mobile"];
                phone = mobile;
                print("Mobile:$mobile");
              });
            }
          });
        } else {
          // Handle invalid response data (not a List)
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



  List AdminRightsdata=[];
  String admin_rights = "Rejected";


  Future<void> fetchDataAdminRightsbase() async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/id_base_details_fetch.php?referrer_mobile=$mobile && admin_rights=$admin_rights');
      print("mo: $mobile");
      print("ar: $admin_rights");
      print(url);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print("response Status: ${response.statusCode}");
        print("response body: ${response.body}");
        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>) {
          setState(() {
            AdminRightsdata = responseData.cast<Map<String, dynamic>>();
            if (AdminRightsdata.isNotEmpty) {
              setState(() {
                print("admin_rights Rejected data =$AdminRightsdata");
              });
            }
          });
        } else {
          // Handle invalid response data (not a List)
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
  @override
  void initState() {
    // TODO: implement initState
    if (widget.userID != null && widget.userID!.isNotEmpty) {
      fetchData(widget.userID.toString()).then((_) {
        fetchDataAdminRightsbase();
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: AdminRightsdata.length,
            itemBuilder: (context, i) {
              if (mobile.isNotEmpty) {
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 5,),
                      Container(
                        width: 350,
                        height: 80,
                        padding: const EdgeInsets.all(5.0),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.red, width: 1),
                          ),
                        ),
                        child: ListTile(
                          leading:
                          SizedBox(
                            height: 80,
                            child: CircleAvatar(
                            ),
                          ),
                          title: Text('${AdminRightsdata[i]['first_name']} ${AdminRightsdata[i]['last_name']}'),
                          subtitle: Text(
                              '${AdminRightsdata[i]['company_name']}'),
                          trailing: IconButton(
                              onPressed: () async {
                                final call = Uri.parse(
                                    "tel://${AdminRightsdata[i]['mobile']}");
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
                    ],
                  ),
                );
              }
            }
        )
    );
  }
}