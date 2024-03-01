import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'business_slip_history.dart';

class Referral extends StatelessWidget {
  const Referral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ReferralPage(),

    );
  }
}
class ReferralPage extends StatefulWidget {
  const ReferralPage({Key? key}) : super(key: key);

  @override
  State<ReferralPage> createState() => _ReferralPageState();
}

class _ReferralPageState extends State<ReferralPage> {

  final _formKey =GlobalKey<FormState>();

  bool isVisible = false;
  String? typeofvisitor = "Self";
  TextEditingController tomobile =TextEditingController();
  TextEditingController to =TextEditingController();
  TextEditingController cname =TextEditingController();
  TextEditingController referrername =TextEditingController();
  TextEditingController businessmobile = TextEditingController();
  TextEditingController purpose = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  String uid = "";
  String mobile ="";
  String firstname ="";
  String district="";
  String chapter="";

  String successfulreason ="";
  String unsuccessfulreason ="";



  String holdreason ="";
  String status = "Pending";
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SlipHistory())); },
              icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Container(
                  width: 350,
                  //   height: 600,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.green)
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      const   Text('Business Slip',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20),),
                      const SizedBox(height: 20,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              // title: const Text("Male"),
                              value: "Self",
                              groupValue: typeofvisitor,
                              onChanged: (value) {
                                setState(() {
                                  isVisible = false;
                                  typeofvisitor = value.toString();
                                });
                              },
                            ),
                            const Text("Self"),
                            const SizedBox(width: 30,),
                            Radio(
                              // title: const Text("Female"),
                              value: "Referrer",
                              groupValue: typeofvisitor,
                              onChanged: (value) {
                                setState(() {
                                  isVisible = true;
                                  typeofvisitor = value.toString();
                                });
                              },
                            ),
                            const Text("Referer"),
                          ]
                      ),

                      //To TextFormField starts
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: to,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "* Enter the Name";
                            }else{
                              return null;
                            }
                          },
                          onChanged: (value) {
                            String capitalizedValue = capitalizeFirstLetter(value);
                            to.value = to.value.copyWith(
                              text: capitalizedValue,
                              selection: TextSelection.collapsed(offset: capitalizedValue.length),
                            );
                          },
                          decoration: const InputDecoration(
                              labelText: 'To',
                              hintText: 'To',
                              suffixIcon: Icon(Icons.search,color: Colors.green,)
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: tomobile,
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
                            labelText: 'To Mobile number',
                            hintText: 'To Mobile number',
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
                          controller: cname,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "* Enter the Company name";
                            }else{
                              return null;
                            }
                          },
                          onChanged: (value) {
                            String capitalizedValue = capitalizeFirstLetter(value);
                            cname.value = cname.value.copyWith(
                              text: capitalizedValue,
                              selection: TextSelection.collapsed(offset: capitalizedValue.length),
                            );
                          },
                          decoration: const InputDecoration(
                            labelText: 'Company name',
                            hintText: 'Company name',
                              suffixIcon: Icon(Icons.business,color: Colors.green,)
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30)
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      //Referral Details Text Starts
                      const Padding(
                        padding: EdgeInsets.only(right: 180),
                        child: Text('Business Details',
                          style: TextStyle(
                            fontSize: 18,),),
                      ),
                      //TextFormField Name starts
                      Visibility(
                        visible: isVisible,
                        child: SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: referrername,
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
                              referrername.value = referrername.value.copyWith(
                                text: capitalizedValue,
                                selection: TextSelection.collapsed(offset: capitalizedValue.length),
                              );
                            },
                            decoration: const InputDecoration(
                              labelText: 'Referrer Name',
                              hintText: 'Referrer Name',
                                suffixIcon: Icon(Icons.account_circle_outlined,color: Colors.green,)
                            ),
                            inputFormatters: [
                              AlphabetInputFormatter(),
                              LengthLimitingTextInputFormatter(25)
                            ],
                          ),
                        ),
                      ),
                      //TextFormField MobileNo starts
                      Visibility(
                        visible: isVisible,
                        child: SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: businessmobile,
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
                              labelText: 'Mobile number',
                              hintText: 'Mobile number',
                                suffixIcon: Icon(Icons.phone_android,color: Colors.green,)                            ),keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10)
                            ],
                          ),
                        ),
                      ),
                      //TextFormField Location starts
                      /*Visibility(
                    visible: isVisible,
                    child:SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: location,
                          validator: (value){
                            if(value!.isEmpty){
                              return "*Enter the Location";
                            }else{
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: "Location",
                            suffixIcon: Icon(
                              Icons.location_on,
                              color: Colors.green,),
                          ),
                        ),
                      ),
                  ),*/

                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: purpose,
                          validator: (value){
                            if(value!.isEmpty){
                              return "* Enter the Purpose";
                            }else{
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: "Purpose",
                            hintText: "Purpose",
                            suffixIcon: Icon(
                              Icons.note,
                              color: Colors.green,),
                          ),
                          inputFormatters: [
                            AlphabetInputFormatter(),
                            LengthLimitingTextInputFormatter(25)
                          ],
                        ),
                      ),

                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Submit button starts
                          MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)  ),
                              minWidth: 100,
                              height: 50,
                              color: Colors.green[800],
                              onPressed: (){
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text("Registered Successfully")));
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BusinessHistory()));
                                }
                              },
                              child: const Text('SUBMIT',
                                style: TextStyle(color: Colors.white),)),
                          // Submit button ends

                          // Cancel button starts
                          MaterialButton(
                              minWidth: 100,
                              height: 50,
                              color: Colors.orangeAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)  ),
                              onPressed: (){
                              },
                              child: const Text('Cancel',
                                style: TextStyle(color: Colors.white),)),
                          // Cancel button ends
                        ],
                      ),
                      const SizedBox(height: 20,),
                      //        const Text('Thanks for your Referral😊', style: TextStyle(fontSize: 13),),


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
