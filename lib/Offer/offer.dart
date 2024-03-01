import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../home.dart';
import 'offer_list.dart';

class OffersPage extends StatefulWidget {
  final String? userId;
  OffersPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {

  @override
  void initState() {
    getData();
    super.initState();
  }

  List<Map<String, dynamic>> data=[];
  Future<void> getData() async {
    print('Attempting to make HTTP request...');
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/offers.php?table=offers');
      print(url);
      final response = await http.get(url);
      print("ResponseStatus: ${response.statusCode}");
      print("Response: ${response.body}");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("ResponseData: $responseData");
        final List<dynamic> itemGroups = responseData;
        setState(() {});
        // data = itemGroups.cast<Map<String, dynamic>>();
        // Filter data based on user_id
        List<dynamic> filteredData = itemGroups.where((item) => item['user_id'] != widget.userId).toList();
        // Call setState() after updating data
        setState(() {
          // Cast the filtered data to the correct type
          data = filteredData.cast<Map<String, dynamic>>();
        });
        print('Data: $data');
      } else {
        print('Error: ${response.statusCode}');
      }
      print('HTTP request completed. Status code: ${response.statusCode}');
    } catch (e) {
      print('Error making HTTP request: $e');
      throw e; // rethrow the error if needed
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OFFERS',
            style: Theme.of(context).textTheme.bodySmall),
        centerTitle: true,
        leading:IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage(userType: '', userID: widget.userId,)));
            },
            icon: const Icon(Icons.arrow_back)),
        iconTheme:  const IconThemeData(
          color: Colors.white, // Set the color for the drawer icon
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,
              MaterialPageRoute(builder:
                  (context)=> OfferList(userId: widget.userId)),
            );
          },
              icon: const Icon(
                Icons.add_circle_outline_sharp,size:30,)),
        ],
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 3.0,
            mainAxisSpacing: 3.0,
          ),
          itemCount: data.length,
          itemBuilder: (context, i) {
            String dateString = data[i]['validity'];
            DateTime dateTime = DateFormat('yyyy-MM-dd').parse(dateString);
            // final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
            return SizedBox(
              height: 240,
              width: 180,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          launch(
                              "tel://'${data[i]['mobile']}'");
                        },
                        icon: Icon(
                          Icons.call_outlined,
                          color: Colors.green[900],)),),
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.cyan,
                    backgroundImage: Image.network('${data[i]['Image']}').image,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.green[900],
                              child: Text('${data[i]['discount']}%',
                                style: Theme.of(context).textTheme.titleLarge,)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Text('${data[i]['Company Name']}',
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold),),
                  const SizedBox(height: 15,),
                  Text('${data[i]['offer_type']} - ${data[i]['name']}',
                    style: const TextStyle(fontSize: 10,
                        fontWeight: FontWeight.bold),),
                  const SizedBox(width: 1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Validity -',
                        style: TextStyle(fontSize: 10,
                            fontWeight: FontWeight.bold),),
                      Text(DateFormat('dd-MM-yyyy').format(dateTime),
                        style: const TextStyle(fontSize: 10,
                            fontWeight: FontWeight.bold),),
                    ],
                  ),
                  // Text(DateFormat('dd/MM/yyyy').format(DateTime.now()))
                ],
              ),
            );
          }
      ),);
  }
}


