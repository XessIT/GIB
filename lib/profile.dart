import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gipapp/guest_personal_edit.dart';
import 'package:gipapp/view_gallery_image.dart';
import 'business_edit.dart';
import 'Non_exe_pages/non_exe_home.dart';
import 'package:http/http.dart'as http;
import 'personal_edit.dart';
import 'guest_home.dart';
import 'home.dart';

class Profile extends StatelessWidget {
  final String userType;
  final String? userID;
   Profile({
    Key? key,
    required this.userType,
    required this. userID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: View(
        userType : userType,
      userID:userID),
    );
  }
}

class View extends StatefulWidget {

  final String userType;

 final String? userID;


      const View({
    super.key,

    required this.userType,

    required this. userID,
  });

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('My Profile')),
          centerTitle: true,

    leading: IconButton(onPressed: (){
      if(widget.userType =="Non-Executive")
    Navigator.push(context, MaterialPageRoute(builder: (context)=>NonExecutiveHome(
    userType:widget.userType.toString(),
    userID: widget.userID.toString(),

    )));
     if(widget.userType =="Executive") {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(
      userType:widget.userType.toString(),
      userId: widget.userID.toString(),
    )));
     }
    if(widget.userType =="Guest")
    Navigator.push(context, MaterialPageRoute(builder: (context)=>GuestHomePage(
      userType:widget.userType.toString(),

      userId: widget.userID.toString(),
    )));

    },icon: Icon(Icons.arrow_back),
    ),),
        body: Column(
          children:  [
            TabBar(
                isScrollable: true,
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: 'Personal',),
                  Tab(text: 'Business',),
                  Tab(text: 'Reward',)
                ]),
            Expanded(
              child: TabBarView(
                children: [
                  Personal(
                    userType:widget.userType,
                    userID:widget.userID,

                  ),
                  BusinessTabPage(),
                 // Reward(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Personal extends StatefulWidget {


 final String userType;
  final String? userID;

   Personal({
    Key? key,

    required this.userType,
     required this. userID,
  }) : super(key: key);


  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {

  String? fname = "";
  String? lname = "";
  String? image = "";
  String? district = "";
  String? chapter = "";
  String? location = "";
  String? dob = "";
  String? wad = "";
  String? koottam = "";
  String? kovil = "";
  String? member = "";
  String? bloodgroup = "";
  String? spousename = "";
  String? spousebloodgroup = "";
  String? spousenative = "";
  String? spousekoottam = "";
  String? spousekovil = "";
  String? mobile = "";
  String? email = "";
  String docId = "";
  String? education = "";
  String? pastexperience = "";
  String? userID = "";
  List dynamicdata=[];
  String profileImage="";
  String marital_status="";

  Future<void> fetchData(String userId) async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/registration.php?table=registration&id=$userId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>) {
          setState(() {
            dynamicdata = responseData.cast<Map<String, dynamic>>();
            if (dynamicdata.isNotEmpty) {
              setState(() {
                fname = dynamicdata[0]["first_name"];
                lname= dynamicdata[0]['last_name'];
                location=dynamicdata[0]["place"];
                dob=dynamicdata[0]["dob"];
                district=dynamicdata[0]["district"];
                mobile=dynamicdata[0]["mobile"];
                chapter=dynamicdata[0]["chapter"];
                kovil=dynamicdata[0]["kovil"];
                email=dynamicdata[0]["email"];
                spousename=dynamicdata[0]["s_name"];
                wad=dynamicdata[0]["WAD"];
                spousekovil=dynamicdata[0]["s_father_kovil"];
                education=dynamicdata[0]["education"];
                pastexperience=dynamicdata[0]["past_experience"];
                member = dynamicdata[0]["member_type"];
                koottam = dynamicdata[0]["koottam"];
                spousekoottam = dynamicdata[0]["s_father_koottam"];
                bloodgroup = dynamicdata[0]["blood_group"];
                spousenative = dynamicdata[0]["native"];
                spousename=dynamicdata[0]["s_name"];
                spousename=dynamicdata[0]["s_name"];
                spousebloodgroup = dynamicdata[0]["s_blood"];
                spousekovil=dynamicdata[0]["s_father_kovil"];
                profileImage=dynamicdata[0]["profile_image"];
                marital_status=dynamicdata[0]["marital_status"];
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

  @override
  void initState() {
    fetchData(widget.userID.toString());
    userID=widget.userID;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    widget.userType != "Guest"?

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PersonalEdit (
                      currentID:userID.toString(),
                    )))
                        : Navigator.push(context, MaterialPageRoute(builder: (context)=> GuestPersonalEdit (
                      currentID:userID.toString(),
                    )));
                  },
                  icon: Icon(Icons.edit, color: Colors.green[800],),
                ),
              ),
              ExpansionTile(
                leading: const Icon(Icons.info),
                title: const Text('Basic Information'),
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Name'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(fname!),
                      ),

                    ],
                  ),
                  if(widget.userType != "Guest")
                  const Divider(),
                  if(widget.userType != "Guest")

                    Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('District'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(district!),
                      )
                    ],
                  ),
                  if(widget.userType != "Guest")

                    const Divider(),
                  if(widget.userType != "Guest")

                    Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Chapter'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(chapter!),
                      )
                    ],
                  ),

                    const Divider(),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Native'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(location!),
                      )
                    ],
                  ),
                  if(widget.userType != "Guest")

                    const Divider(),
                  if(widget.userType != "Guest")

                    Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('DOB'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(dob!),
                      )
                    ],
                  ), if(widget.userType != "Guest")
                  const Divider(),
                  if(widget.userType != "Guest")
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Koottam'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(koottam!),
                      )
                    ],
                  ),
                  if(widget.userType != "Guest")

                    const Divider(),
                  if(widget.userType != "Guest")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Kovil'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(kovil!),
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Member'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.userType),
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Blood Group'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(bloodgroup!),
                      )
                    ],
                  ),
                ],
              ),
              if(widget.userType != "Guest" && marital_status=="Married")

              ExpansionTile(
                leading: const Icon(Icons.group),
                title: const Text('Dependents'),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Spouse Name'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:spousename == null ? const Text("Nil")
                            : Text(spousename!),
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('WAD'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(wad!),
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Spouse Blood Group'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(spousebloodgroup!),
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Spouse Native'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:spousenative == null ? const Text("Nil")
                            : Text(spousenative!),
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Spouse Father Koottam'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: spousekoottam == null ? const Text("Nil")
                            : Text(spousekoottam!),
                      )

                    ],),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Spouse Father Kovil'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: spousekovil== null ? const Text("Nil")
                            : Text(spousekovil!),
                      )

                    ],),
                ],),

              ExpansionTile(
                leading: const Icon(Icons.call),
                title: const Text('Contact'),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Mobile Number'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("+91${mobile!}"),
                      )

                    ],),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Email'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(email!),
                      )

                    ],),
                ],
              ),
              if(widget.userType != "Guest")
              ExpansionTile(
                leading: const Icon(Icons.cast_for_education),
                title: const Text('Education Details'),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Education'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(education!),)
                    ],
                  )
                ],
              ),
              if(widget.userType != "Guest")
              ExpansionTile(
                leading: const Icon(Icons.man),
                title: const Text('Past Experience'),
                children: [
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Past Experience'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(pastexperience!),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class BusinessTabPage extends StatefulWidget {
  const BusinessTabPage({Key? key}) : super(key: key);

  @override
  State<BusinessTabPage> createState() => _BusinessTabPageState();
}
class _BusinessTabPageState extends State<BusinessTabPage> {



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 10,width: 100,
            ),

            //MAIN CONTAINER STARTS
            Container(
              height: 25,
              width: 240,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
              ),

              //TABBAR STARTS
              child: TabBar(
                indicator: const BoxDecoration(
                  color: Colors.green,
                ),
                //TABS STARTS
                unselectedLabelColor: Colors.black,
                tabs: [
                  const Tab(text: ('BusinessInfo')),
                  InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ImageAndVideo()));
                      },
                      child: const Tab(text: ('Gallery'))),
                ],
              ) ,
            ),

            //TABBAR VIEW STARTS
            const Expanded(
              child: TabBarView(children: [
                BusinessInfo(),
                // ImageAndVideo(),

              ]),
            )
          ],
        ),
      ),
    );
  }
}

