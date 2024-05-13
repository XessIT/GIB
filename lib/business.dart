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
          centerTitle: true,

          title: (Text('MY BUSINESS', style: Theme.of(context).textTheme.bodySmall)
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

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
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Network Image
                      Container(
                        height: 110,
                        width: double.infinity,
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.green], // Gradient colors
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bussiness Year", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                  SizedBox(height: 10,),
                                  SizedBox(height: 10,),
                                  Text("Upto Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage('assets/letter-b.png'),
                                  ),
                                ],

                              ),
                            ],
                          ),
                        ),

                      ),
                      // Text "Business"
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Business',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), /// Bussiness year
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Network Image
                      Container(
                        height: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [Color(0xFFE4E6F1), Color(0xFFCBD6EE)], // Gradient colors
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),

                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bussiness Year", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),),
                                  SizedBox(height: 10,),
                                  SizedBox(height: 10,),
                                  Text("Upto Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage('assets/G2G.png'),
                                  ),
                                ],

                              ),
                            ],
                          ),
                        ),
                      ),
                      // Text "Business"
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'G2G',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),  ///G2G
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Network Image
                      Container(
                        height: 110,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF6096B4), Color(0xFF93BFCF)], // Gradient colors
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bussiness Year", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                  SizedBox(height: 10,),
                                  SizedBox(height: 10,),
                                  Text("Upto Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage('assets/letter-g.png'),
                                  ),
                                ],

                              ),
                            ],
                          ),
                        ),
                      ),
                      // Text "Business"
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Guest',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), /// guest
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Network Image
                      Container(
                        height: 110,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFADD8E6), Color(0xFF98FB98)], // Gradient colors (Light blue and light green)
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bussiness Year", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                  SizedBox(height: 10,),
                                  SizedBox(height: 10,),
                                  Text("Upto Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage('assets/letter-h.png'),
                                  ),
                                ],

                              ),
                            ],
                          ),
                        ),
                      ),
                      // Text "Business"
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Honoring',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),  /// Hounrint
              SizedBox(height: 20,),

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
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Network Image
                      Container(
                        height: 110,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.green], // Gradient colors
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bussiness Year", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                  SizedBox(height: 10,),
                                  SizedBox(height: 10,),
                                  Text("Upto Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage('assets/letter-b.png'),
                                  ),
                                ],

                              ),
                            ],
                          ),
                        ),

                      ),
                      // Text "Business"
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("     "),
                            Text(
                              'Business',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ReferralPage(userType: widget.userType, userId: widget.userId,)),
                              );
                            }, icon: Icon(Icons.chevron_right,color: Colors.black,),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ), /// Bussiness year
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Network Image
                      Container(
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [Color(0xFFE4E6F1), Color(0xFFCBD6EE)], // Gradient colors
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),

                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bussiness Year", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),),
                                  SizedBox(height: 10,),
                                  SizedBox(height: 10,),
                                  Text("Upto Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage('assets/G2G.png'),
                                  ),
                                ],

                              ),
                            ],
                          ),
                        ),
                      ),
                      // Text "Business"
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("     "),
                            Text(
                              'G2G',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  const  GtoG()),
                              );
                            }, icon: Icon(Icons.chevron_right,color: Colors.black,),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),  ///G2G
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Network Image
                      Container(
                        height: 110,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF6096B4), Color(0xFF93BFCF)], // Gradient colors
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bussiness Year", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                  SizedBox(height: 10,),
                                  SizedBox(height: 10,),
                                  Text("Upto Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage('assets/letter-g.png'),
                                  ),
                                ],

                              ),
                            ],
                          ),
                        ),
                      ),
                      // Text "Business"
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("     "),
                            Text(
                              'Hounoring',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  const ThankNotes()),
                              );
                            }, icon: Icon(Icons.chevron_right,color: Colors.black,),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ), /// guest
            ]
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
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Network Image
                      Container(
                        height: 110,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.green], // Gradient colors
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bussiness Year", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                  SizedBox(height: 10,),
                                  SizedBox(height: 10,),
                                  Text("Upto Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage('assets/letter-b.png'),
                                  ),
                                ],

                              ),
                            ],
                          ),
                        ),

                      ),
                      // Text "Business"
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Business',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), /// Bussiness year
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Network Image
                      Container(
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [Color(0xFFE4E6F1), Color(0xFFCBD6EE)], // Gradient colors
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),

                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bussiness Year", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),),
                                  SizedBox(height: 10,),
                                  SizedBox(height: 10,),
                                  Text("Upto Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage('assets/G2G.png'),
                                  ),
                                ],

                              ),
                            ],
                          ),
                        ),
                      ),
                      // Text "Business"
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'G2G',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),  ///G2G
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Network Image
                      Container(
                        height: 110,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF6096B4), Color(0xFF93BFCF)], // Gradient colors
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bussiness Year", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                  SizedBox(height: 10,),
                                  SizedBox(height: 10,),
                                  Text("Upto Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage('assets/letter-g.png'),
                                  ),
                                ],

                              ),
                            ],
                          ),
                        ),
                      ),
                      // Text "Business"
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Guest',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), /// guest
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Network Image
                      Container(
                        height: 110,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFADD8E6), Color(0xFF98FB98)], // Gradient colors (Light blue and light green)
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bussiness Year", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                  SizedBox(height: 10,),
                                  SizedBox(height: 10,),
                                  Text("Upto Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage('assets/letter-h.png'),
                                  ),
                                ],

                              ),
                            ],
                          ),
                        ),
                      ),
                      // Text "Business"
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Honoring',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),  /// Hounrint
              SizedBox(height: 20,),

            ],

          ),
        ),
      ),
    );
  }
}




