import 'package:flutter/material.dart';

class HonorHistory extends StatelessWidget {
  const HonorHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HonorSlip(),);
  }
}

class HonorSlip extends StatefulWidget {
  const HonorSlip({Key? key}) : super(key: key);

  @override
  State<HonorSlip> createState() => _HonorSlipState();
}

class _HonorSlipState extends State<HonorSlip> {
  String? name = "";
  String? mobile = "";
  String? purpose = "";
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
      appBar: AppBar(
        title: const Text("Honoring History"),
        centerTitle: true,
      ),
      body: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    Map fromitem = [index] as Map;
                    if (fromitem["To Mobile"] == mobile ||
                        fromitem["HonorMobile"] == mobile) {
                      return Center(
                        child: Column(
                          children: [
                            ExpansionTile(
                                leading:fromitem["HonorMobile"]!=mobile ?const Icon(Icons.call_received, color: Colors.red,)
                                    :   Icon(Icons.call_made, color: Colors.green[800],),
                                title: fromitem["HonorMobile"] != mobile ? Text(
                                    "${fromitem["First Name"]}") :
                                Text("${fromitem["To"]}"),

                                children:[ Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children:  [
                                    Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                            child:fromitem["HonorMobile"]!=mobile ? Text('Name  :'"${fromitem["Name"]}",) : Text('Name  :'"${fromitem["First Name"]}",)
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children:  [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                            child: Row(
                                              children: [
                                                Text('Purpose  :${fromitem["Purpose"]}'),
                                                //  Text(purpose!),
                                              ],
                                            ),
                                          ),
                                        ]
                                    ),
                                    const SizedBox(height: 10,),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children:  [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                          child: Text('Date   :${fromitem["Date"]}'),
                                        ),

                                      ],
                                    )
                                  ],
                                ),]
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
/*class PauseReason extends StatefulWidget {
  const PauseReason({Key? key}) : super(key: key);

  @override
  State<PauseReason> createState() => _PauseReasonState();
}

class _PauseReasonState extends State<PauseReason> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Reason ?",),
          centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
          ],
        ),
      ),

    );
  }
}*/

