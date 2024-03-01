import 'package:flutter/material.dart';

class G2GHistory extends StatelessWidget {
  const G2GHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SlipHistory(),

    );
  }
}
class SlipHistory extends StatefulWidget {
  const SlipHistory({Key? key}) : super(key: key);

  @override
  State<SlipHistory> createState() => _SlipHistoryState();
}

class _SlipHistoryState extends State<SlipHistory> {
  String? uid="";
  String? mobile ="";
  String? firstname="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('G2G Slip History')),
      ),
      body:ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    Map fromitem = [index] as Map;
                    if (fromitem["Company Mobile"] == mobile||fromitem["Mobile"]==mobile)// || ||
                      //  fromitem["Mobile"] == mobile) {
                        {   return Center(
                      child: Column(
                        children: [
                          ExpansionTile(
                            leading: const Icon(Icons.info),
                            title: fromitem["Mobile"] != mobile ? Text('${fromitem["First Name"]}\n')
                                :Text('${fromitem["Met With"]}\n'),
                            children: [
                              //SizedBox(height: 10,),
                              Row(
                                children:[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                    child: Text('${fromitem["Company Name"]}\n'),
                                  ),
                                  /*Padding(
                                    padding: EdgeInsets.fromLTRB(90, 0, 0, 0),
                                    child: Text("10:30 AM"),
                                  ),*/
                                ],
                              ),
                              //  SizedBox(height: 10,),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                    child: Text('${fromitem["Met Date"]}\n'),
                                  ),
                                  /*Padding(
                                    padding: EdgeInsets.fromLTRB(92, 0, 0, 0),
                                    child: Text("10:10:2020"),
                                  )*/
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

    );
  }
}
