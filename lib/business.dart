import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'business_slip.dart';
import 'g2g_slip.dart';
import 'honor_slip.dart';
//import 'package:gib/guest_slip.dart';

class BusinessPage extends StatefulWidget {
  final String? userType;
  final String? userId;
  const BusinessPage({super.key, required this.userType, required this.userId});

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  String date = "Date";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('MY BUSINESS', style: Theme.of(context).textTheme.bodySmall)),
        ),

        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                //TABBAR STARTS
                TabBar(
                  isScrollable: true,
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(text: ('GiB Total Transaction'),),
                    Tab(text: ('My Transaction') ,),
                    Tab(text:('My Total Transaction'),
                    ),
                  ],
                )  ,
                //TABBAR VIEW STARTS
                Expanded(
                  child: TabBarView(children: <Widget>[
                    GibTransaction(),
                    MyTransaction(userId: widget.userId, userType: widget.userType),
                    MyTotalTransaction(),
                  ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class GibTransaction extends StatefulWidget {
  const GibTransaction({Key? key}) : super(key: key);

  @override
  State<GibTransaction> createState() => _GibTransactionState();
}
class _GibTransactionState extends State<GibTransaction> {
  late List<Map> from;
  late DateTime lastUpdated;

  String? name="";
  String? mobile="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                  height:150,
                  width:200,child: Image.asset('assets/logo.png')),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 190,
                      height: 150,
                      padding: const EdgeInsets.all(10.0),
                      child:Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.pinkAccent.shade400,
                                        Colors.pink.shade300,
                                        Colors.pinkAccent.shade700,
                                      ]
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    const SizedBox(width: 15,),
                                    Text('Business', style: Theme.of(context).textTheme.headline3,),
                                    const SizedBox(height: 10,),
                                    Text('Business Year : totalYears', style:const TextStyle(color: Colors.white)),
                                    const SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        Text(
                                          "Upto ${DateFormat.yM().format(DateTime.now())} : ",
                                          style: Theme.of(context).textTheme.titleLarge,
                                        ),
                                        Text(
                                          'docLength',
                                          style: Theme.of(context).textTheme.titleLarge,
                                        )
                                      ],
                                    ),

                                    const SizedBox(height: 10,),
                                  ],
                                ),
                              ),
                            )

                  ),
                  // Card ends
                  Container(
                    width: 190,
                    height: 150,
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),),
                              elevation: 10,
                              color: Colors.lightGreenAccent,
                              // Card link starts
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [Colors.brown.shade500,
                                        Colors.brown.shade400, Colors.brown.shade800,
                                      ]
                                  ),
                                  //  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    const SizedBox(width: 15,),
                                    Text('G2G', style: Theme.of(context).textTheme.headline3,),
                                    const SizedBox(height: 10,),
                                    Text('Business Year: totalYears ', style: const TextStyle(color: Colors.white)),
                                    const SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text(
                                          "Upto ${DateFormat.yM().format(DateTime.now())} : ",
                                          style: Theme.of(context).textTheme.titleLarge,
                                        ),
                                        Text(
                                          'docLength',
                                          style: Theme.of(context).textTheme.titleLarge,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Card link ends
                            )

                  )],
              ),

              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 190,
                    height: 150,
                    padding: const EdgeInsets.all(10.0),
                    child:Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 10,
                              color: Colors.limeAccent,
                              // Card link starts
                              child: Container(
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.blueGrey.shade900,
                                        Colors.blueGrey.shade600,
                                        Colors.grey.shade900,
                                      ]
                                  ),
                                  //  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    const SizedBox(width: 15,),
                                    Text('Guest',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline3,),
                                    const SizedBox(height: 10,),
                                    Text('Business Year: totalYears',style: const TextStyle(color: Colors.white),),
                                    const SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text("Upto ",  style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6),

                                        Text(DateFormat.yM().format(DateTime.now() ),  style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6),Text(" : ",  style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6),
                                        Text("docLength",style:TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Card link ends
                            )
                  ),
                  Container(
                    width: 190,
                    height: 150,
                    padding: const EdgeInsets.all(10.0),
                    child:Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 10,
                              color: Colors.red[200],
                              // Card link starts
                              child: Container(
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.blue.shade900,
                                        Colors.blueAccent.shade400,
                                        Colors.lightBlue.shade900,
                                      ]
                                  ),
                                  //  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),),

                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    const SizedBox(width: 15,),
                                    Text('Honoring',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline3,),
                                    const SizedBox(height: 10,),
                                    Text('Business Year: totalYears',style: TextStyle(color: Colors.white), ),
                                    const SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text("Upto ",  style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6),

                                        Text(DateFormat.yM().format(DateTime.now() ),  style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6),Text(" : ",  style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6),
                                        Text("totalAmount1",style:const TextStyle(color:Colors.white)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Card link ends
                            )
                  ),
                ],
              ),
              const SizedBox(height: 10,),
            ],
          ),

        ),
      ),
    );

  }

}



class MyTransaction extends StatefulWidget {
  final String? userId;
  final String? userType;
  const MyTransaction({Key? key, required this.userId, required this.userType}) : super(key: key);

