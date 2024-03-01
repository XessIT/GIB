import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blood_group_list.dart';
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
    return Scaffold(
      // Appbar starts
      appBar: AppBar(
        // Appbar title
        title: Center(child: Text('Blood Group',
            style: Theme.of(context).textTheme.bodySmall)),
        iconTheme:  const IconThemeData(
          color: Colors.white, // Set the color for the drawer icon
        ),
        leading:IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage(userType: widget.userType, userID: widget.userId)));
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      // Appbar ends

      // Main content starts here
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              //  Image.asset('assets/blood4.jpg',height: 180,),
              const SizedBox(height: 10,),
              // Box Container starts here
              Container(
                width: 350,
                height: 370,
                //margin: const EdgeInsets.all(220.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(20.0)
                ),
                child: Column(
                  children: [
                    // First row starts
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // A+ blood group box starts
                       InkWell(
                          onTap: (){
                            // BlendMode.color;
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'A+',)),);
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(
                                child: Text('A+',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge,)),
                          ),
                        ),
                        // A+ blood group box ends

                        // A- blood group box starts
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) =>  const BloodList(bloods: 'A-',)),
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(child: Text('A-', style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge,)),
                          ),
                        ),
                        // A- blood group box Ends


                        // A1+ blood group box starts
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "A1+")),
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(child: Text('A1+', style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge,)),
                          ),
                        ),
                        // A1+ blood group box Ends
                      ],
                    ),
                    // First row ends

                    const SizedBox(height: 10,),
                    // Second row starts
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // A1- blood group box starts
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "A1-")),
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(
                                child: Text('A1-',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge,)),
                          ),
                        ),
                        // A1- blood group box ends

                        // A2+ blood group box Starts
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "'A2+'")),
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(child: Text('A2+', style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge,)),
                          ),
                        ),
                        // A2+ blood group box Ends

                        // A2- blood group box Starts
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "A2-")),
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(child: Text('A2-', style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge,)),
                          ),
                        ),
                        // A2- blood group box Ends
                      ],
                    ),
                    // Second row ends

                    const SizedBox(height: 10,),
                    // Third row starts
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // A1B+ blood group box starts
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "A1B+")),
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(
                                child: Text('A1B+',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge,)),
                          ),
                        ),
                        // A1B+ blood group box ends

                        // A1B- blood group box Starts
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "A1B-")),
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(child: Text('A1B-', style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge,)),
                          ),
                        ),
                        // A1B- blood group box Ends

                        // A2B+ blood group box Starts
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "A2B+")),
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(child: Text('A2B+', style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge,)),
                          ),
                        ),
                        // A2B+ blood group box ends
                      ],
                    ),
                    // Third row ends

                    const SizedBox(height: 10,),
                    // Fourth row starts
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // A2B- blood group box starts
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "A2B-")),
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(
                                child: Text('A2B-',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge,)),
                          ),
                        ),
                        // A2B- blood group box ends

                        // AB+ blood group box Starts
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "AB+")),
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(child: Text('AB+', style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge,)),
                          ),
                        ),
                        // AB+ blood group box ends

                        // AB- blood group box Starts
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "AB-")),
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(child: Text('AB-', style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge,)),
                          ),
                        ),
                        // AB- blood group box ends
                      ],
                    ),
                    // Fourth row ends

                    const SizedBox(height: 10,),
                    // Fifth row starts
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // B+ blood group box starts
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "B+")),
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(
                                child: Text('B+',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge,)),
                          ),
                        ),
                        // B+ blood group box ends

                        // B- blood group box Starts
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "B-")),
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(child: Text('B-', style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge,)),
                          ),
                        ),
                        // B- blood group box ends

                        // O+ blood group box Starts
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const BloodList(bloods: 'O+')),
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(child: Text('O+', style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge,)),
                          ),
                        ),
                        // O+ blood group box ends
                      ],
                    ),
                    // Fifth row ends

                    const SizedBox(height: 10,),
                    // Sixth row starts
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // O- blood group box starts
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "O-")),
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(
                                child: Text('O-',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge,)),
                          ),
                        ),
                        // O- blood group box ends

                        // BBG blood group box Starts
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "BBG")),
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(child: Text('BBG', style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge,)),
                          ),
                        ),
                        // BBG blood group box Ends

                        // INRA blood group box Starts
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const BloodList(bloods: "INRA")),
                            );
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 1),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Center(child: Text('INRA', style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge,)),
                          ),
                        ),
                        // INRA blood group box Ends
                      ],
                    ),
                    // Sixth row ends
                  ],
                ),
              ),
              // Box container ends here
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}