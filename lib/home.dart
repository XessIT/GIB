import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gipapp/about_view.dart';
import 'package:gipapp/profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Offer/offer.dart';
import 'about.dart';
import 'add_member.dart';
import 'attendance.dart';
import 'attendance_scanner.dart';
import 'blood_group.dart';
import 'business.dart';
import 'change_mpin.dart';
import 'gib_achievements.dart';
import 'gib_doctors.dart';
import 'gib_gallery.dart';
import 'gib_members.dart';
import 'guest_slip.dart';
import 'home1.dart';
import 'login.dart';
import 'meeting.dart';
import 'my_activity.dart';
import 'my_gallery.dart';
import 'notification.dart';
import 'dart:io';
import 'package:http/http.dart'as http;

class Homepage extends StatelessWidget {

  final String? userType;
  final String? userID;


  Homepage({
    Key? key,

    required this. userType,
    required this. userID,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Home(

        userType: userType,
        userId :userID,
      ),
    );
  }
}

class Home extends StatefulWidget {

  final String? userType;

  final String? userId;

  Home({
    Key? key,

    required this. userType,
    required this. userId,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {
  TextEditingController wishing = TextEditingController();
  File? pickedimage;
  bool showLocalImage = false;

  String? name = "";
  String? image = "";
  String? membertype = "";
  String? teamName = "";
  String? mobile ="";
  String? uid ="";
  String? fname ="";
  String? memberskoottam ="";
  String? businesstype ="";
  String? memberid="";
  bool isRegistered =false;
  String? fetchName="";
  String? fetchLastName="";
  String? fetchMemberType="";
  String? fetchMemberId="";
  String? fetchTeamName ="";
  String? fetchMobile ="";

  @override
  void initState() {
   // print("UserId: ${widget.userId}");
    // TODO: implement initState
    super.initState();
    //notificationsServices.initialiseNotifications();
  }
  final bdayDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  TextEditingController guestcount =TextEditingController();
///meeting data fetch
  List<Map<String,dynamic>>dynamicdata=[];
  Future<void> fetchMeetingData() async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/meeting.php');
      final response = await http.get(url);
    //  print("Meeting url:$url");

      if (response.statusCode == 200) {
        // print("Meeting status code:${response.statusCode}");
        // print("Meeting body:${response.body}");

        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>) {
          setState(() {
            dynamicdata = responseData.cast<Map<String, dynamic>>();
            if (dynamicdata.isNotEmpty) {
              setState(() {
              //  print("dynamic data :-- $dynamicdata");

              });
            }
          });
        } else {
          // Handle invalid response data (not a List)
       //   print('Invalid response Meeting data format');
        }
      } else {
        // Handle non-200 status code
      //  print('Meeting Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other errors
    //  print('Meeting Error: $error');
    }
  }

///registration table code fetch
  List<Map<String,dynamic>>userdata=[];
  Future<void> fetchData(String? userId) async {
    try {
      //http://localhost/GIB/lib/GIBAPI/user.php?table=registration&id=$userId
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/registration.php?table=registration&id=$userId');
      final response = await http.get(url);
     //  print("fetch url:$url");

      if (response.statusCode == 200) {
        // print("fetch status code:${response.statusCode}");
        // print("fetch body:${response.body}");

        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>) {
          setState(() {
            userdata = responseData.cast<Map<String, dynamic>>();
            if (userdata.isNotEmpty) {
              setState(() {
                fetchName = userdata[0]["first_name"]??"";
                fetchLastName= userdata[0]['last_name']??"";
                fetchMemberId=userdata[0]["member_id"]??"";
                fetchMemberType = userdata[0]["member_type"]??"";
               fetchTeamName = userdata[0]["team_name"]??"";
               fetchMobile = userdata[0]["mobile"]??"";

              });
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

///register Meeting data store code
  String? registerStatus="Register";
  Future<void> registerDateStoreDatabase(String meetingId,String meetingType, String meetingDate, String meetingPlace) async {
    try {
      String uri = "http://localhost/GIB/lib/GIBAPI/register_meeting.php";
      var res = await http.post(Uri.parse(uri), body: jsonEncode( {
        "meeting_id": meetingId,
        "meeting_type": meetingType,
        "meeting_date": meetingDate,
        "meeting_place":meetingPlace,
        "status":registerStatus,
        "user_id":widget.userId,
        "user_type":widget.userType,
      }));

      if (res.statusCode == 200) {
      //  print("Register uri$uri");
       // print("Register Response Status: ${res.statusCode}");
        //print("Register Response Body: ${res.body}");
        var response = jsonDecode(res.body);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(userType: widget.userId, userId: widget.userType)));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration Successfully")));
      } else {
        print("Failed to upload image. Server returned status code: ${res.statusCode}");
      }
    } catch (e) {
    //  print("Error uploading image: $e");
    }
  }

///register_meeting data fetch code
  List<Map<String,dynamic>>registerFetchdata=[];
  Future<void> registerFetch(String meetingId) async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/register_meeting.php?user_id=${widget.userId}&meeting_id=$meetingId');
      final response = await http.get(url);
     // print("r url:$url");

      if (response.statusCode == 200) {
        // print("r status code:${response.statusCode}");
        // print("r body:${response.body}");

        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>) {
          setState(() {
            registerFetchdata = responseData.cast<Map<String, dynamic>>();
            if (registerFetchdata.isNotEmpty) {
              setState(() {
                registerStatus = registerFetchdata[0]["status"];

              });
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
     // print('Error: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    fetchMeetingData();
    fetchData(widget.userId.toString());
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer:  SafeArea(
          child: NavDrawer(userType: widget.userType.toString(), userId: widget.userId,
          )),

      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: Colors.green.shade900,
        child: Row(
          children: [
            SizedBox(width:20,height:20,child: IconButton(icon: const Icon(Icons.search,color: Colors.white,), onPressed: () {})),
            const Spacer(),
            SizedBox(width:20,height:20,child: IconButton(icon: const Icon(Icons.people_alt_outlined,color: Colors.white,), onPressed: () {})),

            const Spacer(),
            SizedBox(width:20,height:20,child: IconButton(icon: const Icon(Icons.home_outlined,color: Colors.white,), onPressed: () {})),

            const Spacer(),
            SizedBox(width:20,height:20,child: IconButton(icon: const Icon(Icons.settings_outlined,color: Colors.white,), onPressed: () {})),
            const Spacer(),
            SizedBox(width:20,height:20,child: IconButton(icon: const Icon(Icons.bloodtype_outlined,color: Colors.white,), onPressed: () {})),
          ],
        ),
      ),
      appBar: AppBar(centerTitle: true,
        actions: [
          // IconButton(onPressed: (){
          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>PageCheck()));
          //
          // }, icon: const Icon(Icons.notifications_active_outlined))
        ],
        iconTheme:  const IconThemeData(
          color: Colors.white, // Set the color for the drawer icon
        ),
        title: Text("GIB",style: Theme.of(context).textTheme.bodySmall),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(

            child: Column(
              children: [
                SafeArea(
                  child: SizedBox(
                    width: w,
                    height: 100,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left:8.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/pro1.jpg"),
                            radius: 35,
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left:8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "",
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 10,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),Text(
                                fetchName!,
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 10,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(fetchMemberId!,
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 10,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  //  Text('${widget.userType}',
                                  Text(fetchMemberType!,
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 10,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  Text("Vaagai",
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 10,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  Text( DateFormat()
                                  // displaying formatted date
                                      .format(DateTime.now()),
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 10,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                    ),),
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
                      const SizedBox(height: 20,width: 20,),

                      Row(
                        children: [
                          const SizedBox(width: 15,),

                          Align(
                            alignment: Alignment.topLeft,
                            child: Text('Birthday/Anniversary',style: Theme.of(context).textTheme.titleLarge,),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const SizedBox(width: 20,),

                          Column(
                            children: [
                              const CircleAvatar(
                                backgroundImage:AssetImage("assets/pro1.jpg"),
                                radius: 25,
                              ),
                              Text("Baby", style: Theme.of(context).textTheme.titleSmall,)
                            ],
                          ),
                          const SizedBox(width: 5,),
                          Column(
                            children: [
                              const CircleAvatar(
                                backgroundImage: AssetImage("assets/pro2.jpg"),
                                radius: 25,
                              ),
                              Text("Bhuvana", style: Theme.of(context).textTheme.titleSmall),
                            ],
                          ),
                          SizedBox(width: 7,),
                          Column(
                            children: [
                              const CircleAvatar(
                                backgroundImage: AssetImage("assets/profile.png"),
                                radius: 25,
                              ),
                              Text("Arjun", style: Theme.of(context).textTheme.titleSmall,)
                            ],
                          ),const SizedBox(width: 7,),


                          Column(
                            children: [
                              const CircleAvatar(
                                backgroundImage:AssetImage("assets/pro1.jpg"),
                                radius: 25,
                              ),
                              Text("Nasreen",style: Theme.of(context).textTheme.titleSmall,)
                            ],
                          ),                          const SizedBox(width: 7,),

                          Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage("assets/profile.jpg"),
                                radius: 25,
                              ),
                              Text("Sathish",style: Theme.of(context).textTheme.titleSmall,)
                            ],
                          ),                          SizedBox(width: 7,),

                          SizedBox(width: 5,),
                          Text("...",style: Theme.of(context).textTheme.titleSmall,)

                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        //  height: 300,
                        width: w,
                        color: Colors.green.shade900,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('Upcoming Meeting',style: Theme.of(context).textTheme.titleLarge,),
                              ),
                            ),
                            Container(
                              width: w - 30,
                              height: 120,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.white,
                                    Colors.blue.shade100
                                  ],
                                ),
                                border: Border.all(color: Colors.green, width: 2),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: CarouselSlider(
                                items: dynamicdata.map((meeting) {
                                  // Extract meeting details from the map
                                  String meetingDate = meeting['meeting_date'];
                                  String meetingPlace = meeting['place'];
                                  String meetingType = meeting['meeting_type'];
                                  String id = meeting['id'];
                                  registerFetch(id);
                                  return Column(
                                    children: [
                                      const SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('$meetingDate\n$meetingPlace'),
                                          Text(meetingType),
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (ctx) =>
                                                    // Dialog box for register meeting and add guest
                                                    AlertDialog(
                                                      backgroundColor: Colors.grey[800],
                                                      title: const Text(
                                                          'Meeting',
                                                          style: TextStyle(
                                                              color: Colors.white)),
                                                      content: const Text(
                                                          "Do You Want to Register the Meeting?",
                                                          style: TextStyle(
                                                              color: Colors.white)),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              GlobalKey<FormState> tempKey =GlobalKey<FormState>();

                                                              //store purpose..
                                                              registerDateStoreDatabase(id, meetingType, meetingDate, meetingPlace);
                                                              showDialog(
                                                                  context: context,
                                                                  builder: (ctx) =>
                                                                      Form(
                                                                        key:tempKey,
                                                                        child: AlertDialog(
                                                                          backgroundColor: Colors.grey[800],
                                                                          title: const Text('Do you wish to add Guest?',
                                                                              style: TextStyle(
                                                                                  color: Colors.white)),
                                                                          content: TextFormField(
                                                                            controller: guestcount,
                                                                            validator: (value){
                                                                              if(value!.isEmpty){
                                                                                return "* Enter a Guest Count";
                                                                              }
                                                                              return null;
                                                                            },
                                                                            decoration: const InputDecoration(
                                                                              labelText: "Guest Count",
                                                                              labelStyle: TextStyle(color: Colors.white),
                                                                              hintText: "Ex:5",
                                                                            ),
                                                                          ),

                                                                          actions: [
                                                                            TextButton(
                                                                                onPressed: () {
                                                                                  if(tempKey.currentState!.validate()) {
                                                                                    Navigator
                                                                                        .push(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                            builder: (
                                                                                                context) =>
                                                                                                VisitorsSlip(
                                                                                                  userId:widget.userId,
                                                                                                  meetingId:id,
                                                                                                  guestcount: guestcount.text.trim(),
                                                                                                  userType:widget.userType,
                                                                                                  meeting_date:meetingDate,
                                                                                                  user_mobile:fetchMobile.toString()

                                                                                                )));
                                                                                    print("UserID:-${widget.userId}${widget.userType}");
                                                                                  } },
                                                                                child: const Text('Yes')),
                                                                            TextButton(
                                                                                onPressed: () {
                                                                                },
                                                                                child: const Text('No'))
                                                                          ],
                                                                        ),
                                                                      )
                                                              );
                                                            },
                                                            child: const Text('OK')),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            },
                                                            child: const Text('Cancel'))
                                                      ],
                                                    )
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.person_add_alt_1_rounded,
                                                color: Colors.green,
                                              ))
                                        ],
                                      ),
                                    ],
                                  );
                                }).toList(),
                                options: CarouselOptions(
                                  height: 120.0,
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  aspectRatio: 16 / 9,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                  viewportFraction: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Offers',style: Theme.of(context).textTheme.titleLarge,),
                        ),
                      ),
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
                                      Text("Zappy\nPhotography",style: Theme.of(context).textTheme.titleSmall,),

                                    ],
                                  )
                                ],
                              ),
                              SizedBox(width: 10,),
                              //Upcoming Meeting Card

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
                                      Text("Zappy\nPhotography",style: Theme.of(context).textTheme.titleSmall,),

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
                                      Text("Zappy\nPhotography",style: Theme.of(context).textTheme.titleSmall,),

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
                                      Text("Zappy\nPhotography",style: Theme.of(context).textTheme.titleSmall,),

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
                                      Text("Zappy\nPhotography",style: Theme.of(context).textTheme.titleSmall,),

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
                                      Text("Zappy\nPhotography",style: Theme.of(context).textTheme.titleSmall,),

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
                                      Text("Zappy\nPhotography",style: Theme.of(context).textTheme.titleSmall,),

                                    ],
                                  )
                                ],
                              ),
                              SizedBox(width: 10,),


                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Today Transactions',style: Theme.of(context).textTheme.titleLarge,),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 175,
                                height: 60,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.white,
                                      Colors.blue.shade100
                                    ],
                                  ),

                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Center(child: Text("Business : 12 ",style: Theme.of(context).textTheme.bodyMedium,)),

                              ),

                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 175,
                                height: 60,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.white,
                                      Colors.blue.shade100
                                    ],
                                  ),

                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Center(child: Text("G2G : 7",style: Theme.of(context).textTheme.bodyMedium,)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          Column(
                            children: [
                              Container(
                                width: 175,
                                height: 60,

                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.white,
                                      Colors.blue.shade100
                                    ],
                                  ),

                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Center(child: Text("Guest : 10 ",style: Theme.of(context).textTheme.bodyMedium,)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 175,
                                height: 60,

                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.white,
                                      Colors.blue.shade100
                                    ],
                                  ),

                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child:Center(child: Text("Honoring : 20 ",style: Theme.of(context).textTheme.bodyMedium,)),

                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 100,),



                    ],
                  ),
                ),
              ],
            ),
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
          radius: 20,
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
    return Container(
      child:   CircleAvatar(
        backgroundImage: Image.network('').image,
        radius: 20,
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

  final String userType;
  final String? userId;

  NavDrawer({
    Key? key,

    required this.userType,
    required this.userId,

  }) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    //print('lastName in NavDrawer: ${widget.lastName}');

    return Drawer(
        child: ListView(
          children: [
            ListTile(
              tileColor: Colors.green[800],
              leading: IconButton(
                icon: const Icon(Icons.house,color: Colors.white,size: 30.0,),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>   Home(userType: '', userId: '',)));
                }, ),
              title: const Text('Home',
                style: TextStyle(fontSize: 20.0,color: Colors.white),),
              onTap: () => {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) =>   RowCounter()),
                // )
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.snowshoeing,color: Colors.white,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  const MyActivity()),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications,color: Colors.white,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  const NotificationPage()),
                      );
                    },
                  ),
                ],
              ),

            ),
            ListTile(
              leading: const Icon(Icons.account_circle_sharp,color: Colors.green,),
              title: Text('Profile',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>   Profile(
                    userType: widget.userType,
                    userID: widget.userId,
                  )),
                ),
              },
            ),

            ListTile(
              leading: const Icon(Icons.oil_barrel,color: Colors.green,),
              title: Text('Business',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const Business()),
                )
              },
            ),

            const Divider(color: Colors.grey,),

            ListTile(
              leading: const Icon(Icons.account_tree,color: Colors.green,),
              title: Text('Meeting',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const MeetingUpcoming()),
                )
              },
            ),

            ListTile(
              leading: const Icon(Icons.oil_barrel,color: Colors.green,),
              title: Text('Attendance',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const Attendance()),
                )
              },
            ),

            ListTile(
              leading: const Icon(Icons.qr_code,color: Colors.green,),
              title: Text('Attendance Scanner',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>   AttendanceScanner()),
                )
              },
            ),

            const Divider(color: Colors.grey,),

            ListTile(
              leading: const Icon(Icons.photo,color: Colors.green,),
              title: Text('My Gallery',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const MyGallery()),
                )
              },
            ),

            ListTile(
              leading: const Icon(Icons.photo,color: Colors.green,),
              title: Text('GiB Gallery',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const GibGallery()),
                )
              },
            ),

            ListTile(
              leading: const Icon(Icons.emoji_events,color: Colors.green,),
              title: Text('GiB Achievements',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const GibAchievements()),
                )
              },
            ),


            const Divider(color: Colors.grey,),

            ListTile(
              leading: const Icon(Icons.supervisor_account,color: Colors.green,),
              title: Text('GiB Members',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GibMembers(
                    userType: widget.userType,
                    userId: widget.userId,
                  )),
                )
              },
            ),

            ListTile(
              leading: const Icon(Icons.person_add,color: Colors.green,),
              title: Text('Add Member',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                     MaterialPageRoute(builder: (context) =>   AddMember(userId:widget.userId,userType:widget.userType)),
               //   MaterialPageRoute(builder: (context) =>    AddMemberView(userID:widget.userId,userType:widget.userType,)),
                )
              },
            ),

            ListTile(
              leading: const Icon(Icons.local_offer,color: Colors.green,),
              title: Text('Offers',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) =>  OffersPage(
                     userId: widget.userId,
                   )),
                 )
              },
            ),

            const Divider(color: Colors.grey,),

            ListTile(
              leading: const Icon(Icons.add_circle,color: Colors.red,),
              title: Text('GiB Doctors',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const GibDoctors()),
                )
              },
            ),

            ListTile(
              leading: const Icon(Icons.bloodtype,color: Colors.red,),
              title: Text('Blood Group',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BloodGroup(userId:widget.userId,userType:widget.userType)),
                )
              },
            ),

            const Divider(color: Colors.grey,),

            ListTile(
              leading: const Icon(Icons.info,color: Colors.green,),
              title: Text('About GiB',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AboutTab(userId:widget.userId,userType:widget.userType))
                )
              },
            ),

            ListTile(
              leading: const Icon(Icons.fingerprint,color: Colors.green,),
              title: Text('Change M-Pin',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>   ChangeMPin(  userType:  widget.userType,
                    userID:widget.userId,)),
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

  signOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  const Login()),
    );  }
}



