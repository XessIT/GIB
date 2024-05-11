import 'dart:convert';
import 'package:gipapp/business.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'business_slip_history.dart';

class ReferralPage extends StatefulWidget {
  final String? userType;
  final String? userId;
  const ReferralPage({super.key, required this.userType, required this.userId});

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
  TextEditingController referreename =TextEditingController();
  TextEditingController referreemobile = TextEditingController();
  TextEditingController purpose = TextEditingController();

  String? fname = "";
  String? lname = "";
  String? mobile = "";
  String? companyname = "";
  List dynamicdata=[];
  Future<void> fetchData(String userId) async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/registration.php?table=registration&id=$userId');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("response S: ${response.statusCode}");
        print("response B: ${response.body}");
        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>) {
          setState(() {
            dynamicdata = responseData.cast<Map<String, dynamic>>();
            if (dynamicdata.isNotEmpty) {
              setState(() {
                fname = dynamicdata[0]["first_name"];
                lname= dynamicdata[0]['last_name'];
                mobile=dynamicdata[0]["mobile"];
                companyname=dynamicdata[0]["company_name"];
              });
            }
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
  Future<void> InsertBusinessSlip() async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/business_slip.php');
        final response = await http.post(
          url,
          body: jsonEncode({
            "type": typeofvisitor,
            "Toname": to.text,
            "Tomobile": tomobile.text,
            "Tocompanyname": cname.text,
            "purpose": purpose.text,
            "referree_name": referreename.text,
            "referree_mobile": referreemobile.text,
            "referrer_name": fname,
            "referrer_mobile": mobile,
            "referrer_company": companyname,
            "status": status
          }),
        );
        print(url);
        print("ResponseStatus: ${response.statusCode}");
        if (response.statusCode == 200) {
          print("Offers response: ${response.body}");
        } else {
          print("Error: ${response.statusCode}");
        }
      } catch (e) {
      print("Error during signup: $e");
      // Handle error as needed
    }
  }
  @override
  void initState() {
    fetchData(widget.userId.toString());
    // TODO: implement initState
    super.initState();
  }

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
        title: Text('BUSINESS SLIP', style: Theme.of(context).textTheme.bodySmall),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(onPressed:(){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => BusinessHistory(userType: widget.userType, userId: widget.userId))); },
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
                      /*const SizedBox(height: 10,),
                      Text('Business Slip',
                        style: TextStyle(
                            color: Colors.green[800],
                            fontSize: 20),),*/
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
                            controller: referreename,
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
                              referreename.value = referreename.value.copyWith(
                                text: capitalizedValue,
                                selection: TextSelection.collapsed(offset: capitalizedValue.length),
                              );
                            },
                            decoration: const InputDecoration(
                              labelText: 'Referree Name',
                              hintText: 'Referree Name',
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
                            controller: referreemobile,
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
                          // Cancel button starts
                          MaterialButton(
                              minWidth: 100,
                              height: 50,
                              color: Colors.orangeAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)  ),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>BusinessPage(userId: widget.userId, userType: widget.userType)));
                              },
                              child: const Text('Cancel',
                                style: TextStyle(color: Colors.white),)),
                          // Cancel button ends
                          // Submit button starts
                          MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)  ),
                              minWidth: 100,
                              height: 50,
                              color: Colors.green[800],
                              onPressed: (){
                                if (_formKey.currentState!.validate()) {
                                  InsertBusinessSlip();
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BusinessPage(userId: widget.userId, userType: widget.userType)));
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text("Registered Successfully")));
                                }
                              },
                              child: const Text('SUBMIT',
                                style: TextStyle(color: Colors.white),)),
                          // Submit button ends


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
