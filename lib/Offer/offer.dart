import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../home.dart';
import 'offer_list.dart';

class OffersPage extends StatefulWidget {
  final String? userId;
  final String? userType;
  OffersPage({Key? key, required this.userId, required  this.userType}) : super(key: key);

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
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/offers.php?table=UnblockOffers');
      print(url);
      final response = await http.get(url);
      print("ResponseStatus: ${response.statusCode}");
      print("Response: ${response.body}");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("ResponseData: $responseData");
        final List<dynamic> itemGroups = responseData;

        // Filter data based on validity date and user_id
        List<Map<String, dynamic>> filteredData = [];
        for (var item in itemGroups) {
          DateTime validityDate;
          try {
            validityDate = DateTime.parse(item['validity']);
          } catch (e) {
            print('Error parsing validity date: $e');
            continue; // Skip this item if validity date parsing fails
          }

          // Check if validity date has not passed and user_id is not the current user's id
          if (validityDate.isAfter(DateTime.now()) && item['user_id'] != widget.userId) {
            filteredData.add(item); // Add item to filteredData if it satisfies the filter
          }
        }

        setState(() {
          data = filteredData;
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
        title: Text('OFFERS123',
            style: Theme.of(context).textTheme.bodySmall),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage(userType: '', userID: widget.userId,)));
            },
            icon: const Icon(Icons.arrow_back)),
        iconTheme:  const IconThemeData(
          color: Colors.white, // Set the color for the drawer icon
        ),
        actions: [widget.userType == 'Executive' ?
          IconButton(onPressed: (){
            Navigator.push(context,
              MaterialPageRoute(builder:
                  (context)=> OfferList(userId: widget.userId)),
            );
          },
              icon: const Icon(
                Icons.add_circle_outline_sharp,size:30,)): Container(),
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
            String imageUrl = 'http://localhost/GIB/lib/GIBAPI/${data[i]['offer_image']}';
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
                    backgroundImage: NetworkImage(imageUrl),
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
                 const SizedBox(height: 5,),
                  Text('${data[i]['Company Name']}',
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold),),
                 // const SizedBox(height: 15,),
                  Text('${data[i]['offer_type']} - ${data[i]['name']}',
                    style: const TextStyle(fontSize: 10,
                        fontWeight: FontWeight.bold),),
                //  const SizedBox(height: 5,),
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