class BusinessInfo extends StatefulWidget {
  const BusinessInfo({Key? key}) : super(key: key);

  @override
  State<BusinessInfo> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {


  String? businesstype="";
  String? companyname ="";
  String? businessimage = "";
  String? businesskeywords ="";
  //String? service="";
  String? address="";
  String? mobile="";
  String? email="";
  String? website ="";
  String? ybe="";
  String documentid="";

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
    }
    @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Image.network(businessimage!, fit: BoxFit.cover,)
              ),
              //Image.asset('assets/profile.jpg'),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> BusinessEditPage(
                      currentbusinessimage: businessimage,
                      currentcompanyname: companyname,
                      currentmobile: mobile,
                      currentemail: email,
                      currentaddress: address,
                      currentwebsite: website,
                      currentybe: ybe,
                      documentid: documentid,
                      currentbusinesskeywords: businesskeywords,
                      currentbusinesstype: businesstype, currentdimage: businessimage ,
                    )));
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              ExpansionTile(
                leading: const Icon(Icons.info),
                title: const Text('Business Information'),
                children: [
                  const SizedBox(height: 10,),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Text('Business Type'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(108, 0, 0, 0),
                        child: Text(businesstype!),
                      )
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Text('Company Name'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(94, 0, 0, 0),
                        child: Text(companyname!),
                      )
                    ],
                  ),

                  const Divider(color: Colors.grey,),
                  SizedBox(
                    height: 50,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:  [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Text('Business Keywords'),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(73, 0, 0, 0),
                          child: Text(businesskeywords!,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                leading: const Icon(Icons.contacts),
                title: const Text('Contact'),
                children: [
                  SizedBox(
                    height: 100,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:  [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('Address')),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(124, 0, 0, 0),
                          child: Text(address!,
                            //  textAlign: TextAlign.justify,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children:  [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('Mobile')),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(130, 0, 0, 0),
                        child: Text(mobile!,
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('Email')),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(140, 0, 0, 2),
                        child: Text(email!,
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  )

                ],
              ),
              ExpansionTile(
                leading: const Icon(Icons.call),
                title: const Text('Company History'),
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Text('Website/Brochure'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(73, 0, 0, 5),
                        child: Text(website!),
                      )
                    ],
                  ),
                  const Divider(color: Colors.grey,),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Text('Year of Business\nEstablished'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(88, 0, 0, 0),
                        child: Text(ybe!),
                      )
                    ],
                  ),
                ],
              ),
            ],

          ),
        ),
      ),
    );
  }
}
class ImageAndVideo extends StatefulWidget {
  const ImageAndVideo({Key? key}) : super(key: key);

