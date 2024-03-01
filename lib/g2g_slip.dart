import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
//import 'package:simple_time_range_picker/simple_time_range_picker.dart';

import 'g2g_slip_history.dart';
//import 'package:time_range_picker/time_range_picker.dart';
class GtoG extends StatelessWidget {
  const GtoG({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GtoGPage(),
    );
  }
}
class GtoGPage extends StatefulWidget {
  const GtoGPage({Key? key}) : super(key: key);

  @override
  State<GtoGPage> createState() => _GtoGPageState();
}
class _GtoGPageState extends State<GtoGPage> {
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  DateTime date =DateTime(2022,22,08);
  @override
  void initState(){
    super.initState();
  }

  String uid = "";
  String mobile ="";
  String firstname="";
  String district = "";
  String chapter="";
  TextEditingController metwith = TextEditingController();
  TextEditingController companyname = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController metdate = TextEditingController();
  TextEditingController fromtime = TextEditingController();
  TextEditingController totime = TextEditingController();
  TextEditingController companymobile = TextEditingController();

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }

  final _formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const G2GHistory())); },
              icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Center(
        child: Form(
            key: _formKey,
            child: Column(
                children:  [
                  const SizedBox(height: 20,),
                  //Container starts
                  Container(
                    width: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.green)
                    ),
                    child: Column(
                        children: [
                          const SizedBox(height: 10,),
                          //G2G slip Text starts
                          const Text("G2G Slip ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.green),),
                          //Metwith TextFormField starts
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              controller: metwith,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "* Enter the Name";
                                }else{
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                String capitalizedValue = capitalizeFirstLetter(value);
                                metwith.value = metwith.value.copyWith(
                                  text: capitalizedValue,
                                  selection: TextSelection.collapsed(offset: capitalizedValue.length),
                                );
                              },
                              decoration: const InputDecoration(
                                labelText: 'Met with:',
                                hintText: 'Met with:',
                                suffixIcon: Icon(Icons.search,color: Colors.green,),
                              ),
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(20),
                                AlphabetInputFormatter()
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              controller: companyname,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "* Enter the Company name";
                                }else{
                                  return null;
                                }
                              },
                                onChanged: (value) {
                                  String capitalizedValue = capitalizeFirstLetter(value);
                                  companyname.value = companyname.value.copyWith(
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
                              ]
                            ),
                          ),
                          //Company name TextFormField starts
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              controller: companymobile,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "* Enter the company Mobile Number";
                                }  else if(value.length<10){
                                  return "* Mobile should be 10 digits";
                                }
                                else  {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                labelText: 'Company Mobile Number',
                                hintText: 'Company Mobile Number',
                                  suffixIcon: Icon(Icons.phone_android,color: Colors.green,)
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters:<TextInputFormatter> [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          //Invited by TextFormField starts
                          const SizedBox(height: 15,),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //Location Icon starts

                                //Location TextFormField starts
                                SizedBox(
                                  width: 150,
                                  child: TextFormField(
                                    controller: location,
                                    validator: (value) {
                                      if(value!.isEmpty){
                                        return "* Enter the Location";
                                      }else{
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {
                                      String capitalizedValue = capitalizeFirstLetter(value);
                                      location.value = location.value.copyWith(
                                        text: capitalizedValue,
                                        selection: TextSelection.collapsed(offset: capitalizedValue.length),
                                      );
                                    },

                                    style: const TextStyle(fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    decoration: const InputDecoration(
                                      labelText: 'Location',
                                      hintText: 'Location',
                                      prefixIcon: Icon(
                                        Icons.location_on,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                    ),
                                    inputFormatters: [
                                      AlphabetInputFormatter(),
                                      LengthLimitingTextInputFormatter(25)
                                    ],
                                  ),
                                ),
                                //Icon calendar starts

                                //5-6-2022 TextFormField starts
                                SizedBox(
                                  width: 150,
                                  child: TextFormField(
                                      readOnly: true,
                                      controller: metdate,
                                      validator: (value) {
                                        if(value!.isEmpty){
                                          return "* Enter the date";
                                        }else{
                                          return null;
                                        }
                                      },
                                      onTap: () async {
                                          DateTime? pickDate = await showDatePicker(
                                         context: context,
                                         initialDate: DateTime.now(),
                                         firstDate: DateTime(1900),
                                         lastDate: DateTime(2100));
                                          if(pickDate==null) return;{
                                            setState(() {
                                       metdate.text =DateFormat('dd/MM/yyyy').format(pickDate);
                                       });
                                      }
                                      },
                                      style: const TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                        labelText: 'Date',
                                        hintText: 'Date',
                                         prefixIcon: const Icon(
                                            Icons.calendar_today_outlined,
                                         color: Colors.green,),
                                      )
                                  ),
                                ),
                              ]
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 150,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: fromtime,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "* Enter the From Time";
                                    }else{
                                      return null;
                                    }
                                  },
                                  onTap: () async {
                                    TimeOfDay? schedulenewTime = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay
                                            .now());
                                    //if 'cancel =null'
                                    if (schedulenewTime == null)
                                      return;
                                    DateTime scheduleparsedTime = DateFormat
                                        .jm().parse(
                                        schedulenewTime.format(
                                            context).toString());
                                    String scheduleformattedTime = DateFormat(
                                        'hh:mm a').format(
                                        scheduleparsedTime);
                                    //if 'ok = Timeofday
                                    setState(() {
                                      fromtime.text =
                                          scheduleformattedTime;
                                    });
                                  },
                                  style: const TextStyle(fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    labelText: 'From Time',
                                     prefixIcon: Icon(
                                          Icons.watch_later_outlined,color: Colors.green,),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: totime,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "* Enter the To Time";
                                    }else{
                                      return null;
                                    }
                                  },
                                  onTap: () async {
                                    TimeOfDay? schedulenewTime = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay
                                            .now());
                                    //if 'cancel =null'
                                    if (schedulenewTime == null)
                                      return;
                                    DateTime scheduleparsedTime = DateFormat
                                        .jm().parse(
                                        schedulenewTime.format(
                                            context).toString());
                                    String scheduleformattedTime = DateFormat(
                                        'hh:mm a').format(
                                        scheduleparsedTime);
                                    //if 'ok = Timeofday
                                    setState(() {
                                      totime.text =
                                          scheduleformattedTime;
                                    }
                                    );
                                  },
                                  style: const TextStyle(fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    labelText: 'To Time',
                                    prefixIcon: const Icon(
                                          Icons.watch_later_outlined,
                                      color: Colors.green,),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //Icon punch_clock starts

                          //7:00TO8:00PM TextFormField starts
                          const SizedBox(height: 40,),

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
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        content: Text(
                                            "Successfully done")));
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> G2GHistory()));
                                  }
                                },
                                child: const Text('Done',
                                  style: TextStyle(color: Colors.white),),
                              ),
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

                          //RichText texts starts
                          const SizedBox(height: 20,),
                          //const Text('It was nice Meeting with you😊')
                        ]
                    ),

                  ),
                  // Text G2G Slip starts

                ]
            )
        ),
      ),
    );
  }
  String _timeFormated(TimeOfDay time) {
    if (time == null) return "--:--";
    return "${time.hour}:${time.minute}";
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


