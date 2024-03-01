import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class MeetingUpcoming extends StatelessWidget {
  const MeetingUpcoming({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MeetingUpcomingPage(),
    );
  }
}
class MeetingUpcomingPage extends StatefulWidget {
  const MeetingUpcomingPage({Key? key}) : super(key: key);

  @override
  State<MeetingUpcomingPage> createState() => _MeetingUpcomingPageState();
}

class _MeetingUpcomingPageState extends State<MeetingUpcomingPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meeting',),
          centerTitle: true,
        ),
        body: const Column(
            children: [
              //TABBAR STARTS
              TabBar(
                isScrollable: true,
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: ('Network Meeting'),),
                  Tab(text: ('Team Meeting'),),
                  Tab(text: ('Training Program'),),
                  Tab(text: ("GIB Meeting"),),
                  //  Tab(text: ('API'),)
                ],
              ),
              //TABBAR VIEW STARTS
              Expanded(
                child: TabBarView(children: <Widget>[
                  NetworkMeeting(),
                  TeamMeeting(),
                  TrainingProgram(),
                  GIBMeeting(),
                  //  MyHomePage(title: '',),
                ],
                ),
              )
            ]),
      ),
    );
  }
}

class NetworkMeeting extends StatelessWidget {
  const NetworkMeeting({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 20,width: 100,
            ),

            //MAIN CONTAINER STARTS
            Container(
              height: 35,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
              ),

              //TABBAR STARTS
              child: const TabBar(
                indicator: BoxDecoration(
                  color: Colors.green,
                ),
                //TABS STARTS
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: ('Upcoming')),
                  Tab(text: ('Completed')),
                ],
              ) ,
            ),
            const SizedBox(height: 20,),

            //TABBAR VIEW STARTS
            Expanded(
              child: TabBarView(children: [
                UpComingNetworkMeeting(),
                CompletedNetworkMeeting(),
              ]),
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
class  UpComingNetworkMeeting extends StatefulWidget {
  UpComingNetworkMeeting({Key? key}) : super(key: key);

  @override
  State<UpComingNetworkMeeting> createState() => _UpComingNetworkMeetingState();
}

class _UpComingNetworkMeetingState extends State<UpComingNetworkMeeting> {
  String type = "Network Meeting";

  var date =  DateTime.now();

  List<String>item=["a","b","c"];

  List<Map<String, dynamic>> data=[];

  Future<void> getData() async {
    print('Attempting to make HTTP request...');
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/meeting.php?meeting_type=$type');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> itemGroups = responseData;
        setState(() {});
        List<dynamic> filteredData = itemGroups.where((item) {
          DateTime validityDate;
          try {
            validityDate = DateTime.parse(item['meeting_date']);
          } catch (e) {
            print('Error parsing validity date: $e');
            return false;
          }
          print('Validity Date: $validityDate');
          print('Current Date: ${DateTime.now()}');
          bool satisfiesFilter =  validityDate.isAfter(DateTime.now());
          print('Satisfies Filter: $satisfiesFilter');
          return satisfiesFilter;
        }).toList();
        setState(() {
          // Cast the filtered data to the correct type
          data = filteredData.cast<Map<String, dynamic>>();
        });
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder:(context, i){
              // const SizedBox(height:2);
              return Expanded(
                child: Card(
                  //   elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //DATE TEXT STARTS
                            //   const SizedBox(width: 23,),
                            //  SizedBox(height: 30,),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('${data[i]['meeting_date']}',
                                //format(DateTime.now()),style:  TextStyle(color: Colors.green[900],fontWeight:FontWeight.bold),
                              ),
                            ),
                            //TIME TEXT STARTS
                            //format(DateTime.now()),),
                          ],
                        ),
                        //NETWORK MEETING TEXT STARTS
                        //   const SizedBox(width: 30,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(alignment:Alignment.topLeft,
                                child: Text('${data[i]['from_time']}-\n'
                                    '${data[i]['to_time']}'),
                              ),
                              Align(alignment:Alignment.center,
                                  child: Text('${data[i]['meeting_name']}')),
                              Align(alignment:Alignment.topRight,
                                child: RichText(
                                  text:  TextSpan(
                                      children: [
                                        const WidgetSpan(child: Icon(Icons.location_on)),
                                        TextSpan(text: ('${data[i]['place']}'),style: const TextStyle(color: Colors.black)
                                        )
                                      ]
                                  ),
                                ),
                              ),
                            ]
                        ),
                      ],
                    ),
                  ),
                ),
              );

            })

    );
  }
}
class CompletedNetworkMeeting extends StatelessWidget {
  CompletedNetworkMeeting({Key? key}) : super(key: key);
  String type = "Network Meeting";
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:ListView.builder(
            itemCount: 10,
            itemBuilder:(context, index){
              //  String docId = streamSnapshot.data!.docs[index].id;
              Map thisitem = [index] as Map;
              // const SizedBox(height:2);
              const SizedBox(height: 20,);
              return Expanded(
                child: Card(
                  //   elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Align(
                              //   alignment: AlignmentDirectional.topStart,
                              child: Text('${thisitem['Meeting Date']}',
                              ),
                            ),
                            //TIME TEXT STARTS
                            Text('${thisitem['Time From']}-\n'
                                '${thisitem['To Time']}'),
                            //format(DateTime.now()),),
                          ],
                        ),
                        //NETWORK MEETING TEXT STARTS
                        //   const SizedBox(width: 30,),
                        Text('${thisitem['Meeting Name']}'),
                        //ERODE LOCATION ICON RICHTEXT STARTS
                        //    const SizedBox(width: 50,),
                        RichText(
                          text:  TextSpan(
                              children: [
                                const WidgetSpan(child: Icon(Icons.location_on)),
                                TextSpan(text: ('${thisitem['Place']}'),
                                  style: const TextStyle(color: Colors.black),
                                )
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
    );
  }
}
class TeamMeeting  extends StatelessWidget {
  const TeamMeeting({Key? key}) : super(key: key);
  //final CollectionReference meeting = FirebaseFirestore.instance.collection("Meeting");
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(children: [
            const SizedBox(
              height: 20,width: 100,
            ),
            //MAIN CONTAINER STARTS
            Container(
              height: 35,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
              ),

              //TABBAR STARTS
              child:const TabBar(
                indicator: BoxDecoration(
                  color: Colors.green,
                ),
                //TABS STARTS
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: ('Upcoming')),
                  Tab(text: ('Completed')),
                ],
              ) ,
            ),
            const SizedBox(height: 20,),
            //TABBAR VIEW STARTS
            Expanded(
              child: TabBarView(children: [
                UpcomingTeamMeeting(),
                CompletedTeamMeeting(),
              ]),
            ),

          ],
          ),
        )
    );}
}
class UpcomingTeamMeeting extends StatelessWidget {
  UpcomingTeamMeeting({Key? key}) : super(key: key);
  String type = "Team Meeting";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          /* gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),*/
            itemCount: 10,
            itemBuilder:(context, index){
              // String docId = streamSnapshot.data!.docs[index].id;
              Map thisitem = [index] as Map;
              // const SizedBox(height:2);
              const SizedBox(height: 20,);
              return Expanded(
                child: Card(
                  //   elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            //DATE TEXT STARTS
                            //   const SizedBox(width: 23,),
                            //  SizedBox(height: 30,),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('${thisitem['Meeting Date']}',
                                //format(DateTime.now()),style:  TextStyle(color: Colors.green[900],fontWeight:FontWeight.bold),
                              ),
                            ),

                            //TIME TEXT STARTS


                            //format(DateTime.now()),),
                          ],
                        ),
                        //NETWORK MEETING TEXT STARTS
                        //   const SizedBox(width: 30,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(alignment:Alignment.topLeft,
                                child: Text('${thisitem['Time From']}-\n'
                                    '${thisitem['To Time']}'),
                              ),
                              Align(alignment:Alignment.center,
                                  child: Text('${thisitem['Meeting Name']}')),
                              Align(alignment:Alignment.topRight,
                                child: RichText(
                                  text:  TextSpan(
                                      children: [
                                        const WidgetSpan(child: Icon(Icons.location_on)),
                                        TextSpan(text: ('${thisitem['Place']}'),style: const TextStyle(color: Colors.black)
                                        )
                                      ]
                                  ),
                                ),
                              ),
                            ]
                        ),

                        //ERODE LOCATION ICON RICHTEXT STARTS

                        //    const SizedBox(width: 50,),

                        //    const SizedBox(width: 20,),
                        //const Icon(Icons.thumb_up_outlined,color: Colors.green,size: 20,),
                        //  const SizedBox(width: 20,),
                        //  const Icon(Icons.person_add,color: Colors.green,size: 20,),
                      ],
                    ),
                  ),
                ),
              );

            })
    );
  }
}