  @override
  State<MyTransaction> createState() => _MyTransactionState();
}

class _MyTransactionState extends State<MyTransaction> {
  late List<Map> from;
  String? name="";
  String? mobile="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/logo.png'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 190,
                    height: 150,
                    padding: const EdgeInsets.all(10.0),
                    child:Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 10,
                              color: Colors.red[200],
                              // Card link starts
                              child:  Container(
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.teal.shade500,
                                        Colors.tealAccent.shade400,
                                        Colors.teal.shade400,
                                      ]
                                  ),
                                  //  border: Border.all(),
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                ),
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    const SizedBox(width: 15,),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(width: 20,),
                                        Text('Business',
                                          style: Theme.of(context).textTheme.displaySmall,),
                                        const SizedBox(width: 10,),
                                        IconButton(
                                            onPressed: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => ReferralPage(userType: widget.userType, userId: widget.userId,)),
                                              );
                                            },
                                            icon: const Icon(Icons.add_circle,color: Colors.white,))
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    Text('Business Year: totalYears',style: TextStyle(color: Colors.white)),
                                    const SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text("Upto ",  style: Theme
                                            .of(context).textTheme.titleLarge),
                                        Text(DateFormat.yM().format(DateTime.now() ),  style: Theme
                                            .of(context).textTheme.titleLarge),Text(" : ",  style: Theme
                                            .of(context).textTheme.titleLarge),
                                        Text('docLength', style: Theme.of(context).textTheme.titleLarge),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Card link ends
                            )



                    /*StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Business Slip")
                            .where("Date",isGreaterThanOrEqualTo: DateFormat('dd/MM/yyyy').format(DateTime.now()))
                            .where("Date",isGreaterThanOrEqualTo: DateTime.now().subtract(const Duration(days: 1)))
                            .snapshots(),
                        builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            QuerySnapshot<Object?>? querySnapshot = streamSnapshot.data;
                            List<QueryDocumentSnapshot> documents = querySnapshot!.docs;
                            List<Map> from = documents.map((e) => {
                              "id": e.id,}).toList();
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 10,
                              color: Colors.red[200],
                              // Card link starts
                              child:  Container(
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.teal.shade500,
                                        Colors.tealAccent.shade400,
                                        Colors.teal.shade400,
                                      ]
                                  ),
                                  //  border: Border.all(),
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),


                                ),
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    const SizedBox(width: 15,),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(width: 20,),
                                        Text('Business',
                                          style: Theme.of(context).textTheme.headline3,),
                                        const SizedBox(width: 10,),
                                        IconButton(
                                            onPressed: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) =>  const Referral()),
                                              );
                                            },
                                            icon: const Icon(Icons.add_circle,color: Colors.white,))
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    Text('Business Year: 103',style: Theme.of(context).textTheme.headline6),
                                    const SizedBox(height: 10,),
                                    Row(
                              children: [
                                Text("Upto ",  style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline6),

                                Text(DateFormat.yM().format(DateTime.now() ),  style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline6),Text(" : ",  style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline6),
                                Text('${streamSnapshot.data!.docs
                                    .length}', style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline6),
                              ],
                            ),
                                  ],
                                ),
                              ),
                              // Card link ends
                            );
                          }return Container();
                        }),*/
                    // Card ends
                  ),
                  // Card ends
                  Container(
                    width: 190,
                    height: 150,
                    padding: const EdgeInsets.all(10.0),
                    child:Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 10,
                              color: Colors.red[200],
                              // Card link starts
                              child: Container(
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.lime.shade900,
                                        Colors.lime.shade700,
                                        Colors.lime.shade800,
                                      ]
                                  ),
                                  //  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                ),

                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    const SizedBox(width: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(width: 20,),
                                        Text('G2G',
                                          style: Theme.of(context).textTheme.headline3,),
                                        const SizedBox(width: 10,),
                                        IconButton(
                                            onPressed: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) =>  const  GtoG()),
                                              );
                                            },
                                            icon: const Icon(Icons.add_circle,color: Colors.white,))
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    Text('Business Year: totalYears', style: const TextStyle(color: Colors.white)),
                                    const SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text("Upto ",  style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6),

                                        Text(DateFormat.yM().format(DateTime.now() ),  style: Theme
                                            .of(context).textTheme.titleLarge),Text(" : ",  style: Theme
                                            .of(context).textTheme.titleLarge),
                                        Text('docLength',style: const TextStyle(color:Colors.white),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Card link ends
                            )

                    // Card ends
                  ),
                  // Card ends
                ],
              ),

              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Card ends
                  Container(
                      width: 400,
                      height: 150,
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                elevation: 10,
                                color: Colors.red[200],
                                // Card link starts
                                child: Container(
                                  decoration:
                                  BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.pink.shade900,
                                          Colors.pinkAccent.shade700,
                                          Colors.pink.shade400,
                                        ]
                                    ),
                                    //  border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(width: 15,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(width: 20,),
                                          Text('Honoring',
                                            style: Theme.of(context).textTheme.headline3,),
                                          const SizedBox(width: 10,),
                                          IconButton(
                                              onPressed: (){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) =>  const ThankNotes()),
                                                );
                                              },
                                              icon: const Icon(Icons.add_circle,color: Colors.white,))
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Text('Business Year: totalYears', style: TextStyle(color: Colors.white)),
                                      const SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Upto ",  style: Theme
                                              .of(context)
                                              .textTheme
                                              .titleLarge),

                                          Text(DateFormat.yM().format(DateTime.now() ),  style: Theme
                                              .of(context)
                                              .textTheme
                                              .titleLarge),Text(" : ",  style: Theme
                                              .of(context)
                                              .textTheme
                                              .titleLarge),
                                          Text( 'totalamount', style: Theme
                                              .of(context)
                                              .textTheme
                                              .titleLarge),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Card link ends
                              )

                  ),
                  // Card ends
                ],
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
class MyTotalTransaction extends StatefulWidget {
  const MyTotalTransaction({Key? key}) : super(key: key);

