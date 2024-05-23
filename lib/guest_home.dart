import 'dart:convert';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gipapp/wave.dart';
import 'package:http/http.dart' as http;
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
      GuestHomePage(
        userId: widget.userId,
        userType: widget.userType,
      ),

      BloodGroup(
        userId: widget.userId,
        userType: widget.userType!,
      ),
      GuestProfile(
        userID: widget.userId,
        userType: widget.userType,
      ),
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
            icon: Icon(
              Icons.home,
              color: Colors.black45,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.medical_services,
              color: Colors.black45,
            ),
            label: 'Doctor',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bloodtype,
              color: Colors.black45,
            ),
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
        type:
            BottomNavigationBarType.fixed, // Set type to fixed for text labels
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

class GuestHomePage extends StatefulWidget {
  final String? userType;
  final String? userId;

  GuestHomePage({
    Key? key,
    required this.userId,
    required this.userType,
  }) : super(key: key);

  @override
  State<GuestHomePage> createState() => _GuestHomePageState();
}

class _GuestHomePageState extends State<GuestHomePage> {
  Uint8List? _imageBytes;
  List<Map<String, dynamic>> userdata = [];
  String imageUrl = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> fetchData(String? userId) async {
    try {
      final url = Uri.parse(
          'http://localhost/GIB/lib/GIBAPI/registration.php?table=registration&id=$userId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>) {
          setState(() {
            userdata = responseData.cast<Map<String, dynamic>>();
            if (userdata.isNotEmpty) {
              setState(() {
                imageUrl =
                    'http://localhost/GIB/lib/GIBAPI/${userdata[0]["profile_image"]}';

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
  List<Map<String, dynamic>> data = [];
  Future<void> getData() async {
    print('Attempting to make HTTP request...');
    try {
      final url = Uri.parse(
          'http://localhost/GIB/lib/GIBAPI/offers.php?table=UnblockOffers');
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
          print('Widget User ID: ${widget.userId}');
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
          data = filteredData.cast<Map<String, dynamic>>();
        });
        print('Data: $data');
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
      print('imageUrl: $imageUrl');
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
  void initState() {
    super.initState();
    fetchData(widget.userId);
    getData();
  }

  //  final CalendarController _calendarController =  CalendarController();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    fetchData(widget.userId);

    return Scaffold(
      key: _scaffoldKey,
      drawer: SafeArea(
        child: NavDrawer(
          userType: widget.userType.toString(),
          userId: widget.userId.toString(),
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          await AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            title: 'Exit',
            desc: 'Do you want to Exit?',
            width: 400,
            btnOk: ElevatedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.white),
              ),
            ),
            btnCancel: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: const Text(
                'No',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ).show();
          // Do not return any value
        },
        child: Center(
          child: Container(
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              children: [
                Column(
                  children: [
                    ClipPath(
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
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
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
                    SizedBox(height: 80),
                    Column(
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
                            )
                          ],
                        ),
                        SizedBox(height: 30),
                        // Wrap Column in SingleChildScrollView
                        SingleChildScrollView(
                          child: Column(
                            children: List.generate(data.length, (i) {
                              String imageUrl =
                                  'http://localhost/GIB/lib/GIBAPI/${data[i]["offer_image"]}';
                              String dateString = data[i]['validity'];
                              DateTime dateTime =
                                  DateFormat('yyyy-MM-dd').parse(dateString);
                              return Center(
                                child: Card(
                                  child: Column(
                                    children: [
                                      // MAIN ROW STARTS
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // CIRCLEAVATAR STARTS
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundColor: Colors.cyan,
                                            backgroundImage:
                                                NetworkImage(imageUrl),
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor:
                                                        Colors.green[900],
                                                    child: Text(
                                                      '${data[i]['discount']}%',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // END CIRCLEAVATAR
                                          Column(
                                            children: [
                                              // START TEXTS
                                              Text(
                                                '${data[i]['company_name']}',
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                '${data[i]['offer_type']} - ${data[i]['name']}',
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(DateFormat('dd-MM-yyyy')
                                                  .format(dateTime)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                                  userdata.isNotEmpty
                                      ? userdata[0]["first_name"]
                                      : "",
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
                                      'Guest',
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
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 50);
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
    return Drawer(
        child: ListView(
      children: [
        //home
        ListTile(
          tileColor: Colors.green[800],
          leading: IconButton(
            icon: const Icon(
              Icons.house,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Home',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          onTap: () => {
            /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const Profile()),
                )*/
          },
        ),
        //Profile
        ListTile(
          leading: const Icon(
            Icons.account_circle_sharp,
            color: Colors.green,
          ),
          title: Text('Profile', style: Theme.of(context).textTheme.bodyMedium),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GuestProfile(
                        // userType:  widget.userType,
                        userID: widget.userId,
                        userType: widget.userType,
                      )),
            ),
          },
        ),

        //GiB members
        ListTile(
          leading: const Icon(
            Icons.supervisor_account,
            color: Colors.green,
          ),
          title:
              Text('Business', style: Theme.of(context).textTheme.bodyMedium),
          // onTap: () => {
          //              Navigator.push(
          //            context,
          //          MaterialPageRoute(builder: (context) =>  const bootomnav()),
          //       )
          // },
        ),
        const Divider(
          color: Colors.grey,
        ),
        ListTile(
          leading: const Icon(
            Icons.add_circle,
            color: Colors.red,
          ),
          title: Text('Doctors', style: Theme.of(context).textTheme.bodyMedium),
          onTap: () => {
            //     Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) =>  const GibDoctors()),
            //   )
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.bloodtype,
            color: Colors.red,
          ),
          title: Text('Blood Group',
              style: Theme.of(context).textTheme.bodyMedium),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BloodGroup(
                        userType: widget.userType,
                        userId: widget.userId,
                      )),
            )
          },
        ),
        const Divider(
          color: Colors.grey,
        ),
        ListTile(
          leading: const Icon(
            Icons.info,
            color: Colors.green,
          ),
          title:
              Text('About GiB', style: Theme.of(context).textTheme.bodyMedium),
          onTap: () => {
            //          Navigator.push(
            //       context,
            //     MaterialPageRoute(builder: (context) =>  const AboutGib()),
            //    )
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.fingerprint,
            color: Colors.green,
          ),
          title: Text('Change M-Pin',
              style: Theme.of(context).textTheme.bodyMedium),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Change(userType: widget.userType, userID: widget.userId)),
            )
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.logout,
            color: Colors.green,
          ),
          title: Text('Logout', style: Theme.of(context).textTheme.bodyMedium),
          onTap: () async {
            // Show an alert dialog to confirm logout
            bool confirmLogout = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Confirm Logout"),
                  content: Text("Are you sure you want to logout?",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black)),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(false); // Return false if "No" is selected
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text("No",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(true); // Return true if "Yes" is selected
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: Text("Yes",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white)),
                    ),
                  ],
                );
              },
            );

            if (confirmLogout == true) {
              // Clear the authentication status when logging out
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            }
          },
        ),
      ],
    ));
  }

  signout() {
    //FirebaseAuth.instance.signOut();
  }
}

class BlinkWidget extends StatefulWidget {
  final List<Widget> children;
  final int interval;

  const BlinkWidget(
      {required this.children, this.interval = 500, required Key key})
      : super(key: key);

  @override
  _BlinkWidgetState createState() => _BlinkWidgetState();
}

class _BlinkWidgetState extends State<BlinkWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentWidget = 0;

  @override
  initState() {
    super.initState();

    _controller = AnimationController(
        duration: Duration(milliseconds: widget.interval), vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          if (++_currentWidget == widget.children.length) {
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