class CompletedTeamMeeting extends StatelessWidget {

  CompletedTeamMeeting({Key? key}) : super(key: key);
  String type = "Team Meeting";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: 10,
            itemBuilder:(context, index){
              // String docId = streamSnapshot.data!.docs[index].id;
              Map thisitem = [index] as Map;
              // const SizedBox(height:2);
              const SizedBox(height: 20,);
              return Expanded(
                child: Card(
                  //   elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            //DATE TEXT STARTS
                            //   const SizedBox(width: 23,),
                            //  SizedBox(height: 30,),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('${thisitem['Meeting Date']}',
                                //format(DateTime.now()),style:  TextStyle(color: Colors.green[900],fontWeight:FontWeight.bold),
                              ),
                            ),

                            //TIME TEXT STARTS


                            //format(DateTime.now()),),
                          ],
                        ),
                        //NETWORK MEETING TEXT STARTS
                        //   const SizedBox(width: 30,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(alignment:Alignment.topLeft,
                                child: Text('${thisitem['Time From']}-\n'
                                    '${thisitem['To Time']}'),
                              ),
                              Align(alignment:Alignment.center,
                                  child: Text('${thisitem['Meeting Name']}')),
                              Align(alignment:Alignment.topRight,
                                child: RichText(
                                  text:  TextSpan(
                                      children: [
                                        const WidgetSpan(child: Icon(Icons.location_on)),
                                        TextSpan(text: ('${thisitem['Place']}'),style: const TextStyle(color: Colors.black)
                                        )
                                      ]
                                  ),
                                ),
                              ),
                            ]
                        ),

                        //ERODE LOCATION ICON RICHTEXT STARTS

                        //    const SizedBox(width: 50,),

                        //    const SizedBox(width: 20,),
                        //const Icon(Icons.thumb_up_outlined,color: Colors.green,size: 20,),
                        //  const SizedBox(width: 20,),
                        //  const Icon(Icons.person_add,color: Colors.green,size: 20,),
                      ],
                    ),
                  ),
                ),
              );
            })
    );
  }
}