  @override
  State<MyTotalTransaction> createState() => _MyTotalTransactionState();
}

class _MyTotalTransactionState extends State<MyTotalTransaction> {
  String? mobile="";
  String? name="";

  @override
  void initState() {
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/logo.png'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 190,
                    height: 150,
                    padding: const EdgeInsets.all(10.0),
                    child:Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 10,
                              color: Colors.red[200],
                              // Card link starts
                              child: Container(
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.deepPurple.shade300,
                                        Colors.purpleAccent.shade200,
                                        Colors.purpleAccent.shade400,
                                      ]
                                  ),
                                  //  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),),
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    const SizedBox(width: 15,),
                                    Text('Business',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline3,),
                                    const SizedBox(height: 10,),
                                    Text('Business Year: totalYears', style: const TextStyle(color: Colors.white)),
                                    const SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text("Upto ",  style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6),

                                        Text(DateFormat.yM().format(DateTime.now() ),  style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6),Text(" : ",  style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6),
                                        Text( 'streamSnapshot.data!.docs', style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Card link ends
                            )
                  ),
                  // Card ends
                  Container(
                    width: 190,
                    height: 150,
                    padding: const EdgeInsets.all(10.0),
                    child:Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 10,
                              color: Colors.red[200],
                              // Card link starts
                              child: Container(
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.teal.shade600,
                                        Colors.tealAccent.shade700,
                                        Colors.teal.shade900,
                                      ]
                                  ),
                                  //  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),


                                ),

                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    const SizedBox(width: 15,),
                                    Text('G2G',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline3,),
                                    const SizedBox(height: 10,),
                                    Text('Business Year: totalYears', style: TextStyle(color: Colors.white)),
                                    const SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text("Upto ",  style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6),

                                        Text(DateFormat.yM().format(DateTime.now() ),  style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6),Text(" : ",  style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6),
                                        Text( 'streamSnapshot.data!.docs', style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Card link ends
                            )
                  ),
                ],
              ),

              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 190,
                    height: 150,
                    padding: const EdgeInsets.all(10.0),
                    child:Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 10,
                              color: Colors.red[200],
                              // Card link starts
                              child: Container(
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.amberAccent.shade700,
                                        Colors.amber.shade400,
                                        Colors.yellow.shade900,
                                      ]
                                  ),
                                  //  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    const SizedBox(width: 15,),
                                    Text('Guest', style: Theme.of(context).textTheme.headline3,),
                                    const SizedBox(height: 10,),
                                    Text('Business Year: totalYears', style: TextStyle(color: Colors.white)),
                                    const SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text("Upto ",  style: Theme.of(context).textTheme.headline6),

                                        Text(DateFormat.yM().format(DateTime.now() ),  style: Theme.of(context)
                                            .textTheme.headline6),Text(" : ",  style: Theme.of(context).textTheme.headline6),
                                        Text( 'streamSnapshot.data!.docs', style: Theme.of(context).textTheme.headline6),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Card link ends
                            )
                    // Card ends
                  ),
                  //Card ends
                  Container(
                    width: 190,
                    height: 150,
                    padding: const EdgeInsets.all(10.0),
                    child:Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 10,
                              color: Colors.red[200],
                              // Card link starts
                              child: Container(
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.red.shade700,
                                        Colors.redAccent.shade200,
                                        Colors.red.shade900,
                                      ]
                                  ),
                                  //  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),),
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    const SizedBox(width: 15,),
                                    Text('Honoring',
                                      style: Theme.of(context).textTheme.displaySmall,),
                                    const SizedBox(height: 10,),
                                    Text('Business Year: totalYears', style: const TextStyle(color: Colors.white)),
                                    const SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text("Upto ",  style: Theme.of(context).textTheme.titleLarge),

                                        Text(DateFormat.yM().format(DateTime.now() ),  style: Theme
                                            .of(context).textTheme.titleLarge),Text(" : ",  style: Theme.of(context).textTheme.headline6),
                                        Text( 'totalAmount', style: Theme.of(context).textTheme.titleLarge),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Card link ends
                            )
                  ),
                  // Card ends
                ],
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}




