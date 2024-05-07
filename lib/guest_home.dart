import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'change_mpin.dart';
import 'guest_profile.dart';
import 'login.dart';

class GuestHome extends StatelessWidget {
  final String? userType;
  final String? userId;
   GuestHome({
     Key? key,
     required this. userType,
     required this. userId,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GuestHomePage(
        userType: userType,
        userId: userId,
        ),
    );
  }
}

class GuestHomePage extends StatefulWidget {

  final String? userType;
  final String? userId;


  GuestHomePage({Key? key,

    required this.userId,
    required this. userType,

  }) : super(key: key);

  @override
  State<GuestHomePage> createState() => _GuestHomePageState();
}

class _GuestHomePageState extends State<GuestHomePage> {
  Uint8List? _imageBytes;
  List<Map<String,dynamic>>userdata=[];
  Future<void> fetchData(String? userId) async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/registration.php?table=registration&id=$userId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>) {
          setState(() {
            userdata = responseData.cast<Map<String, dynamic>>();
            if (userdata.isNotEmpty) {
              setState(() {
                _imageBytes = base64Decode(userdata[0]['profile_image']);
              });
              print("Image: $_imageBytes");
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


  ///offers fetch
  List<Map<String,dynamic>>offersdata=[];
  Future<void> offersfetchData() async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/offers.php?table=offers');
      final response = await http.get(url);
      print(url);

      if (response.statusCode == 200) {
        // print("status code: ${response.statusCode}");
        // print("status body: ${response.body}");

        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>) {
          setState(() {
            offersdata = responseData.cast<Map<String, dynamic>>();
            //  print("offers data : $offersdata");
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
    super.initState();
    offersfetchData();
    fetchData(widget.userId);
  }

  //  final CalendarController _calendarController =  CalendarController();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    offersfetchData();
    fetchData(widget.userId);

    return Scaffold(
   //   backgroundColor: Colors.green[50],
      drawer:  SafeArea(
          child: NavDrawer(

            userType:widget.userType.toString(),
            userId:widget.userId.toString(),
          )),
      appBar: AppBar(centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_active_outlined))
        ],
        iconTheme:  IconThemeData(
          color: Colors.white, // Set the color for the drawer icon
        ),
        title: Text("GIB",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green.shade900,
        child: Row(
          children: [
            SizedBox(width:20,height:20,child: IconButton(icon: Icon(Icons.search,color: Colors.white,), onPressed: () {})),
            Spacer(),
            SizedBox(width:20,height:20,child: IconButton(icon: Icon(Icons.people_alt_outlined,color: Colors.white,), onPressed: () {})),

            Spacer(),
            SizedBox(width:20,height:20,child: IconButton(icon: Icon(Icons.home_outlined,color: Colors.white,), onPressed: () {})),

            Spacer(),
            SizedBox(width:20,height:20,child: IconButton(icon: Icon(Icons.settings_outlined,color: Colors.white,), onPressed: () {})),
            Spacer(),
            SizedBox(width:20,height:20,child: IconButton(icon: Icon(Icons.bloodtype_outlined,color: Colors.white,), onPressed: () {})),
          ],
        ),
      ),


      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // const SizedBox(height: 20,),
              //1st container
              SafeArea(
                child: SizedBox(
                  width: w,
                  height: 100,
                  child: Row(
                    children: [
                       Padding(
                        padding: EdgeInsets.only(left:8.0),
                        child: Container(
                          height: 100,
                          width: 100,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: ClipOval(
                              child: _imageBytes != null
                                  ? Image.memory(
                                _imageBytes!,
                              )
                                  : Icon(Icons.person),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10,),

                            Text(
                           userdata.isNotEmpty?   userdata[0]["first_name"]:"",
                              style: GoogleFonts.aBeeZee(
                                fontSize: 20,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('memberid!',
                                //   style: GoogleFonts.aBeeZee(
                                //     fontSize: 10,
                                //     color: Colors.indigo,
                                //     fontWeight: FontWeight.bold,
                                //   ),),
                                //  Text('${widget.userType}',
                                Text('Guest',
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 10,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                  ),),

                               /* Text( DateFormat()
                                // displaying formatted date
                                    .format(DateTime.now()),
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 10,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                  ),),*/
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: w,
                // height: 900,
                decoration:   BoxDecoration(
                    color: Colors.green.shade900,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('     Offers',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        height: 700,
                        child: Row(
                          children: offersdata.map((offer) {
                            String companyName = offer['company_name'] ?? '';
                            String name = offer['name'] ?? '';
                            String offerImage = offer['offer_image'] ?? '';
                            // print("image - $offerImage");

                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: offerImage.isNotEmpty ? Image.network("GIBAPI/$offerImage", fit: BoxFit.cover) : Image.asset("assets/img_1.png"), // Use placeholder image if offerImage is empty
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text("$companyName\n$name", style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

/*
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        child: Row(
                          children: [
                            SizedBox(width: 15,),
                            Column(
                              children: [
                                Container(
                                  width: 120,
                                  decoration: BoxDecoration(

                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset("assets/img_1.png"),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("Zappy\nPhotography",style: Theme.of(context).textTheme.subtitle2,),

                                  ],
                                )
                              ],
                            ),
                            SizedBox(width: 10,),

                            Column(
                              children: [
                                Container(
                                  width: 120,
                                  decoration: BoxDecoration(

                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset("assets/img_1.png"),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("Zappy\nPhotography",style: Theme.of(context).textTheme.subtitle2,),

                                  ],
                                )
                              ],
                            ),
                            SizedBox(width: 10,),

                            Column(
                              children: [
                                Container(
                                  width: 120,
                                  decoration: BoxDecoration(

                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset("assets/img_1.png"),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("Zappy\nPhotography",style: Theme.of(context).textTheme.subtitle2,),

                                  ],
                                )
                              ],
                            ),
                            SizedBox(width: 10,),

                            Column(
                              children: [
                                Container(
                                  width: 120,
                                  decoration: BoxDecoration(

                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset("assets/img_1.png"),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("Zappy\nPhotography",style: Theme.of(context).textTheme.subtitle2,),

                                  ],
                                )
                              ],
                            ),
                            SizedBox(width: 10,),

                            Column(
                              children: [
                                Container(
                                  width: 120,
                                  decoration: BoxDecoration(

                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset("assets/img_1.png"),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("Zappy\nPhotography",style: Theme.of(context).textTheme.subtitle2,),

                                  ],
                                )
                              ],
                            ),
                            SizedBox(width: 10,),

                            Column(
                              children: [
                                Container(
                                  width: 120,
                                  decoration: BoxDecoration(

                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset("assets/img_1.png"),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("Zappy\nPhotography",style: Theme.of(context).textTheme.subtitle2,),

                                  ],
                                )
                              ],
                            ),
                            SizedBox(width: 10,),

                            Column(
                              children: [
                                Container(
                                  width: 120,
                                  decoration: BoxDecoration(

                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset("assets/img_1.png"),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("Zappy\nPhotography",style: Theme.of(context).textTheme.subtitle2,),

                                  ],
                                )
                              ],
                            ),
                            SizedBox(width: 10,),


                          ],
                        ),
                      ),
                    ),
*/

                 /*   const SizedBox(height: 15,),
                    Container(
                      width: 390,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.white, Colors.white,
                          ],
                        ),
                        border: Border.all(
                            color: Colors.white,width: 2),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child:
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 210,
                                width: 180,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.black,
                                    ),),
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                          onPressed: (){},
                                          icon:  const Icon(
                                            Icons.call_outlined,
                                            color: Colors.green,)),),
                                    CircleAvatar(
                                      radius: 45,
                                      backgroundColor: Colors.cyan,
                                      backgroundImage: const
                                      AssetImage('assets/car.jpg'),
                                      child: Stack(
                                        children: const [
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: CircleAvatar(
                                                radius: 18.5,
                                                backgroundColor: Colors.green,
                                                child: Text('10%',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15,),
                                    const Text('A1 Car Accessories',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),),
                                    const SizedBox(height: 15,),
                                    const Text('product -Ceramic Coating',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),),
                                    const SizedBox(width: 1,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('Validity -',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),),
                                        Text(DateFormat
                                          ('dd/MM/yyyy').
                                        format(DateTime.now(),),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              //       VerticalDivider(width: 5,thickness: 1,color: Colors.black,),
                              Container(
                                height: 210,
                                width: 180,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                          onPressed: (){},
                                          icon:  const Icon(
                                            Icons.call_outlined,
                                            color: Colors.green,)),),
                                    CircleAvatar(
                                      radius: 45,
                                      backgroundColor: Colors.cyan,
                                      backgroundImage: const AssetImage('assets/ro.jpg'),
                                      child: Stack(
                                        children: const [
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.green,
                                                child: Text('15%',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15,),
                                    const Text('Jm Technology',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold), ),
                                    const SizedBox(height: 15,),
                                    const Text('Service -Ro System',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),),

                                    const SizedBox(width: 1,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('Validity -',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),),
                                        Text(DateFormat
                                          ('dd/MM/yyyy').
                                        format(DateTime.now(),),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.black,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 210,
                                width: 180,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.black,
                                    ),),
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                          onPressed: (){},
                                          icon:  const Icon(
                                            Icons.call_outlined,
                                            color: Colors.green,)),),
                                    CircleAvatar(
                                      radius: 45,
                                      backgroundColor: Colors.cyan,
                                      backgroundImage: const
                                      AssetImage('assets/car.jpg'),
                                      child: Stack(
                                        children: const [
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.green,
                                                child: Text('10%',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15,),
                                    const Text('A1 Car Accessories',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),),
                                    const SizedBox(height: 15,),
                                    const Text('product -Ceramic Coating',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),),
                                    const SizedBox(width: 1,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('Validity -',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),),
                                        Text(
                                          DateFormat('dd/MM/yyyy').
                                          format(DateTime.now(),),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              //       VerticalDivider(width: 5,thickness: 1,color: Colors.black,),
                              Container(
                                height: 210,
                                width: 180,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                          onPressed: (){},
                                          icon:  const Icon(Icons.call_outlined,
                                            color: Colors.green,)),),
                                    CircleAvatar(
                                      radius: 45,
                                      backgroundColor: Colors.cyan,
                                      backgroundImage: const AssetImage('assets/ro.jpg'),
                                      child: Stack(
                                        children: const [
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.green,
                                                child: Text('15%',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15,),
                                    const Text('Jm Technology',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold), ),
                                    const SizedBox(height: 15,),
                                    const Text('Service -Ro System',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),),

                                    const SizedBox(width: 1,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('Validity -',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),),
                                        Text(
                                          DateFormat('dd/MM/yyyy').
                                          format(DateTime.now(),),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 180,),
*/



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

class MyBlinkingButton extends StatefulWidget {
  const MyBlinkingButton({Key? key}) : super(key: key);

  @override
  _MyBlinkingButtonState createState() => _MyBlinkingButtonState();
}

class _MyBlinkingButtonState extends State<MyBlinkingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: const Center(
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/profile.jpg'),
          radius: 30,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class MyBlinkingButton1 extends StatefulWidget {
  const MyBlinkingButton1({Key? key}) : super(key: key);

  @override
  _MyBlinkingButton1State createState() => _MyBlinkingButton1State();
}

class _MyBlinkingButton1State extends State<MyBlinkingButton1>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: const Center(
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/pro1.jpg'),
          radius: 30,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class MyBlinkingButton2 extends StatefulWidget {
  const MyBlinkingButton2({Key? key}) : super(key: key);

  @override
  _MyBlinkingButton2State createState() => _MyBlinkingButton2State();
}

class _MyBlinkingButton2State extends State<MyBlinkingButton2>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: const Center(
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/pro2.jpg'),
          radius: 30,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class NavDrawer extends StatefulWidget {

  String userType;
  String userId;

   NavDrawer({Key? key,

     required this.userType,
     required this.userId,

   }) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            //home
            ListTile(
              tileColor: Colors.green[800],
              leading: IconButton(
                icon: const Icon(Icons.house,color: Colors.white,size: 30.0,),
                onPressed: (){
                  Navigator.of(context).pop();
                }, ),
              title: const Text('Home',
                style: TextStyle(fontSize: 20.0,color: Colors.white),),
              onTap: () => {
                /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const Profile()),
                )*/
              },
            ),
            //Profile
            ListTile(
              leading: const Icon(Icons.account_circle_sharp,color: Colors.green,),
              title: Text('Profile',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>   GuestProfile(

                     // userType:  widget.userType,
                     userID: widget.userId,
                  )),
                ),

              },
            ),

            //GiB members
            ListTile(
              leading: const Icon(Icons.supervisor_account,color: Colors.green,),
              title: Text('Business',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //            Navigator.push(
                //          context,
                //        MaterialPageRoute(builder: (context) =>  const GibMembers()),
                //     )
              },
            ),
            const Divider(color: Colors.grey,),
            ListTile(
              leading: const Icon(Icons.add_circle,color: Colors.red,),
              title: Text('Doctors',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //     Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) =>  const GibDoctors()),
                //   )
              },
            ),
            ListTile(
              leading: const Icon(Icons.bloodtype,color: Colors.red,),
              title: Text('Blood Group',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //       Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) =>  const BloodGroup()),
                //   )
              },
            ),
            const Divider(color: Colors.grey,),
            ListTile(
              leading: const Icon(Icons.info,color: Colors.green,),
              title: Text('About GiB',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //          Navigator.push(
                //       context,
                //     MaterialPageRoute(builder: (context) =>  const AboutGib()),
                //    )
              },
            ),
            ListTile(
              leading: const Icon(Icons.fingerprint,color: Colors.green,),
              title: Text('Change M-Pin',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                    Navigator.push(
                  context,
                   MaterialPageRoute(builder: (context) =>   Change(userType: widget.userType, userID: widget.userId)),
                  )
              },
            ),
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  // Clear the authentication status when logging out
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isLoggedIn', false);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
            ),
          ],
        )
    );
  }

  signout(){
    //FirebaseAuth.instance.signOut();
  }
}


class BlinkWidget extends StatefulWidget {
  final List<Widget> children;
  final int interval;

  const BlinkWidget({required this.children, this.interval = 500, required Key key}) : super(key: key);

  @override
  _BlinkWidgetState createState() => _BlinkWidgetState();
}

class _BlinkWidgetState extends State<BlinkWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentWidget = 0;

  @override
  initState() {
    super.initState();

    _controller = AnimationController(
        duration: Duration(milliseconds: widget.interval),
        vsync: this
    );

    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        setState(() {
          if(++_currentWidget == widget.children.length) {
            _currentWidget = 0;
          }
        });

        _controller.forward(from: 0.0);
      }
    });

    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.children[_currentWidget],
    );
  }
}