class TrainingProgram extends StatelessWidget {
  const TrainingProgram({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 20,width: 100,
            ),

            //MAIN CONTAINER STARTS
            Container(
              height: 35,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),

              //TABBAR STARTS
              child: const TabBar(
                indicator: BoxDecoration(
                  color: Colors.green,
                ),
                //TABS STARTS
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: ('Upcoming')),
                  Tab(text: ('Completed')),
                ],
              ) ,
            ),
            const SizedBox(height: 20,),

            //TABBAR VIEW STARTS
            Expanded(
              child: TabBarView(children: [
                UpComingTrainingProgram(),
                CompletedTrainingProgram(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
class UpComingTrainingProgram extends StatelessWidget {
  UpComingTrainingProgram({Key? key}) : super(key: key);
  String type ="Training Program";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          /* gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),*/
            itemCount: 10,
            itemBuilder:(context, index){
              // String docId = streamSnapshot.data!.docs[index].id;
              Map thisitem = [index] as Map;
              // const SizedBox(height:2);
              const SizedBox(height: 20,);
              return Expanded(
                child: Card(
                  //   elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            //DATE TEXT STARTS
                            //   const SizedBox(width: 23,),
                            //  SizedBox(height: 30,),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('${thisitem['Meeting Date']}',
                                //format(DateTime.now()),style:  TextStyle(color: Colors.green[900],fontWeight:FontWeight.bold),
                              ),
                            ),

                            //TIME TEXT STARTS


                            //format(DateTime.now()),),
                          ],
                        ),
                        //NETWORK MEETING TEXT STARTS
                        //   const SizedBox(width: 30,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(alignment:Alignment.topLeft,
                                child: Text('${thisitem['Time From']}-\n'
                                    '${thisitem['To Time']}'),
                              ),
                              Align(alignment:Alignment.center,
                                  child: Text('${thisitem['Meeting Name']}')),
                              Align(alignment:Alignment.topRight,
                                child: RichText(
                                  text:  TextSpan(
                                      children: [
                                        const WidgetSpan(child: Icon(Icons.location_on)),
                                        TextSpan(text: ('${thisitem['Place']}'),style: const TextStyle(color: Colors.black)
                                        )
                                      ]
                                  ),
                                ),
                              ),
                            ]
                        ),

                        //ERODE LOCATION ICON RICHTEXT STARTS

                        //    const SizedBox(width: 50,),

                        //    const SizedBox(width: 20,),
                        //const Icon(Icons.thumb_up_outlined,color: Colors.green,size: 20,),
                        //  const SizedBox(width: 20,),
                        //  const Icon(Icons.person_add,color: Colors.green,size: 20,),
                      ],
                    ),
                  ),
                ),
              );

            })
    );
  }
}
class CompletedTrainingProgram extends StatelessWidget {
  CompletedTrainingProgram({Key? key}) : super(key: key);
  String type = "Training Program";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: 10,
            itemBuilder:(context, index){
              // String docId = streamSnapshot.data!.docs[index].id;
              Map thisitem = [index] as Map;
              // const SizedBox(height:2);
              const SizedBox(height: 20,);
              return Expanded(
                child: Card(
                  //   elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            //DATE TEXT STARTS
                            //   const SizedBox(width: 23,),
                            //  SizedBox(height: 30,),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('${thisitem['Meeting Date']}',
                                //format(DateTime.now()),style:  TextStyle(color: Colors.green[900],fontWeight:FontWeight.bold),
                              ),
                            ),

                            //TIME TEXT STARTS


                            //format(DateTime.now()),),
                          ],
                        ),
                        //NETWORK MEETING TEXT STARTS
                        //   const SizedBox(width: 30,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(alignment:Alignment.topLeft,
                                child: Text('${thisitem['Time From']}-\n'
                                    '${thisitem['To Time']}'),
                              ),
                              Align(alignment:Alignment.center,
                                  child: Text('${thisitem['Meeting Name']}')),
                              Align(alignment:Alignment.topRight,
                                child: RichText(
                                  text:  TextSpan(
                                      children: [
                                        const WidgetSpan(child: Icon(Icons.location_on)),
                                        TextSpan(text: ('${thisitem['Place']}'),style: const TextStyle(color: Colors.black)
                                        )
                                      ]
                                  ),
                                ),
                              ),
                            ]
                        ),

                        //ERODE LOCATION ICON RICHTEXT STARTS

                        //    const SizedBox(width: 50,),

                        //    const SizedBox(width: 20,),
                        //const Icon(Icons.thumb_up_outlined,color: Colors.green,size: 20,),
                        //  const SizedBox(width: 20,),
                        //  const Icon(Icons.person_add,color: Colors.green,size: 20,),
                      ],
                    ),
                  ),
                ),
              );
            })
    );
  }
}
class GIBMeeting extends StatelessWidget {
  const GIBMeeting ({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 20,width: 100,
            ),

            //MAIN CONTAINER STARTS
            Container(
              height: 35,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
              ),

              //TABBAR STARTS
              child: const TabBar(
                indicator: BoxDecoration(
                  color: Colors.green,
                ),
                //TABS STARTS
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: ('Upcoming')),
                  Tab(text: ('Completed')),
                ],
              ) ,
            ),
            const SizedBox(height: 20,),
            //TABBAR VIEW STARTS
            Expanded(
              child: TabBarView(children: [
                UpComingGIBMeeting(),
                CompletedGIBMeeting(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
class UpComingGIBMeeting extends StatelessWidget {
  UpComingGIBMeeting ({Key? key}) : super(key: key);
  String type = "GIB Meeting";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          /* gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),*/
            itemCount: 10,
            itemBuilder:(context, index){
              // String docId = streamSnapshot.data!.docs[index].id;
              Map thisitem = [index] as Map;
              // const SizedBox(height:2);
              const SizedBox(height: 20,);
              return Expanded(
                child: Card(
                  //   elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            //DATE TEXT STARTS
                            //   const SizedBox(width: 23,),
                            //  SizedBox(height: 30,),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('${thisitem['Meeting Date']}',
                                //format(DateTime.now()),style:  TextStyle(color: Colors.green[900],fontWeight:FontWeight.bold),
                              ),
                            ),

                            //TIME TEXT STARTS


                            //format(DateTime.now()),),
                          ],
                        ),
                        //NETWORK MEETING TEXT STARTS
                        //   const SizedBox(width: 30,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(alignment:Alignment.topLeft,
                                child: Text('${thisitem['Time From']}-\n'
                                    '${thisitem['To Time']}'),
                              ),
                              Align(alignment:Alignment.center,
                                  child: Text('${thisitem['Meeting Name']}')),
                              Align(alignment:Alignment.topRight,
                                child: RichText(
                                  text:  TextSpan(
                                      children: [
                                        const WidgetSpan(child: Icon(Icons.location_on)),
                                        TextSpan(text: ('${thisitem['Place']}'),style: const TextStyle(color: Colors.black)
                                        )
                                      ]
                                  ),
                                ),
                              ),
                            ]
                        ),

                      ],
                    ),
                  ),
                ),
              );
            })
    );
  }
}
class CompletedGIBMeeting extends StatelessWidget {
  CompletedGIBMeeting({Key? key}) : super(key: key);
  String type = "GIB Meeting";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: 10,
            itemBuilder:(context, index){
              // String docId = streamSnapshot.data!.docs[index].id;
              Map thisitem = [index] as Map;
              // const SizedBox(height:2);
              const SizedBox(height: 20,);
              return Expanded(
                child: Card(
                  //   elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            //DATE TEXT STARTS
                            //   const SizedBox(width: 23,),
                            //  SizedBox(height: 30,),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('${thisitem['Meeting Date']}',
                                //format(DateTime.now()),style:  TextStyle(color: Colors.green[900],fontWeight:FontWeight.bold),
                              ),
                            ),

                            //TIME TEXT STARTS


                            //format(DateTime.now()),),
                          ],
                        ),
                        //NETWORK MEETING TEXT STARTS
                        //   const SizedBox(width: 30,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(alignment:Alignment.topLeft,
                                child: Text('${thisitem['Time From']}-\n'
                                    '${thisitem['To Time']}'),
                              ),
                              Align(alignment:Alignment.center,
                                  child: Text('${thisitem['Meeting Name']}')),
                              Align(alignment:Alignment.topRight,
                                child: RichText(
                                  text:  TextSpan(
                                      children: [
                                        const WidgetSpan(child: Icon(Icons.location_on)),
                                        TextSpan(text: ('${thisitem['Place']}'),style: const TextStyle(color: Colors.black)
                                        )
                                      ]
                                  ),
                                ),
                              ),
                            ]
                        ),

                        //ERODE LOCATION ICON RICHTEXT STARTS

                        //    const SizedBox(width: 50,),

                        //    const SizedBox(width: 20,),
                        //const Icon(Icons.thumb_up_outlined,color: Colors.green,size: 20,),
                        //  const SizedBox(width: 20,),
                        //  const Icon(Icons.person_add,color: Colors.green,size: 20,),
                      ],
                    ),
                  ),
                ),
              );
            })
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<bool> callOnFcmApiSendPushNotifications(
      {required String title, required String body}) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "to": "/topics/myTopic",
      "notification": {
        "title": title,
        "body": body,
      },
      "data": {
        "type": '0rder',
        "id": '28',
        "click_action": 'FLUTTER_NOTIFICATION_CLICK',
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
      'AAAArh_P2i0:APA91bHPacqKa68WRxK9kyeMSWivbmmKlU3TzoSgjGvieHKMPLZtwrIaMPkgvO5HT6PebReUfzSTFJb2DiJ24fLosR31X-Z5-ZTKIEnF3s0oWK2_PPLT1a3B13t-BtpsLLyvyPsxcNim'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
      return true;
    } else {
      print(' CFM error');
      // on failure do sth
      return false;
    }
  }

  void _incrementCounter() {
    setState(() {
      callOnFcmApiSendPushNotifications(title: 'fcm by api2', body: 'its working fine2');
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}




