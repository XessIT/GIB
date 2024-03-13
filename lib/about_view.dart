import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gipapp/home.dart';

import 'gib_edit_about.dart';

class AboutTab extends StatelessWidget {
  final String userId = "";
  final String userType = "";

  AboutTab({Key? key, required userId, required userType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AboutGibView(userId: userId, userType: userType),
    );
  }
}

class AboutGibView extends StatefulWidget {
  String? userId = "";
  String? userType = "";

  AboutGibView({Key? key, required this.userId, required this.userType})
      : super(key: key);

  @override
  State<AboutGibView> createState() => _AboutGibViewState();
}

class _AboutGibViewState extends State<AboutGibView> {
  List<Map<String, dynamic>> aboutVisiondata = [];
  List<Map<String, dynamic>> aboutGIBdata = [];
  List<Map<String, dynamic>> aboutMissiondata = [];

  Future<void> aboutVision() async {
    try {
      final url = Uri.parse(
          'http://localhost/GIB/lib/GIBAPI/about.php?table=about_vision');
      if (kDebugMode) {
        print("Url:$url");
      }

      final response = await http.get(url);
      if (kDebugMode) {
        print("Response:$response");
      }
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> itemGroups = responseData;
        if (kDebugMode) {
          print("responseData:$responseData");
        }
        if (kDebugMode) {
          print("statusCode:${response.statusCode}");
        }
        if (kDebugMode) {
          print("statusCode:${response.body}");
        }
        setState(() {
          aboutVisiondata = itemGroups.cast<Map<String, dynamic>>();
          print("aboutvision:$aboutVisiondata");
        });
      } else {
        //print('Error: ${response.statusCode}');
      }
    } catch (error) {
      //  print('Error: $error');
    }
  }

  Future<void> aboutGIB() async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/about.php?table=about_gib');
      if (kDebugMode) {
        print("Url:$url");
      }

      final response = await http.get(url);
      if (kDebugMode) {
        print("Response:$response");
      }
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> itemGroups = responseData;
        if (kDebugMode) {
          print("responseData:$responseData");
        }
        if (kDebugMode) {
          print("statusCode:${response.statusCode}");
        }
        if (kDebugMode) {
          print("statusCode:${response.body}");
        }
        setState(() {
          aboutGIBdata = itemGroups.cast<Map<String, dynamic>>();
          print("aboutgib:$aboutGIBdata");
        });
      } else {
        //print('Error: ${response.statusCode}');
      }
    } catch (error) {
      //  print('Error: $error');
    }
  }

  Future<void> aboutMission() async {
    try {
      final url = Uri.parse(
          'http://localhost/GIB/lib/GIBAPI/about.php?table=about_mission');
      if (kDebugMode) {
        print("aboutMission Url:$url");
      }

      final response = await http.get(url);
      if (kDebugMode) {
        print("aboutMission Response:$response");
      }
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> itemGroups = responseData;
        if (kDebugMode) {
          print("aboutMission responseData:$responseData");
        }
        if (kDebugMode) {
          print("aboutMission statusCode:${response.statusCode}");
        }
        if (kDebugMode) {
          print("aboutMission statusCode:${response.body}");
        }
        setState(() {
          aboutMissiondata = itemGroups.cast<Map<String, dynamic>>();
          print("about Mission data:$aboutMissiondata");
        });
      } else {
        //print('Error: ${response.statusCode}');
      }
    } catch (error) {
      //  print('Error: $error');
    }
  }

  @override
  void initState() {
    aboutVision();
    aboutGIB();
    aboutMission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title:  Text('About GIB',style: Theme.of(context).textTheme.bodySmall),
          centerTitle: true,
          // actions: [
          //   IconButton(onPressed: (){
          //     Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutTabEdit(userId: widget.userId, userType: widget.userType,)));
          //   }, icon: Icon(Icons.edit))
          // ],
          iconTheme:  const IconThemeData(
            color: Colors.white, // Set the color for the drawer icon
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Home(userType: widget.userType, userId: widget.userId),
                ),
              );
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: [
            TabBar(
                tabAlignment: TabAlignment.center,
                isScrollable: true,
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'GIB',
                  ),
                  Tab(
                    text: 'Vision',
                  ),
                  Tab(
                    text: 'Mission',
                  )
                ]),
            Container(
              height: 500,
              width: 400,
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              // Row(
                              //   crossAxisAlignment:CrossAxisAlignment.end,
                              //   children: [
                              //     IconButton(onPressed: (){
                              //     //  Navigator.push(context, MaterialPageRoute(builder: (context)=>GIBEditAbout()));
                              //     }, icon: Icon(Icons.edit))
                              //   ],
                              // ),
                              Image.asset('assets/logo.png', width: 300,),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  aboutGIBdata.isNotEmpty &&
                                      aboutGIBdata[0]["gib_content_1"].isNotEmpty
                                      ? "${aboutGIBdata[0]["gib_content_1"]}"
                                      : "Loading...",
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  aboutGIBdata.isNotEmpty &&
                                      aboutGIBdata[0]["gib_content_2"].isNotEmpty
                                      ? "${aboutGIBdata[0]["gib_content_2"]}"
                                      : "Loading...",
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  aboutGIBdata.isNotEmpty &&
                                      aboutGIBdata[0]["gib_content_3"].isNotEmpty
                                      ? "${aboutGIBdata[0]["gib_content_3"]}"
                                      : "Loading...",
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset('assets/logo.png', width: 300,),
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              aboutVisiondata.isNotEmpty
                                  ? "${aboutVisiondata[0]["vision_content_1"]}"
                                  : "Loading...",
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset('assets/logo.png', width: 300,),
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              aboutMissiondata.isNotEmpty
                                  ? "${aboutMissiondata[0]["mission_content_1"]}"
                                  : "Loading...",
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              aboutMissiondata.isNotEmpty
                                  ? "${aboutMissiondata[0]["mission_content_2"]}"
                                  : "Loading...",
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
