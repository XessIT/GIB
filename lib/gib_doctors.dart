import 'package:flutter/material.dart';
import 'package:gipapp/search_doctor.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('GiB Doctors')),
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
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    Map thisitem = [index] as Map;
                    return Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  DoctorsDetailsPage(thisitem['id'])));
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
                                    backgroundImage: Image
                                        .network("${thisitem['Image']}")
                                        .image,
                                    //  radius: 50,
                                  ),
                                  Text('${thisitem["First Name"]}\n'
                                      '${thisitem["Company Name"]}'),
                                  IconButton(
                                      onPressed: () {
                                        launch("tel://'${thisitem['Mobile']}'");
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


class DoctorsDetailsPage extends StatelessWidget {

  DoctorsDetailsPage(this.itemId , {Key? key}) : super(key: key){

  }


  String itemId;
  late Map data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Details"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/heartstetheshhope.png"),
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
                            child: Image.network('$data["Image"]',fit: BoxFit.cover,)),
                      ),
                      const SizedBox(height: 20,),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Doctor Name : Dr."'${data['First Name']}\n\n'
                              "Hospital Name : " '${data['Company Name']}\n\n'
                              "Hospital Address : "'${data['Company Address']}\n\n'


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

