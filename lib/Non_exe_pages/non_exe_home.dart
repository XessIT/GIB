import 'dart:convert';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../Offer/offer.dart';
import '../about_view.dart';
import '../blood_group.dart';
import '../change_mpin.dart';
import '../duplicate.dart';
import '../gib_doctors.dart';
import '../gib_members.dart';
import '../guest_home.dart';
import '../guest_slip.dart';
import '../home.dart';
import '../login.dart';
import '../profile.dart';


class NonExecutiveHomeNav extends StatefulWidget {
  final String? userType;
  final String? userId;

  NonExecutiveHomeNav({
    Key? key,
    required this.userType,
    required this.userId,
  }) : super(key: key);

  @override
  _NonExecutiveHomeNavState createState() => _NonExecutiveHomeNavState();
}

class _NonExecutiveHomeNavState extends State<NonExecutiveHomeNav> {

  int _currentIndex = 0;

  late List<Widget> _pages;
  @override
  void initState() {
    _pages = [
      NonExecutiveHome(userID:widget.userId , userType:widget.userType,)



      // Add more pages as needed
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],



      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black45,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services, color: Colors.black45,),
            label: 'Doctor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bloodtype, color: Colors.black45,),
            label: 'Blood Group',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new, color: Colors.black45),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.black45),
            label: 'Profile',
          ),

          // Add more BottomNavigationBarItems as needed
        ],
        type: BottomNavigationBarType.fixed, // Set type to fixed for text labels
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black45,
        iconSize: 30,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        elevation: 5,
        selectedLabelStyle: TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.white),
        selectedIconTheme: IconThemeData(color: Colors.green),
      ),


    );
  }
}



class NonExecutiveHome extends StatefulWidget {

  final String? userID;
  final String? userType;
  NonExecutiveHome({Key? key,
    required this.userID,
    required this.userType,

    //   this.userType,
  }) : super(key: key);

  @override
  State<NonExecutiveHome> createState() => _NonExecutiveHomeState();
}

class _NonExecutiveHomeState extends State<NonExecutiveHome> {

  TextEditingController guestcount =TextEditingController();
  List<Map<String, dynamic>> userdata = [];
  List<Map<String, dynamic>> offersdata = [];
  String? registerStatus = "Register";
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Uint8List? _imageBytes;
  String imageUrl = "";
  String? fetchMobile ="";



  @override
  void initState() {
    fetchData(widget.userID);
    print('--------------------');
    print('getdata:$getData()');
    getData();
    getData1();
    print('--------------------');

    super.initState();
  }


