import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'honor_slip_history.dart';

class ThankNotes extends StatelessWidget {
  const ThankNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ThankNotesPage(),
    );
  }
}
class ThankNotesPage extends StatefulWidget {
  const ThankNotesPage({Key? key}) : super(key: key);
  @override
  State<ThankNotesPage> createState() => _ThankNotesPageState();
}
class _ThankNotesPageState extends State<ThankNotesPage> {
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HonorHistory())); },
                icon: const Icon(Icons.more_vert)),
          ],
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children:  const [
                TabBar(
                  isScrollable: true,
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(text: ('Online'),),
                    Tab(text: ('Direct') ,),
                  ],
                ),
                Expanded(
                  child: TabBarView(children: <Widget>[
                    Online(),
                    Direct(),
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
class Online extends StatefulWidget {
  // final String? currenthold;
//  final String? currentsuccess;
  // final String? currentunsuccess;

  const Online({Key? key,
    //  required this.currenthold,
    // required this.currentsuccess,
    //  required this.currentunsuccess,
  }) : super(key: key);

  @override
  State<Online> createState() => _OnlineState();
}

class _OnlineState extends State<Online> {
  bool holdvisible = false;
  bool unsuccessvisible = false;
  bool successvisible = false;
  bool submitvisible = false;
  final _formKey = GlobalKey<FormState>();
  String? typeofvisitor="Self";
  String? uid="";
  String? mobile ="";
  String? firstname ="";
  TextEditingController holdreason = TextEditingController();
  TextEditingController successreason = TextEditingController();
  TextEditingController unsuccessreason = TextEditingController();
  String status = "Successful";
  String rejected = "Rejected";
  // CollectionReference updateU
  @override
  void initState() {
    //  holdreason =TextEditingController(text: widget.currenthold,);
    //  successreason =TextEditingController(text: widget.currentsuccess,);
    // unsuccessreason=TextEditingController(text: widget.currentunsuccess,);

    // TODO: implement initState
    super.initState();
  }
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        Map fromitem = [index] as Map;
                        if (fromitem["To Mobile"] == mobile || fromitem["Mobile"] == mobile) {
                          return Container(
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(height: 20,),
                                  SizedBox(width: 400,
                                    child: Card(
                                      color: Colors.white,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 20,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children:  [

                                                const Padding(padding: EdgeInsets.fromLTRB(30, 0, 0, 0),),
                                                if(typeofvisitor == typeofvisitor || fromitem["To Mobile"] == mobile)
                                                  Text("Referrer Name  : " "${fromitem["Referrer Name"]}"),
                                              ],
                                            ),
                                            const SizedBox(height: 10,),
                                            Row(
                                              children:  [
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),),
                                                Text('Purpose  : '"${fromitem["Purpose"]}"),
                                                const Padding(padding: EdgeInsets.fromLTRB(93, 0, 0, 0)),
                                                // Text("To thank her")
                                              ],
                                            ),
                                            const SizedBox(height: 10,),
                                            Row(
                                              children:  [
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),),
                                                Text('Date'"${fromitem["Date"]}"),

                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(25.0),
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      launch('tel://'"${fromitem["Mobile"]}");
                                                    },
                                                    icon: const Icon(Icons.call),
                                                    iconSize: 35,
                                                    color: Colors.green,
                                                  ),
                                                  const SizedBox(width: 10,),
                                                  IconButton(
                                                      onPressed: () async {
                                                        setState(() {
                                                          holdvisible = true;
                                                          unsuccessvisible = false;
                                                          successvisible = false;
                                                        });
                                                        /* Navigator.push(context, MaterialPageRoute(builder: (context)=>PauseReason()));*/
                                                      },
                                                      icon: const Icon(
                                                        Icons.motion_photos_pause_outlined,
                                                      ), iconSize: 35, color: Colors.orange),
                                                  const SizedBox(width: 10,),
                                                  IconButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        successvisible = true;
                                                        unsuccessvisible = false;
                                                        holdvisible = false;
                                                      });
                                                    },
                                                    icon: const Icon(Icons.thumb_up_outlined),
                                                    iconSize: 35,
                                                    color: Colors.green,
                                                  ),
                                                  const SizedBox(width: 10,),
                                                  IconButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        unsuccessvisible = true;
                                                        holdvisible = false;
                                                        successvisible = false;
                                                      });
                                                    },
                                                    icon: const Icon(Icons.thumb_down_alt_outlined),
                                                    iconSize: 35,
                                                    color: Colors.redAccent,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),

                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: holdvisible,
                                    child: SizedBox(width: 300,
                                      child: TextFormField(
                                        controller: holdreason,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "* Enter your reason";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) {
                                          String capitalizedValue = capitalizeFirstLetter(value);
                                          holdreason.value = holdreason.value.copyWith(
                                            text: capitalizedValue,
                                            selection: TextSelection.collapsed(offset: capitalizedValue.length),
                                          );
                                        },
                                        decoration: const InputDecoration(
                                          labelText: "Reason",
                                          hintText: "Reason",
                                            suffixIcon: Icon(Icons.abc)
                                        ),
                                        inputFormatters: [
                                          AlphabetInputFormatter(),
                                          LengthLimitingTextInputFormatter(30)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: successvisible,
                                    child: SizedBox(width: 300,
                                      child: TextFormField(
                                        controller: successreason,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "* Enter feedback";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) {
                                          String capitalizedValue = capitalizeFirstLetter(value);
                                          successreason.value = successreason.value.copyWith(
                                            text: capitalizedValue,
                                            selection: TextSelection.collapsed(offset: capitalizedValue.length),
                                          );
                                        },
                                        decoration: const InputDecoration(
                                          labelText: "Feedback",
                                          hintText:"Feedback" ,
                                            suffixIcon: Icon(Icons.abc)
                                        ),
                                        inputFormatters: [
                                          AlphabetInputFormatter(),
                                          LengthLimitingTextInputFormatter(30),
                                        ],
                                      ),

                                    ),
                                  ),
                                  Visibility(
                                    visible: unsuccessvisible,
                                    child: SizedBox(width: 300,
                                      child: TextFormField(
                                        controller: unsuccessreason,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Enter reason";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (value) {
                                          String capitalizedValue = capitalizeFirstLetter(value);
                                          unsuccessreason.value = unsuccessreason.value.copyWith(
                                            text: capitalizedValue,
                                            selection: TextSelection.collapsed(offset: capitalizedValue.length),
                                          );
                                        },
                                        decoration: const InputDecoration(
                                          labelText: "Why it should be Unsuccessful?",
                                          hintText: "Share about the reason",
                                            suffixIcon: Icon(Icons.abc)
                                        ),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(30),
                                          AlphabetInputFormatter(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Visibility(
                                    visible: holdvisible,
                                    child: Align(alignment: Alignment.center,
                                      child: OutlinedButton(
                                          onPressed: ()async {
                                            Navigator.pop(context);
                                            /*var currentUser;
                                        await FirebaseFirestore.instance.collection("Business Slip")
                                            .doc(currentUser.uid).update({
                                          "Uid":uid,
                                          "Hold Reason":holdreason});*/

                                            if (_formKey.currentState!.validate()) {
                                            }
                                          }, child: const Text("SUBMIT")),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  if(fromitem["id"]==fromitem["id"])
                                  Visibility(
                                    visible: successvisible,
                                    child: Align(alignment: Alignment.center,
                                      child: OutlinedButton(onPressed: () {
                                        Navigator.pop(context);

                                        if (_formKey.currentState!.validate()) {}
                                      }, child: const Text("SUBMIT")),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Visibility(
                                    visible: unsuccessvisible,
                                    child: Align(alignment: Alignment.center,
                                      child: OutlinedButton(onPressed: () {
                                        if (_formKey.currentState!.validate()) {}
                                      }, child: const Text("SUMBIT")),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return Container();
                      }
                  )
        )
    );
  }
}

class Direct extends StatefulWidget {
  const Direct({Key? key}) : super(key: key);

  @override
  State<Direct> createState() => _DirectState();
}

class _DirectState extends State<Direct> {
  @override
  void initState(){
    super.initState();
  }
  //final _formKey = GlobalKey<FormState>();

  String uid = "";
  String purpose = "";
  String mobile = "";


  final _formKey = GlobalKey<FormState>();

  TextEditingController tocontroller = TextEditingController();
  TextEditingController companynamecontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController mobilenocontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController amountcontroller= TextEditingController();
  TextEditingController purposeController= TextEditingController();
  TextEditingController tomobilenocontroller= TextEditingController();

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Container(
                  width: 350,
                  // height: 600,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.green)
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      const   Text('Honor Slip',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20),),
                      //To TextFormField starts
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller:tocontroller,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "* Enter the name";
                            }else{
                              return null;
                            }
                          },
                          onChanged: (value) {
                            String capitalizedValue = capitalizeFirstLetter(value);
                            tocontroller.value = tocontroller.value.copyWith(
                              text: capitalizedValue,
                              selection: TextSelection.collapsed(offset: capitalizedValue.length),
                            );
                          },
                          decoration: const InputDecoration(
                              labelText:'To',
                              hintText:'To',
                              suffixIcon: Icon(Icons.search,color: Colors.green,)
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: tomobilenocontroller,
                          validator: (value){
                            if(value!.isEmpty){
                              return '* Enter the mobile Number';
                            } else if(value.length<10){
                              return'* Mobile number should be 10 digits';
                            }
                            else{
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Mobile Number',
                            hintText: 'Mobile Number',
                              suffixIcon: Icon(Icons.phone_android,color: Colors.green,)
                          ),keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10)
                          ],
                        ),
                      ),
                      //Company name TextFormField starts
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller:companynamecontroller,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "* Enter the Company name";
                            }else{
                              return null;
                            }
                          },
                          onChanged: (value) {
                            String capitalizedValue = capitalizeFirstLetter(value);
                            companynamecontroller.value = companynamecontroller.value.copyWith(
                              text: capitalizedValue,
                              selection: TextSelection.collapsed(offset: capitalizedValue.length),
                            );
                          },
                          decoration: const InputDecoration(
                            labelText: 'Company Name',
                            hintText: 'Company Name',
                              suffixIcon: Icon(Icons.business,color: Colors.green,)
                          ),
                        ),
                      ),
                      const SizedBox(height: 10, ),
                      //Referral Details Text Starts
                      const Padding(
                        padding: EdgeInsets.only(right: 180),
                        child: Text('Business Details',
                          style: TextStyle(
                            fontSize: 18,),),
                      ),
                      //TextFormField Name starts
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: namecontroller,
                          validator: (value){
                            if(value!.isEmpty){
                              return '* Enter the name';
                            }
                            else{
                              return null;
                            }
                          },
                          onChanged: (value) {
                            String capitalizedValue = capitalizeFirstLetter(value);
                            namecontroller.value = namecontroller.value.copyWith(
                              text: capitalizedValue,
                              selection: TextSelection.collapsed(offset: capitalizedValue.length),
                            );
                          },
                          decoration: const InputDecoration(
                            labelText:'Name',
                            hintText: 'Name',
                            suffixIcon: Icon(Icons.account_circle,color: Colors.green,)
                          ),
                          inputFormatters: [
                            AlphabetInputFormatter(),
                            LengthLimitingTextInputFormatter(20)
                          ],
                        ),
                      ),
                      //TextFormField MobileNo starts
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: mobilenocontroller,
                          validator: (value){
                            if(value!.isEmpty){
                              return '* Enter the mobile Number';
                            }else if(value.length<10){
                              return'* Mobile number should be 10 digits';
                            }
                            else{
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'To Mobile Number',
                            hintText: 'To Mobile Number',
                              suffixIcon: Icon(Icons.phone_android,color: Colors.green,)
                          ),keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10)
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller:purposeController,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "* Enter the purpose";
                            }else{
                              return null;
                            }
                          },
                          onChanged: (value) {
                            String capitalizedValue = capitalizeFirstLetter(value);
                            purposeController.value = purposeController.value.copyWith(
                              text: capitalizedValue,
                              selection: TextSelection.collapsed(offset: capitalizedValue.length),
                            );
                          },
                          decoration: const InputDecoration(
                            labelText: 'Purpose',
                            hintText: 'Purpose',
                              suffixIcon: Icon(Icons.abc,color: Colors.green,)
                            //suffixIcon: Icon(Icons.search,color: Colors.green,)
                          ),
                          inputFormatters: [
                            AlphabetInputFormatter(),
                            LengthLimitingTextInputFormatter(30)
                          ],
                        ),
                      ),
                      //TextFormField Location starts
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: locationcontroller,
                          validator: (value){
                            if(value!.isEmpty){
                              return "* Enter the Location";
                            }else{
                              return null;
                            }
                          },
                          onChanged: (value) {
                            String capitalizedValue = capitalizeFirstLetter(value);
                            locationcontroller.value = locationcontroller.value.copyWith(
                              text: capitalizedValue,
                              selection: TextSelection.collapsed(offset: capitalizedValue.length),
                            );
                          },
                          decoration: const InputDecoration(
                            labelText: "Location",
                            hintText: "Location",
                            suffixIcon: Icon(
                              Icons.location_on,
                              color: Colors.green,),
                          ),
                        ),
                      ),
                      //Amount TextFormField starts
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: amountcontroller,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "* Enter the Amount";
                            }else{
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Amount',
                            prefixIcon: Icon(
                              Icons.currency_rupee_rounded,
                              color: Colors.green,),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],

                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Login button starts
                          MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)  ),
                              minWidth: 100,
                              height: 50,
                              color: Colors.green[800],
                              onPressed: (){
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content: Text(
                                          "Your Honor Successfully submitted")));
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HonorHistory()));
                                }
                              },
                              child:const Text('Honor',
                                style: TextStyle(color: Colors.white),)),
                          // Login button ends
                          // Sign up button starts
                          MaterialButton(
                              minWidth: 100,
                              height: 50,
                              color: Colors.orangeAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)  ),
                              onPressed: (){
                              },
                              child: const Text('Cancel',
                                style: TextStyle(color: Colors.white),)),
                          // Sign up button ends
                        ],
                      ),
                      const SizedBox(height: 5,),
                      // const Text('I Honor for your Closed Business😊',),
                      // SizedBox(height: 40,),
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
class AlphabetInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Filter out non-alphabetic characters
    String filteredText = newValue.text.replaceAll(RegExp(r'[^a-zA-Z]'), '');

    return newValue.copyWith(text: filteredText);
  }
}


