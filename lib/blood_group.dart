import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Non_exe_pages/non_exe_home.dart';
import 'blood_group_list.dart';
import 'guest_home.dart';
import 'home.dart';
import 'home1.dart';

class BloodGroup extends StatelessWidget {
  final String? userType;
  final String? userId;
  const BloodGroup({Key? key, required this.userType, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main calling function. This function coding will appear below
      body: Blood(userType: userType.toString(), userId: userId),
    );
  }
}

class Blood extends StatefulWidget {
  final String userType;
  final String? userId;
  const Blood({Key? key, required this.userType, required this.userId})
      : super(key: key);

  @override
  State<Blood> createState() => _BloodState();
}

class _BloodState extends State<Blood> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.height;

    return Scaffold(

        // Appbar starts

        // Appbar starts
        appBar: AppBar(
          // Appbar title
          title:
              Text('Blood Group', style: Theme.of(context).textTheme.bodySmall),
          iconTheme: const IconThemeData(
            color: Colors.white, // Set the color for the drawer icon
          ),
          leading: IconButton(
            onPressed: () {
              if (widget.userType == "Non-Executive") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NonExecutiveHome(
                              userType: widget.userType.toString(),
                              userID: widget.userId.toString(),
                            )));
              }
              if (widget.userType == "Executive") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(
                              userType: widget.userType.toString(),
                              userId: widget.userId.toString(),
                            )));
              }
              if (widget.userType == "Guest") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GuestHomePage(
                              userType: widget.userType.toString(),
                              userId: widget.userId.toString(),
                            )));
              }
            },
            icon: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
        ),
        // Appbar ends

        // Main content starts here
        body: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (widget.userType == "Non-Executive") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NonExecutiveHomeNav(
                    userType: widget.userType.toString(),
                    userId: widget.userId.toString(),
                  ),
                ),
              );
            } else if (widget.userType == "Guest") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GuestHome(
                    userType: widget.userType.toString(),
                    userId: widget.userId.toString(),
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(
                    userType: widget.userType.toString(),
                    userId: widget.userId.toString(),
                  ),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, right: 20, left: 20),
                    child: Container(
                      width: 350,
                      height: 650,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        //border: Border.all(color: Colors.green, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.1), // rgba(0, 0, 0, 0.1)
                            offset: Offset(0,
                                4), // 0px horizontal offset, 4px vertical offset
                            blurRadius: 6, // 6px blur radius
                            spreadRadius: -1, // -1px spread radius
                          ),
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.06), // rgba(0, 0, 0, 0.06)
                            offset: Offset(0,
                                2), // 0px horizontal offset, 2px vertical offset
                            blurRadius: 4, // 4px blur radius
                            spreadRadius: -1, // -1px spread radius
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(
                                                  bloods: 'A+',
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text(
                                    "A+",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(
                                                  bloods: 'A-',
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text(
                                    "A-",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(
                                                  bloods: 'A1+',
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text(
                                    "A1+",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                              // Chip(
                              //   elevation: 20,
                              //   padding: EdgeInsets.all(8),
                              //   backgroundColor: Colors.greenAccent[100],
                              //   shadowColor: Colors.black,
                              //   avatar: CircleAvatar(
                              //     child: IconButton(
                              //       onPressed: () {
                              //         Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) => const BloodList(
                              //                     bloods: 'A1+',
                              //                   )),
                              //         );
                              //       },
                              //       icon: Icon(
                              //         Icons.water_drop_rounded,
                              //         color: Colors.red,
                              //         size: 50,
                              //       ),
                              //     ),
                              //     //NetworkImage
                              //   ), //CircleAvatar
                              //   label: Text(
                              //     'A',
                              //     style: Theme.of(context).textTheme.bodyMedium,
                              //   ), //Text
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(
                                                  bloods: 'A-',
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text(
                                    "A1-",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(
                                                  bloods: 'A2+',
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text(
                                    "A2+",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(
                                                  bloods: 'A2-',
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text(
                                    "A2-",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(
                                                  bloods: 'A1B+',
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text(
                                    "A1B+",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(
                                                  bloods: 'A1B-',
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text(
                                    "A1B-",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(
                                                  bloods: 'A2B+',
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text(
                                    "A2B+",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(
                                                  bloods: 'A2B-',
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text(
                                    "A2B-",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(
                                                  bloods: 'AB+',
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text("AB+",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium)
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(
                                                  bloods: 'AB-',
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text(
                                    "AB-",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(
                                                  bloods: 'B+',
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text(
                                    "B+",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(
                                                  bloods: 'B-',
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text(
                                    "B-",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(
                                                  bloods: 'O+',
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text(
                                    "O+",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(
                                                  bloods: 'O-',
                                                )),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text(
                                    "O-",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(bloods: 'BBG')),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text(
                                    "BBG",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BloodList(
                                                    bloods: 'INRA')),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                  Text("INRA",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium)
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
