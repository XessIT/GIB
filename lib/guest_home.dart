import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gipapp/wave.dart';
import 'package:http/http.dart'as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blood_group.dart';
import 'change_mpin.dart';
import 'guest_profile.dart';
import 'login.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';




class GuestHome extends StatefulWidget {
  final String? userType;
  final String? userId;

  GuestHome({
    Key? key,
    required this.userType,
    required this.userId,
  }) : super(key: key);

  @override
  _GuestHomeState createState() => _GuestHomeState();
}

class _GuestHomeState extends State<GuestHome> {

  int _currentIndex = 0;

  late List<Widget> _pages;
  @override
  void initState() {
    _pages = [
      GuestHomePage(userId: widget.userId, userType: widget.userType,),

      BloodGroup(userId: widget.userId, userType: widget.userType!,),
      GuestProfile(userID: widget.userId),
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
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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
        elevation: 5,
        selectedLabelStyle: TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.white),
        selectedIconTheme: IconThemeData(color: Colors.green),
      ),

      /*
      * bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Colors.white,
  items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home_outlined,
        color: Colors.black45,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.wallet_outlined,
        color: Colors.black45,
      ),
      label: 'Wallet',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.request_page_outlined,
        color: Colors.black45,
      ),
      label: 'Budget',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.flight_takeoff_outlined,
        color: Colors.black45,
      ),
      label: 'Trip',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.currency_rupee_outlined,
        color: Colors.black45,
      ),
      label: 'Daily',
    ),
  ],
  type: BottomNavigationBarType.fixed, // Set type to fixed for text labels
  currentIndex: _selectedIndex,
  selectedItemColor: Colors.deepPurple,
  unselectedItemColor: Colors.black45,
  iconSize: 30,
  onTap: _onItemTapped,
  elevation: 5,
  selectedLabelStyle: TextStyle(color: Colors.white),
  unselectedLabelStyle: TextStyle(color: Colors.white),
  selectedIconTheme: IconThemeData(color: Colors.deepPurple), // Set selected icon color
),
int _selectedIndex = 0;
void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
    switch (_selectedIndex) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage2(userId:widget.userId,)));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WalletReport(uid: widget.userId)));
       break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MonthlyReportPage(uid: widget.userId)));// Replace '/nextpage' with the route of your next page

        // Index of the "Records" item
        break;
      case 3: // Index of the "Settings" item
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TripReportDashboard(uid: widget.userId)));
        break;
      case 4: // Index of the "Settings" item
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DailyReportPage(uid: widget.userId)));
        break;
      default:
      // Handle navigation for other items if needed
        break;
    }
  });
}
      *
      * */
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
  String imageUrl = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



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
                imageUrl = 'http://localhost/GIB/lib/GIBAPI/${userdata[0]["profile_image"]}';

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


        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>) {
          setState(() {
            offersdata = responseData.cast<Map<String, dynamic>>();

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
   // offersfetchData();
    fetchData(widget.userId);

    return Scaffold(
      key: _scaffoldKey,



      drawer:  SafeArea(
          child: NavDrawer(

            userType:widget.userType.toString(),
            userId:widget.userId.toString(),
          )
      ),
      body: Center(
        child: Container(

          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: [

              Positioned(
                top: 0,
                left: 0,
                child: ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    //width: 400,
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text('GIB',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: IconButton(
                            icon: Icon(Icons.menu,color: Colors.white,),
                            onPressed: () {
                              print('press nav drawer');
                              _scaffoldKey.currentState!.openDrawer();
                            },
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 80,
                left: 20,
                right: 20,
                child: Card(
                  child: SizedBox(
                     // width: w,
                      height: 80,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 300,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle, // This makes the container circular
                                // Optionally, you can add other decorations like border or background color here
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover, // You might want to use cover to fill the circle completely
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
              ),
              Positioned(
                top: 170,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Card(
                          elevation: 0,
                          child: Container(
                            padding: EdgeInsets.all(1),
                            child: Text(
                              'Offers+',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )                      ],
                    ),

                    SizedBox(height: 30),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6, // Adjust the height as needed
                      child: ListView.builder(
                        itemCount: 10, // Number of cards you want to display
                        itemBuilder: (context, index) {
                          return Card(
                            child: SizedBox(
                              height: 100,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 100, // Adjust the height as needed
                                      width: 100, // Adjust the width as needed
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          userdata.isNotEmpty ? userdata[0]["first_name"] : "",
                                          style: GoogleFonts.aBeeZee(
                                            fontSize: 20,
                                            color: Colors.indigo,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Guest',
                                          style: GoogleFonts.aBeeZee(
                                            fontSize: 10,
                                            color: Colors.indigo,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(0, size.height, 50, size.height);
    path.lineTo(size.width - 50, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
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
                           Navigator.push(
                         context,
                       MaterialPageRoute(builder: (context) =>  const bootomnav()),
                    )
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
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>   BloodGroup(userType: widget.userType, userId: widget.userId,)),
                  )
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