  Future<void> registerDateStoreDatabase(String meetingId,String meetingType, String meetingDate, String meetingPlace) async {
    try {
      String uri = "http://localhost/GIB/lib/GIBAPI/register_meeting.php";
      var res = await http.post(Uri.parse(uri), body: jsonEncode( {
        "meeting_id": meetingId,
        "meeting_type": meetingType,
        "meeting_date": meetingDate,
        "meeting_place":meetingPlace,
        "status":registerStatus,
        "user_id":widget.userID,
        "user_type":widget.userType,
      }));

      if (res.statusCode == 200) {
        //  print("Register uri$uri");
        // print("Register Response Status: ${res.statusCode}");
        //print("Register Response Body: ${res.body}");
        var response = jsonDecode(res.body);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(userType: widget.userID, userId: widget.userType)));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration Successfully")));
      } else {
        print("Failed to upload image. Server returned status code: ${res.statusCode}");
      }
    } catch (e) {
      //  print("Error uploading image: $e");
    }
  }

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
              imageUrl = 'http://localhost/GIB/lib/GIBAPI/${userdata[0]["profile_image"]}';
              _imageBytes = base64Decode(userdata[0]['profile_image']);
            }
          });
        } else {
          print('Invalid response data format');
        }
      } else {
        //  print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  List<Map<String, dynamic>> data=[];
  String type = "Non-Executive";
  Future<void> getData() async {
    print('Attempting to make HTTP request...');
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/non_exe_meeting.php?member_type=$type');
      print('URL: $url');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> itemGroups = responseData;
        List<dynamic> filteredData = itemGroups.where((item) {
          DateTime registrationOpeningDate;
          DateTime registrationClosingDate;
          try {
            registrationOpeningDate = DateTime.parse(item['registration_opening_date']);
            registrationClosingDate = DateTime.parse(item['registration_closing_date']);
          } catch (e) {
            print('Error parsing registration dates: $e');
            return false;
          }
          print('Registration Opening Date: $registrationOpeningDate');
          print('Registration Closing Date: $registrationClosingDate');
          print('Current Date: ${DateTime.now()}');

          // Check if the registration opening date is before the current date
          bool isOpenForRegistration = registrationOpeningDate.isBefore(DateTime.now());

          // Check if the registration closing date is after the current date
          bool isRegistrationOpen = registrationClosingDate.isAfter(DateTime.now());

          print('Is Open for Registration: $isOpenForRegistration');
          print('Is Registration Open: $isRegistrationOpen');

          // Return true if the meeting is open for registration and false otherwise
          return isOpenForRegistration && isRegistrationOpen;
        }).toList();
        setState(() {
          // Cast the filtered data to the correct type and update your state
          data = filteredData.cast<Map<String, dynamic>>();
          print('Data123: $data');
          print('--------------------');
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

///Define a function to format the time string
  String _formatTimeString(String timeString) {
    // Split the time string into hour, minute, and second components
    List<String> timeComponents = timeString.split(':');

    // Extract hour and minute components
    int hour = int.parse(timeComponents[0]);
    int minute = int.parse(timeComponents[1]);

    // Format the time string
    String formattedTime = '${_twoDigits(hour)}:${_twoDigits(minute)}';

    return formattedTime;
  }
  String _twoDigits(int n) {
    if (n >= 10) {
      return "$n";
    }
    return "0$n";
  }

  /// offers fetch
  List<Map<String, dynamic>> data1=[];
  Future<void> getData1() async {
    print('Attempting to make HTTP request...');
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/offers.php?table=UnblockOffers');
      print(url);
      final response = await http.get(url);
      print("ResponseStatus: ${response.statusCode}");
      print("Response: ${response.body}");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("ResponseData: $responseData");
        final List<dynamic> itemGroups = responseData;
        setState(() {});
        // data = itemGroups.cast<Map<String, dynamic>>();
        // Filter data based on user_id and validity date
        List<dynamic> filteredData = itemGroups.where((item) {
          DateTime validityDate;
          try {
            validityDate = DateTime.parse(item['validity']);
          } catch (e) {
            print('Error parsing validity date: $e');
            return false;
          }
          print('Widget User ID: ${widget.userID}');
          print('Item User ID: ${item['user_id']}');
          print('Validity Date: $validityDate');
          print('Current Date: ${DateTime.now()}');
          bool satisfiesFilter = validityDate.isAfter(DateTime.now());
          print("Item block status: ${item['block_status']}");
          print('Satisfies Filter: $satisfiesFilter');
          return satisfiesFilter;
        }).toList();
        // Call setState() after updating data
        setState(() {
          // Cast the filtered data to the correct type
          data1 = filteredData.cast<Map<String, dynamic>>();
        });
        print('Data: $data1');
      } else {
        print('Error: ${response.statusCode}');
      }
      print('HTTP request completed. Status code: ${response.statusCode}');
    } catch (e) {
      print('Error making HTTP request: $e');
      throw e; // rethrow the error if needed
    }

  }
  Future<Uint8List?> getImageBytes(String imageUrl) async {
    try {
      print("123456789087654323456789");
      print('imageUrl: $imageUrl');
      print("123456789087654323456789");

      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print('Failed to load image. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error loading image: $e');
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SafeArea(
        child: NavDrawer(
          userID: widget.userID.toString(),
          userType: widget.userType.toString(),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          // Your existing Column
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            
                SizedBox(height: 180),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 0,
                    child: Container(
            
                      child: Text(
                        'Upcoming Meetings',
                        style: GoogleFonts.aBeeZee(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: CarouselSlider(
                    items: data.map((meeting) {
                      String meetingDate = meeting['meeting_date'];
                      String meetingPlace = meeting['place'];
                      String meetingType = meeting['meeting_type'];
                      String id = meeting['id'];
                      return Builder(
                        builder: (BuildContext context) {
                          return Container( // Wrap Card with Container
                            width: MediaQuery.of(context).size.width, // Set width to full width of the screen
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('${meeting['meeting_type']}',style:TextStyle(color: Colors.green,fontSize: 20),),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
            
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
                                        children: [
                                          Text('${meeting['meeting_date']}',style:TextStyle(color: Colors.black,fontSize: 20),),
                                          Text('${meeting['meeting_name']}',style:TextStyle(color: Colors.black,fontSize: 20),),
                                        ],
                                      ),
                                    ),
            
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${_formatTimeString(meeting['from_time'])} to ${_formatTimeString(meeting['to_time'])}',
                                            style: TextStyle(color: Colors.black, fontSize: 20),
                                          ),
                                          SizedBox(width: 10), // Space between icon and text
                                          Icon(Icons.location_on,color: Colors.green,), // Location icon
                                          SizedBox(width: 2), // Space between icon and text
                                          Text(meeting['place'],style:TextStyle(color: Colors.black,fontSize: 20)),
                                          SizedBox(width: 20,),
                                          IconButton(
                                              onPressed: () {
                                                print('press icon');
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
                                                                                    Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                            builder: (
                                                                                                context) =>
                                                                                                VisitorsSlip
                                                                                                  (
                                                                                                    userId:widget.userID,
                                                                                                    meetingId:id,
                                                                                                    guestcount: guestcount.text.trim(),
                                                                                                    userType:widget.userType,
                                                                                                    meeting_date:meetingDate,
                                                                                                    user_mobile:fetchMobile.toString()
                                                                                                )));
                                                                                    print("UserID:-${widget.userID}${widget.userType}");
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
                                    ),
            
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 170.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 1,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 0,
                    child: Container(
            
                      child: Text(
                        'Offer',
                        style: GoogleFonts.aBeeZee(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6, // Adjust the height as needed
                  child: ListView.builder(
                      itemCount: data1.length,
                      itemBuilder: (context, i) {
                        String imageUrl = 'http://localhost/GIB/lib/GIBAPI/${data1[i]["offer_image"]}';
                        String dateString = data1[i]['validity']; // This will print the properly encoded URL
                        DateTime dateTime = DateFormat('yyyy-MM-dd').parse(dateString);
                        return Center(
                          child: Card(
                            child: Column(
                              children: [
                                //MAIN ROW STARTS
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children:  [
                                    //CIRCLEAVATAR STARTS
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.cyan,
                                      backgroundImage: NetworkImage(imageUrl),
                                      //IMAGE STARTS CIRCLEAVATAR
                                      //  Image.network('${data[i]['offer_image']}').image,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            //STARTS CIRCLE AVATAR OFFER
                                            child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.green[900],
                                                child: Text('${data1[i]['discount']}%',
                                                    style: Theme.of(context).textTheme.titleLarge)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //END CIRCLEAVATAR
            
                                    Column(
                                      children: [
                                        //START TEXTS
                                        Text('${data1[i]['company_name']}',
                                          //Text style starts
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontSize: 15),),
                                        const SizedBox(height: 10,),
                                        //start texts
                                        Text('${data1[i]['offer_type']} - ${data1[i]['name']}',
                                          //Text style starts
                                          style: const TextStyle(fontSize: 11,
                                              fontWeight: FontWeight.bold
                                          ),),
                                        //Text starts
                                        Text(DateFormat('dd-MM-yyyy').format(dateTime)),
                                      ],
                                    ),
                                    //IconButton starts
            
                                    //IconButton starts
            
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                ),
            
            
            
              ],
            ),
          ),
          /// meeting date. meeting type , place , time,  Additional Stack
          Positioned(
            top: 0,
            left: 0,
            right:0,
            child:ClipPath(
            clipper: CurveClipper(),
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'GIB',
                      style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () {
                        print('press nav drawer');
                        _scaffoldKey.currentState!.openDrawer();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ), ),
          Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: Card(
              child: SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            userdata.isNotEmpty ? userdata[0]["first_name"] : "",
                            style: GoogleFonts.aBeeZee(
                              fontSize: 20,
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Non-Executive Member',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 10,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}





class NavDrawer extends StatefulWidget {
  String userType;
  final String userID;
  NavDrawer({Key? key,
    required this.userType,
    required this.userID
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
            ListTile(
              tileColor: Colors.green[800],
              leading: IconButton(
                icon: const Icon(Icons.house,color: Colors.white,size: 30.0,),
                onPressed: (){
               //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScrollApp(),));
                }, ),
              title: const Text('Home',
                style: TextStyle(fontSize: 20.0,color: Colors.white),),
              onTap: () => {
                /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const Profile()),
                )*/
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /*IconButton(
                    icon: const Icon(Icons.snowshoeing,color: Colors.white,),
                    onPressed: () {
                      //   Navigator.push(
                      //    context,
                      //    MaterialPageRoute(builder: (context) =>  const MyActivity()),
                      //   );
                    },
                  ),*/
                  IconButton(
                    icon: const Icon(Icons.notifications,color: Colors.white,),
                    onPressed: () {
                      //Navigator.push(
                      //  context,
                      //   MaterialPageRoute(builder: (context) =>  const NotificationPage()),
                      // );
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

                    userType:  widget.userType,

                    userID:widget.userID,

                  )),
                ),
                // Navigator.pop(context),
              },
            ),
            ListTile(
              leading: const Icon(Icons.oil_barrel,color: Colors.green,),
              title: Text('Attendance',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //   Navigator.push(
                //   context,
                // MaterialPageRoute(builder: (context) =>  const Attendance()),
                //)
              },
            ),
            ListTile(
              leading: const Icon(Icons.qr_code,color: Colors.green,),
              title: Text('Attendance Scanner',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //      Navigator.push(
                //       context,
                //  MaterialPageRoute(builder: (context) =>  const AttendanceScanner()),
                // )
              },
            ),
            const Divider(color: Colors.grey,),
            ListTile(
              leading: const Icon(Icons.photo,color: Colors.green,),
              title: Text('GiB Gallery',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //    Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) =>  const GibGallery()),
                //     )
              },
            ),
            ListTile(
              leading: const Icon(Icons.emoji_events,color: Colors.green,),
              title: Text('GiB Achievements',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //    Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) =>  const GibAchievements()),
                //   )
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
                    userId: widget.userID,
                  )),
                )
              },
            ),
            /// gib members
            ListTile(
              leading: const Icon(Icons.local_offer,color: Colors.green,),
              title: Text('Offers',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  OffersPage(
                    userId: widget.userID, userType: widget.userType,
                  )),
                )
              },
            ),  /// offers
            const Divider(color: Colors.grey,),
            ListTile(
              leading: const Icon(Icons.add_circle,color: Colors.red,),
              title: Text('GiB Doctors',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>   GibDoctors()),
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
                  MaterialPageRoute(builder: (context) => BloodGroup(userId:widget.userID,userType:widget.userType)),
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
                    MaterialPageRoute(builder: (context) =>  AboutTab(userId:widget.userID,userType:widget.userType))
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
                  MaterialPageRoute(builder: (context) =>   ChangeMPin(userID:widget.userID,userType:widget.userType)),
                )
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: Text(
                'Log Out',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              onTap: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.noHeader,
                  width: 350,
                  body: StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                          padding: EdgeInsets.all(20),
                          child: Text("Are you sure want to Log out"));
                    },
                  ),
                  btnOk: ElevatedButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', false);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                      // Handle OK button press
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    child: Text(
                      'Yes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  btnCancel: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    child: Text(
                      'No',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ).show();
                // Update UI based on item 2
              },
            ),
          ],
        )
    );
  }
}





