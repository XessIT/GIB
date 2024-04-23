import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gipapp/search_doctor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart'as http;

class GibDoctors extends StatelessWidget {
  const GibDoctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Doctors(),
    );
  }
}

class Doctors extends StatefulWidget {
  const Doctors({Key? key}) : super(key: key);

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {

  String doctor="Doctor's Wing";

List<Map<String,dynamic>> getDoctor=[];
  Future<void> getGibDoctors() async {
    try {

      final url =

      Uri.parse('http://localhost/GIB/lib/GIBAPI/registration.php?table=registration&member_type=$doctor');

        print("Doctor Url:$url");
      final response = await http.get(url);

        print("Response:$response");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> itemGroups = responseData;
          print("responseData:$responseData");
          print("statusCode:${response.statusCode}");
          print("statusCode:${response.body}");
        setState(() {
          getDoctor = itemGroups.cast<Map<String, dynamic>>();
          print("aboutVision:$getDoctor");
        });
      } else {
        // Handle error
      }
    } catch (error) {
      // Handle error
    }
  }

@override
  void initState() {
    // TODO: implement initState
  getGibDoctors();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text('GiB Doctors', style: Theme.of(context).textTheme.bodySmall),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  SearchDoctor()),
              );
            },
          ),
        ],
      ),

      body: ListView.builder(
                  itemCount: getDoctor.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> thisitem = getDoctor[index];
                    return Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  DoctorsDetailsPage(itemId:thisitem['id'])));
                            },
                            child: Container(
                              width: 300,
                              height: 100,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.green, width: 1),
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [

                                  CircleAvatar(
                                    backgroundImage: NetworkImage("https://localhost/GIB/GIBAPI/upload/${thisitem['profile_image']}image.png"),

                                    /* backgroundImage: Image
                                        .network(thisitem['profile_image'])
                                        .image,*/
                                    //  radius: 50,
                                  ),
                                  Text('${thisitem["first_name"]}\n'
                                      '${thisitem["company_name"]}'),
                                  IconButton(
                                      onPressed: () {
                                        launch("tel://'${thisitem['mobile']}'");
                                      },
                                      icon: const Icon(
                                        Icons.call, color: Colors.green,))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              )
    );
  }
}


class DoctorsDetailsPage extends StatefulWidget {
  String? itemId="";

  DoctorsDetailsPage( {Key? key,required this.itemId ,}) : super(key: key){
  }


  @override
  State<DoctorsDetailsPage> createState() => _DoctorsDetailsPageState();
}

class _DoctorsDetailsPageState extends State<DoctorsDetailsPage> {
  List<Map<String,dynamic>> getDoctor=[];

  Future<void> getGibDoctors() async {
    try {

      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/registration.php?table=registration&id=${widget.itemId}');

      print("Doctor fetch Url:$url");
      final response = await http.get(url);

      print("Response:$response");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> itemGroups = responseData;
        print("responseData:$responseData");
        print("statusCode:${response.statusCode}");
        print("statusCode:${response.body}");
        setState(() {
          getDoctor = itemGroups.cast<Map<String, dynamic>>();
          print("doctor:$getDoctor");
        });
      } else {
        // Handle error
      }
    } catch (error) {
      // Handle error
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if(widget.itemId!.isNotEmpty){
    getGibDoctors();}
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Details",style: Theme.of(context).textTheme.bodySmall),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img_3.png"),
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.2), BlendMode.dstATop),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 30,),

                      Container(
                        child: SizedBox(
                            height: 80,
                            width: 90,
                            // width:double.infinity,
                            // height: 300,
                            child: Image.network('${getDoctor[0]["image"]}',fit: BoxFit.cover,)),
                      ),
                      const SizedBox(height: 20,),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Doctor Name : Dr."'${getDoctor[0]['first_name']}\n\n'
                              "Hospital Name : " '${getDoctor[0]['company_name']}\n\n'
                              "Hospital Address : "'${getDoctor[0]['company_address']}\n\n'
                          ),
                        ),
                      ),
                    ],
                  ),
                )
      ),
    );
  }
}

