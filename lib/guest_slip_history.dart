import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class GuestHistory extends StatelessWidget {
  String userId = "";
  String userMobile = "";
   GuestHistory({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
        body:SlipHistory(userId :userId) ,
      );
  }
}
class SlipHistory extends StatefulWidget {
  String? userId="";
  String? userMobile="";
   SlipHistory({Key? key, required this.userId}) : super(key: key);

  @override
  State<SlipHistory> createState() => _SlipHistoryState();
}

class _SlipHistoryState extends State<SlipHistory> {
  String? uid="";
  String? mobile ="";


  @override
  void initState() {
    // TODO: implement initState
    visitorsFetch();
    super.initState();
  }



  //register_meeting data fetch code
  List<Map<String,dynamic>>visitorsFetchdata=[];
  Future<void> visitorsFetch() async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/visiters_slip.php?user_id=${widget.userId.toString()}');
      final response = await http.get(url);
      print("visitors url:$url");

      if (response.statusCode == 200) {
        print("visitors status code:${response.statusCode}");
        print("visitors body:${response.body}");

        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>) {
          setState(() {
            visitorsFetchdata = responseData.cast<Map<String, dynamic>>();

          });
        } else {
          // Handle invalid response data (not a List)
          print('Invalid response visitors data format');
        }
      } else {
        // Handle non-200 status code
        print('visitors Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other errors
      print('visitors Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true,
          iconTheme:  const IconThemeData(
          color: Colors.white, // Set the color for the drawer icon
        ),
          title: Text('Guest History',style: Theme.of(context).textTheme.bodySmall),
        ),
        body: ListView.builder(
                    itemCount: visitorsFetchdata.length,
                    itemBuilder: (context, index) {
                      Map fromitem = visitorsFetchdata.elementAt(index);
                        return Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Date  : ""${fromitem["meeting_date"]}",style: TextStyle(color: Colors.blue),)),
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                    child: Text("Guest Name  : ""${fromitem["guest_name"]}"),
                                  ),

                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                    child: Text("Time  :  ""${fromitem["time"]}"),
                                  ),

                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                    child: Text("Location  : ""${fromitem["location"]}"),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        );

                      return  Center(   child: Container(),);
                      //}


                    })
    );
  }
}
