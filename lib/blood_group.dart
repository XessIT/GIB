import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Non_exe_pages/non_exe_home.dart';
import 'blood_group_list.dart';
import 'guest_home.dart';
import 'home.dart';
import 'home1.dart';


class BloodGroup extends StatelessWidget {
  final String userType;
  final String? userId;
  const BloodGroup({Key? key, required this.userType, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // Main calling function. This function coding will appear below
      body: Blood(userType: userType, userId: userId),
    );
  }

}


class Blood extends StatefulWidget {
  final String userType;
  final String? userId;
  const Blood({Key? key, required this.userType, required this.userId}) : super(key: key);

  @override
  State<Blood> createState() => _BloodState();

}

class _BloodState extends State<Blood> {



  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.height;

    return Scaffold(
      // Appbar starts
      appBar: AppBar(
        // Appbar title
        title: Text('Blood Group',
            style: Theme.of(context).textTheme.bodySmall),
        iconTheme:  const IconThemeData(
          color: Colors.white, // Set the color for the drawer icon
        ),
        leading: IconButton(onPressed: (){
          if(widget.userType =="Non-Executive") {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>NonExecutiveHome(
              userType:widget.userType.toString(),
              userID: widget.userId.toString(),

            )));
          }
          if(widget.userType =="Executive") {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(
              userType:widget.userType.toString(),
              userId: widget.userId.toString(),
            )));
          }
          if(widget.userType =="Guest") {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>GuestHomePage(
              userType:widget.userType.toString(),

              userId: widget.userId.toString(),
            )));
          }

        },icon: const Icon(Icons.arrow_back),
        )   ,
        centerTitle: true,
      ),
      // Appbar ends

      // Main content starts here
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30,right: 20,left: 20),
                child: Container(
                  width: 350,
                  height: 650,


                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    /// dark  colors: [Color(0xFFD81B60), Color(0xFFEF5350)], // Pink to Red gradient
                      colors: [
                        Colors.pink.shade100, // Light Pink
                        Color(0xFFFFAB91), // Light Orange
                      //  Color(0xFFF06292), // Light Pink
                        Colors.pink.shade100, // Light Pink

                        Color(0xFFFFAB91),
                      ], // Pink to Light Pink to Red gradient

                    ),// Optional: Add rounded corners

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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'A+',)),);
                                },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("A+",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'A-',)),);
                              },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("A-",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'A1+',)),);

                              },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("A1+",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'A-',)),);

                              },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("A1-",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'A2+',)),);

                              },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("A2+",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'A2-',)),);

                              },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("A2-",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),



                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'A1B+',)),);

                              },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("A1B+",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'A1B-',)),);
                              },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("A1B-",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'A2B+',)),);
                              },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("A2B+",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),



                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'A2B-',)),);
                              },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("A2B-",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'AB+',)),);
                              },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("AB+",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'AB-',)),);
                              },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("AB-",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),



                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'B+',)),);
                              },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("B+",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'B-',)),);
                              },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("B-",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'O+',)),);
                              },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("O+",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'O-',)),);
                              },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("O-",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'BBG')),);
                              },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("BBG",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'INRA')),);
                              },
                              icon: Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Text("INRA",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),

                      ],
                    ),



                  ],
                                ),
              ),)

              // Container(
              //   width: 350,
              //   height: 370,
              //   //margin: const EdgeInsets.all(220.0),
              //   padding: const EdgeInsets.all(20.0),
              //   decoration: BoxDecoration(
              //       border: Border.all(color: Colors.green, width: 2),
              //       borderRadius: BorderRadius.circular(20.0)
              //   ),
              //   child: Column(
              //     children: [
              //       // First row starts
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           // A+ blood group box starts
              //          InkWell(
              //             onTap: (){
              //               // BlendMode.color;
              //               Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'A+',)),);
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(
              //                   child: Text('A+',
              //                     style: Theme
              //                         .of(context)
              //                         .textTheme
              //                         .bodyLarge,)),
              //             ),
              //           ),
              //           // A+ blood group box ends
              //
              //           // A- blood group box starts
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                 context, MaterialPageRoute(builder: (context) =>  const BloodList(bloods: 'A-',)),
              //               );
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(child: Text('A-', style: Theme
              //                   .of(context)
              //                   .textTheme
              //                   .bodyLarge,)),
              //             ),
              //           ),
              //           // A- blood group box Ends
              //
              //
              //           // A1+ blood group box starts
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                 context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "A1+")),
              //               );
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(child: Text('A1+', style: Theme
              //                   .of(context)
              //                   .textTheme
              //                   .bodyLarge,)),
              //             ),
              //           ),
              //           // A1+ blood group box Ends
              //         ],
              //       ),
              //       // First row ends
              //
              //       const SizedBox(height: 10,),
              //       // Second row starts
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           // A1- blood group box starts
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                 context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "A1-")),
              //               );
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(
              //                   child: Text('A1-',
              //                     style: Theme
              //                         .of(context)
              //                         .textTheme
              //                         .bodyLarge,)),
              //             ),
              //           ),
              //           // A1- blood group box ends
              //
              //           // A2+ blood group box Starts
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                 context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "'A2+'")),
              //               );
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(child: Text('A2+', style: Theme
              //                   .of(context)
              //                   .textTheme
              //                   .bodyLarge,)),
              //             ),
              //           ),
              //           // A2+ blood group box Ends
              //
              //           // A2- blood group box Starts
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                 context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "A2-")),
              //               );
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(child: Text('A2-', style: Theme
              //                   .of(context)
              //                   .textTheme
              //                   .bodyLarge,)),
              //             ),
              //           ),
              //           // A2- blood group box Ends
              //         ],
              //       ),
              //       // Second row ends
              //
              //       const SizedBox(height: 10,),
              //       // Third row starts
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           // A1B+ blood group box starts
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                 context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "A1B+")),
              //               );
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(
              //                   child: Text('A1B+',
              //                     style: Theme
              //                         .of(context)
              //                         .textTheme
              //                         .bodyLarge,)),
              //             ),
              //           ),
              //           // A1B+ blood group box ends
              //
              //           // A1B- blood group box Starts
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                 context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "A1B-")),
              //               );
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(child: Text('A1B-', style: Theme
              //                   .of(context)
              //                   .textTheme
              //                   .bodyLarge,)),
              //             ),
              //           ),
              //           // A1B- blood group box Ends
              //
              //           // A2B+ blood group box Starts
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                 context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "A2B+")),
              //               );
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(child: Text('A2B+', style: Theme
              //                   .of(context)
              //                   .textTheme
              //                   .bodyLarge,)),
              //             ),
              //           ),
              //           // A2B+ blood group box ends
              //         ],
              //       ),
              //       // Third row ends
              //
              //       const SizedBox(height: 10,),
              //       // Fourth row starts
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           // A2B- blood group box starts
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                 context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "A2B-")),
              //               );
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(
              //                   child: Text('A2B-',
              //                     style: Theme
              //                         .of(context)
              //                         .textTheme
              //                         .bodyLarge,)),
              //             ),
              //           ),
              //           // A2B- blood group box ends
              //
              //           // AB+ blood group box Starts
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                 context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "AB+")),
              //               );
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(child: Text('AB+', style: Theme
              //                   .of(context)
              //                   .textTheme
              //                   .bodyLarge,)),
              //             ),
              //           ),
              //           // AB+ blood group box ends
              //
              //           // AB- blood group box Starts
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                 context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "AB-")),
              //               );
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(child: Text('AB-', style: Theme
              //                   .of(context)
              //                   .textTheme
              //                   .bodyLarge,)),
              //             ),
              //           ),
              //           // AB- blood group box ends
              //         ],
              //       ),
              //       // Fourth row ends
              //
              //       const SizedBox(height: 10,),
              //       // Fifth row starts
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           // B+ blood group box starts
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                 context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "B+")),
              //               );
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(
              //                   child: Text('B+',
              //                     style: Theme
              //                         .of(context)
              //                         .textTheme
              //                         .bodyLarge,)),
              //             ),
              //           ),
              //           // B+ blood group box ends
              //
              //           // B- blood group box Starts
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                 context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "B-")),
              //               );
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(child: Text('B-', style: Theme
              //                   .of(context)
              //                   .textTheme
              //                   .bodyLarge,)),
              //             ),
              //           ),
              //           // B- blood group box ends
              //
              //           // O+ blood group box Starts
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                 context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'O+')),
              //               );
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(child: Text('O+', style: Theme
              //                   .of(context)
              //                   .textTheme
              //                   .bodyLarge,)),
              //             ),
              //           ),
              //           // O+ blood group box ends
              //         ],
              //       ),
              //       // Fifth row ends
              //
              //       const SizedBox(height: 10,),
              //       // Sixth row starts
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           // O- blood group box starts
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                 context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "O-")),
              //               );
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(
              //                   child: Text('O-',
              //                     style: Theme
              //                         .of(context)
              //                         .textTheme
              //                         .bodyLarge,)),
              //             ),
              //           ),
              //           // O- blood group box ends
              //
              //           // BBG blood group box Starts
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                 context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "BBG")),
              //               );
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(child: Text('BBG', style: Theme
              //                   .of(context)
              //                   .textTheme
              //                   .bodyLarge,)),
              //             ),
              //           ),
              //           // BBG blood group box Ends
              //
              //           // INRA blood group box Starts
              //           InkWell(
              //             onTap: (){
              //               Navigator.push(
              //                 context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "INRA")),
              //               );
              //             },
              //             child: Container(
              //               width: 70,
              //               height: 45,
              //               padding: const EdgeInsets.all(10.0),
              //               decoration: BoxDecoration(
              //                   border: Border.all(
              //                       color: Colors.green, width: 1),
              //                   borderRadius: BorderRadius.circular(5.0)
              //               ),
              //               child: Center(child: Text('INRA', style: Theme
              //                   .of(context)
              //                   .textTheme
              //                   .bodyLarge,)),
              //             ),
              //           ),
              //           // INRA blood group box Ends
              //         ],
              //       ),
              //       // Sixth row ends
              //     ],
              //   ),
              // ),

            ],
          ),
        ),
      ),
    );
  }
}