import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SlipHistory extends StatelessWidget {
  const SlipHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BusinessHistory(),
    );
  }
}
class BusinessHistory extends StatefulWidget {
  const BusinessHistory({Key? key}) : super(key: key);

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
          title: const Text("Business History"),
          centerTitle: true,
        ),

        body: Column(
          children: const [
            TabBar(
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
                  Pending(),
                  Completed(),
                  Unsuccessful(),
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
  const Completed({Key? key}) : super(key: key);

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
  const Pending({Key? key}) : super(key: key);

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  //String? name = "";
  // String? companyname ="";
  // String? location ="";
  // String? purpose="";
  // String? to="";
  // String? typeofvisitor="";
  String? uid="";
  String? mobile ="";
  String? firstname ="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String status = "Pending";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:


        Center(
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
        )
      /*ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      Map fromitem = [index] as Map;
                      if (fromitem["To Mobile"] == mobile || fromitem["Mobile"] == mobile) {
                        return Center(
                          child: Column(
                            children: [
                              ExpansionTile(
                                leading: fromitem["Mobile"] != mobile
                                    ? Icon(Icons.call_received, color: Colors.green[800],)
                                    : const Icon(Icons.call_made, color: Colors.red,),
                                title:fromitem["Mobile"] ==mobile
                                    ? Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Padding(
                                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20,),
                                          Text('${fromitem["To Name"]}\n'),
                                        ],
                                      ),
                                    ),

                                    IconButton(
                                        onPressed: () async {
                                          final call = Uri.parse("tel://""${fromitem["To Mobile"]}");
                                          if (await canLaunchUrl(call)) {
                                            launchUrl(call);
                                          } else {
                                            throw 'Could not launch $call';
                                          }
                                        },
                                        icon: const Icon(Icons.call,color: Colors.green,)),
                                  ],
                                )
                                    : Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${fromitem["First Name"]}\n'),
                                    IconButton(
                                        onPressed: () async {
                                          final call = Uri.parse("tel://""${fromitem["Mobile"]}");
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
                                        child: Text("Referrer Name :"'${fromitem["Referrer Name"]}\n'),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            final call = Uri.parse("tel://""${fromitem["Referrer Mobile"]}");
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
                                        child: Text("Purpose : " '${fromitem["Purpose"]}\n'),
                                      ),
                                    ],
                                  ),


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                        child:  Text('Date   :'"${fromitem["Date"]}"),

                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                        child: Text('Reason  : '"${fromitem["Hold Reason"]}"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      return Container();
                    }
                )
*/
    );

  }
}

class Unsuccessful extends StatefulWidget {
  const Unsuccessful({Key? key}) : super(key: key);

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