  @override
  State<ImageAndVideo> createState() => _ImageAndVideoState();
}

class _ImageAndVideoState extends State<ImageAndVideo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Gallery"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 15,width: 100,
            ),

            //MAIN CONTAINER STARTS
            Container(
              height: 30,
              width: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
              ),

              //TABBAR STARTS
              child: const TabBar(
                indicator: BoxDecoration(
                  color: Colors.green,
                ),
                //TABS STARTS
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: ('Image')),
                  Tab(text: ('Video')),
                ],
              ) ,
            ),

            //TABBAR VIEW STARTS
            const Expanded(
              child: TabBarView(children: [
                ImageView(),
                VideoView(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}



class ImageView extends StatefulWidget {
  const ImageView({Key? key}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  DateTime date = DateTime.now();


  String? image = "";
  String? docId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemBuilder: (context, index) {
            return Column(
              children: [
                const SizedBox(height: 30,),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            ViewGalleryImage("")));
                  },
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        '', fit: BoxFit.cover,)),

                ),
                // Text(urlDownload),
              ],
            );
          }
      ),

    );
  }
}
class VideoView extends StatefulWidget {
  const VideoView({Key? key}) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemBuilder: (context, index) {

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                    },
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network("Image"),
                    ),
                  )
                ],
              ),
            );
          }
      ),
    );
  }
}







class Reward extends StatefulWidget {
  const Reward({Key? key}) : super(key: key);

  @override
  State<Reward> createState() => _RewardState();
}

class _RewardState extends State<Reward> {

  String? image = "";
  String documentid="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [

                const SizedBox(height: 20,),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Icon(Icons.person_add,size: 30,),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                      child: Text('New Member Introduction'),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                      child: Text('',),
                    ),
                  ],
                ),
                const Divider(color: Colors.grey,),

                const SizedBox(height: 10,),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Icon(Icons.card_giftcard_sharp,size: 30,),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                      child: Text('Team Winning Award'),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(95, 0, 0, 0),
                      child: Text(''),
                    ),
                  ],
                ),
                const Divider(color: Colors.grey,),

                const SizedBox(height: 10,),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Icon(Icons.emoji_events,size: 30,),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                      child: Text('Activity Trip Award'),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(115, 0, 0, 0),
                      child: Text(''),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






