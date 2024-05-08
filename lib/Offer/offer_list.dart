import 'dart:convert'; // for base64Encode
//import 'dart:typed_data'; // Import this for Uint8List
//import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'edit_offer.dart';
import 'package:http/http.dart' as http;

class OfferList extends StatelessWidget {
  final String? userId;
  const OfferList({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: OfferListPage(userId: userId),

    );
  }
}
class OfferListPage extends StatefulWidget {
  final String? userId;
  const OfferListPage({super.key, required this.userId});

  @override
  State<OfferListPage> createState() => _OfferListPageState();
}

class _OfferListPageState extends State<OfferListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        //APPBAR STARTS
        appBar: AppBar(
          title: Text('OFFERS',
              style: Theme.of(context).textTheme.bodySmall),
          centerTitle: true,
          iconTheme:  const IconThemeData(
            color: Colors.white, // Set the color for the drawer icon
          ),
        ),
        //END APPBAR
        body: Center(
          child: Column(
            children:  [
              const SizedBox(height: 15,),
              //TABBAR STARTS
              const TabBar(
                  isScrollable: true,
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.black,
                  tabs:[
                    Tab(text: 'New Offer',),
                    Tab(text: 'Running',),
                    Tab(text: 'Completed',),
                    Tab(text: 'Block')
                  ] ),
              //END TABBAR
              //START TABBAR VIEW
              const SizedBox(height: 10,),
              Expanded(
                child: TabBarView(children: [
                  AddOfferPage(userId: widget.userId,),
                  RunningPage(userId: widget.userId),
                  CompletedPage(userId: widget.userId),
                  BlockPage(userId: widget.userId),
                ]),
              ),
              //END TABBAR VIEW
            ],
          ),
        ),
      ),
    );
  }
}

class AddOfferPage extends StatefulWidget {
  final String? userId;
  const AddOfferPage({Key? key, required this.userId}) : super(key: key);


  @override
  State<AddOfferPage> createState() => _AddOfferPageState();
}

class _AddOfferPageState extends State<AddOfferPage> {
  XFile? pickedImage;
  final _formKey = GlobalKey<FormState>();
  DateTime date =DateTime.now();
  final TextEditingController _date = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController discountcontroller = TextEditingController();
  String? type;
  String? name = "";
  String? mobile = "";
  String? companyname = "";

  @override
  void initState() {
/*
    offers();
*/
    getData();
    // print("USER ID---${widget.userId}");
    // TODO: implement initState
    super.initState();
  }

  //get image from file code starts here

  String message = "";
  TextEditingController caption = TextEditingController();

  /*String? imagename;
  String? imagedata;*/
  /*Future<void> getImage() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.click();
    input.onChange.listen((e) {
      final html.File file = input.files!.first;
      final reader = html.FileReader();
      reader.onLoadEnd.listen((e) {
        setState(() {
          selectedImage = reader.result as Uint8List?;
          imagename = file.name;
          imagedata = base64Encode(selectedImage!);
          print('Image Name: $imagename');
          print('Image Data: $imagedata');
        });
      });
      reader.readAsArrayBuffer(file);
    });
  }*/

  bool showLocalImage = false;
  /* XFile? pickedImage; */
  late String imageName;
  late String imageData;
  Uint8List? selectedImage;
  Future<void> pickImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    showLocalImage = true;

    if (pickedImage != null) {
      // Verify that pickedImage is indeed an XFile
      print('pickedImage type: ${pickedImage.runtimeType}');

      // Read the image file as bytes
      try {
        final imageBytes = await pickedImage!.readAsBytes();

        // Verify that imageBytes contains the raw image data
        print('imageBytes length: ${imageBytes.length}');

        // Encode the bytes to base64
        String base64ImageData = base64Encode(imageBytes);

        setState(() {
          selectedImage = imageBytes;
          imageName = pickedImage!.name;
          print('Image Name: $imageName');
          imageData = base64ImageData;
          print('Base64 Image Data: $imageData');
        });
      } catch (e) {
        print('Error reading image file: $e');
      }
    }
  }
  pickImageFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    showLocalImage = true;
    if (pickedImage != null) {
      List<int> imageBytes = await pickedImage!.readAsBytes();
      setState(() {
        imageName = pickedImage!.name;
        //   print('Image Name: $imageName');
        imageData = base64Encode(imageBytes);
        //  print('Image Data: $imageData');
      });
    }
  }

  // ends here
  List<Map<String, dynamic>> data=[];
  Future<void> getData() async {
    print('Attempting to make HTTP request...');
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/offers.php?table=registration&id=${widget.userId}');
      //   print(url);
      final response = await http.get(url);
      // print("ResponseStatus: ${response.statusCode}");
      // print("Response: ${response.body}");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("ResponseData: $responseData");
        if (responseData is List) {
          // If responseData is a List (multiple records)
          final List<dynamic> itemGroups = responseData;
          setState(() {
            data = itemGroups.cast<Map<String, dynamic>>();
          });
          print('Data: $data');
        } else if (responseData is Map<String, dynamic>) {
          // If responseData is a Map (single record)
          setState(() {
            data = [responseData];
          });
          print('Data: $data');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
      print('HTTP request completed. Status code: ${response.statusCode}');
    } catch (e) {
      print('Error making HTTP request: $e');
      throw e; // rethrow the error if needed
    }
  }
  Future<void> offers(String datefetch) async {
    try {
      print("_date.text before check request: ${_date.text}");
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/offers.php');
      if (datefetch.isNotEmpty) {
        final DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(datefetch);
        final formattedDate = DateFormat('yyyy/MM/dd').format(parsedDate);
        final response = await http.post(
          url,
          body: jsonEncode({
            "imagename": imageName,
            "imagedata": imageData,
            "name": namecontroller.text,
            "discount": discountcontroller.text,
            "validity": formattedDate,
            "user_id": data[0]["id"],
            "offer_type": type,
            "first_name": data[0]["first_name"],
            "last_name": data[0]["last_name"],
            "mobile": data[0]["mobile"],
            "company_name": data[0]["company_name"],
            "block_status": "Unblock"
          }),
        );
        print(url);
        //  print("imagedata: $imagedata");
        print("imagename: $imageName");
        print("ResponseStatus: ${response.statusCode}");

        if (response.statusCode == 200) {
          print("Offers response: ${response.body}");

        } else {
          print("Error: ${response.statusCode}");
        }
      } else {
        print("date is empty");
        // Handle the case where _date.text is empty
        // You can display an error message or take any other appropriate action
      }
      // final url = Uri.parse('http://192.168.29.129/API/offers.php');

    } catch (e) {
      print("Error during signup: $e");
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children:  [
                const SizedBox(height: 20,),
                InkWell(
                  child: ClipOval(
                    child: selectedImage != null
                        ? Image.memory(
                      selectedImage!,
                    )
                        : Icon(Icons.person),
                  ),
                  onTap: () {
                    showModalBottomSheet(context: context, builder: (ctx){
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.camera_alt),
                            title: const Text("With Camera"),
                            onTap: () async {
                              pickImageFromCamera();
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.storage),
                            title: const Text("From Gallery"),
                            onTap: () {
                              pickImageFromGallery();
                              // getImage();
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
                  },
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      // title: const Text("Male"),
                      value: "Product",
                      groupValue: type,
                      onChanged: (value){
                        setState(() {
                          type = value.toString();
                        });
                      },
                    ),
                    const Text("Product"),
                    const SizedBox(width: 30,),
                    Radio(
                      // title: const Text("Female"),
                      value: "Service",
                      groupValue: type,
                      onChanged: (value){
                        setState(() {
                          type = value.toString();
                        });
                      },
                    ),
                    const Text("Service"),
                  ],
                ),
                const SizedBox(height: 20,width: 10,),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: namecontroller,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "*Enter the Name";
                      }else{
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Name:',
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                      controller: discountcontroller,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "*Enter the Discount";
                        }else{
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Discount %',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(2),
                      ]
                  ),
                ),
                SizedBox(
                  width:300,
                  child: TextFormField(
                      controller: _date,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "*Enter the Validity";
                        }else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Validity',
                        suffixIcon: IconButton(onPressed: ()async{
                          DateTime? pickDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          print("Picked date: $pickDate");
                          if(pickDate != null) {
                            setState(() {
                              _date.text = DateFormat('dd/MM/yyyy').format(pickDate);
                              print("_date.text updated: ${_date.text}");
                            });
                          }
                        }, icon: const Icon(
                            Icons.calendar_today_outlined),
                          color: Colors.green,),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ]
                  ),
                ),

                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Login button starts
                    MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)  ),
                        minWidth: 130,
                        height: 50,
                        color: Colors.green[800],
                        onPressed: (){
                          if(type == null){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Please Select the Type")));
                          }
                          /*else if(pickedImage == null){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Please Select the Image")));
                          }*/
                          else if (_formKey.currentState!.validate()) {
                            print("_date.text before sending request: ${_date.text}");
                            offers(_date.text);
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> OfferList(userId: widget.userId,)),);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Successfully Add a Offer")));
                          }
                        },
                        child: const Text('Register',
                          style: TextStyle(color: Colors.white),)),
                    // Login button ends

                    // Sign up button starts
                    MaterialButton(
                        minWidth: 130,
                        height: 50,
                        color: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)  ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel',
                          style: TextStyle(color: Colors.white),)),
                    // Sign up button ends
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RunningPage extends StatefulWidget {
  final String? userId;
  const RunningPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<RunningPage> createState() => _RunningPageState();
}

class _RunningPageState extends State<RunningPage> {
  Uint8List? _imageBytes;

  @override
  void initState() {
    getData();
    // _fetchImages();
    // TODO: implement initState
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
        // Filter data based on user_id and validity date
        List<dynamic> filteredData = itemGroups.where((item) {
          DateTime validityDate;
          try {
            validityDate = DateTime.parse(item['validity']);
          } catch (e) {
            print('Error parsing validity date: $e');
            return false;
          }
          print('Widget User ID: ${widget.userId}');
          print('Item User ID: ${item['user_id']}');
          print('Validity Date: $validityDate');
          print('Current Date: ${DateTime.now()}');
          bool satisfiesFilter = item['user_id'] == widget.userId && validityDate.isAfter(DateTime.now()) && item['block_status'] == "Unblock";
          print("Item block status: ${item['block_status']}");
          print('Satisfies Filter: $satisfiesFilter');
          return satisfiesFilter;
        }).toList();
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
  Future<Uint8List?> getImageBytes(String imageUrl) async {
    try {
      print('imageUrl: $imageUrl');
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print('Failed to load image. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error loading image: $e');
      return null;
    }
  }

  Future<void> delete(String ID) async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/offers.php?ID=$ID');
      final response = await http.delete(url);
      print("Delete Url: $url");
      if (response.statusCode == 200) {
        // Success handling, e.g., show a success message
        print("Delete Response: ${response.body}");
        Navigator.pop(context);
        print('ID: $ID');
        print('Offer Deleted successfully');
      }
      else {
        // Error handling, e.g., show an error message
        print('Error: ${response.statusCode}');
      }
    }
    catch (e) {
      // Handle network or server errors
      print('Error making HTTP request: $e');
    }
  }
  Future<void> blocked(int ID) async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/offers.php');
      final response = await http.put(
        url,
        body: jsonEncode({
          "ID": ID,
          "block_status": "Block"
        }),
      );
      if (response.statusCode == 200) {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const NewMemberApproval()));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully Rejected")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to Block")));
      }
    } catch (e) {
      print("Error during signup: $e");
      // Handle error as needed
    }
  }

  /// 6-5-24 FETCH IMAGE
  /*Future<void> _fetchImage() async {
    final url = 'http://localhost/GIB/lib/GIBAPI/image_fetch_offers.php?id=${widget.userId}';
    print('0000000000000000000000000000');
    print('gowtham: $url');
    print('0000000000000000000000000000');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        _imageBytes = response.bodyBytes;
      });
      print('1111111111111111111111');

      print('gowtham: $_imageBytes');
      print('111111111111111111111111111');

    } else {
      print('Failed to fetch image.');
    }
  }*/
  List<Uint8List> _imageBytesList = [];
  List<Map<String, dynamic>> _imageDataList = [];
  Future<void> _fetchImages() async {
    final url = 'http://localhost/GIB/lib/GIBAPI/image_fetch_offers.php?id=${widget.userId}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> imageData = jsonDecode(response.body);

      _imageBytesList.clear();
      _imageDataList.clear();

      for (var data in imageData) {
        final imageUrl =
            'http://localhost/GIB/lib/GIBAPI/${data['offer_image']}';
        final imageResponse = await http.get(Uri.parse(imageUrl));
        if (imageResponse.statusCode == 200) {
          Uint8List imageBytes = imageResponse.bodyBytes;
          setState(() {
            _imageBytesList.add(imageBytes);
            _imageDataList.add(data);
          });
        }
      }
    } else {
      print('Failed to fetch images.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: /*ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, i) {
            String imageUrl = 'http://localhost/GIB/lib/GIBAPI/${data[i]["offer_image"]}';
            return Center(
              child: Column(
                children: [
                  // Display image
                  Image.network(
                    imageUrl, // Assuming data[i]["offer_image"] contains the asset path
                    width: 40,
                    height: 40,
                  ),
                  // Your other UI elements
                ],
              ),
            );
          },
        )
    );*/
        ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              String imageUrl = 'http://localhost/GIB/lib/GIBAPI/${data[i]["offer_image"]}';
              String dateString = data[i]['validity']; // This will print the properly encoded URL
              DateTime dateTime = DateFormat('yyyy-MM-dd').parse(dateString);
              return Center(
                child: Column(
                  children: [
                    //MAIN ROW STARTS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:  [
                        Container(
                          width:40,
                          height: 40,
                          child: Image.network(
                            imageUrl, // Assuming data[i]["offer_image"] contains the asset path
                            width: 40,
                            height: 40,
                          ),
                        ),
                        /* //CIRCLEAVATAR STARTS
                         CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.cyan,
                           backgroundImage: Image.network(imageUrl),
                                  //IMAGE STARTS CIRCLEAVATAR
                                //  Image.network('${data[i]['offer_image']}').image,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                //STARTS CIRCLE AVATAR OFFER
                                child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.green[900],
                                    child: Text('${data[i]['discount']}%',
                                        style: Theme.of(context).textTheme.titleLarge)),
                              ),
                            ],
                          ),
                        ),
                        //END CIRCLEAVATAR*/

                        Column(
                          children: [
                            //START TEXTS
                            Text('${data[i]['company_name']}',
                              //Text style starts
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 15),),
                            const SizedBox(height: 10,),
                            //start texts
                            Text('${data[i]['offer_type']} - ${data[i]['name']}',
                              //Text style starts
                              style: const TextStyle(fontSize: 11,
                                  fontWeight: FontWeight.bold
                              ),),
                            //Text starts
                            Text(DateFormat('dd-MM-yyyy').format(dateTime)),
                          ],
                        ),
                        //IconButton starts

                        //IconButton starts
                        Row(
                          children: [
                            IconButton(onPressed: (){
                              showDialog(
                                  context: context,
                                  builder: (context)=>
                                      AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: const Text(
                                          "Confirmation!",
                                          style: TextStyle(color:Colors.black),
                                        ),
                                        content: const Text("Do you want to Block this Offer?",
                                          style: TextStyle(color: Colors.black),),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("Yes"),
                                            onPressed: (){
                                              blocked(int.parse(data[i]["ID"]));
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Your Offer Blocked Successfully")));
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> OfferList(userId: widget.userId)));
                                            }, ),
                                          TextButton(
                                              onPressed: (){
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("No"))
                                        ],
                                      )
                              );
                            },
                                icon: const Icon(Icons.block_sharp,
                                  color: Colors.red,)),
                            IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> EditOffer(
                                Id: data[i]['ID'],
                                // currentimage: thisitem['Image'],
                                currenttype: data[i]['offer_type'],
                                currentproductname: data[i]['name'],
                                currentDiscount: data[i]['discount'],
                                currentvalidity: data[i]['validity'],
                                user_id: data[i]['user_id'],
                              ))
                              );
                            },
                                icon: Icon(Icons.edit_outlined,
                                  color: Colors.green[900],)),

                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context)=>
                                          AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: const Text(
                                              "Confirmation!",
                                              style: TextStyle(color:Colors.black),
                                            ),
                                            content: const Text("Do you want to delete this offer?",
                                              style: TextStyle(color: Colors.black),),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text("Yes"),
                                                onPressed: (){
                                                  delete(data[i]['ID']);
                                                  // _delete(thisitem['id'], thisitem['Image']);
                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                      content: Text("You have Successfully Deleted a Offer Item")));
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> OfferList(userId: widget.userId)));
                                                },
                                              ),
                                              TextButton(
                                                  onPressed: (){
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("No"))
                                            ],
                                          )
                                  );

                                },
                                icon: Icon(Icons.delete,color: Colors.green[900],))
                          ],
                        ),
                      ],
                    ),
                    //Divider starts
                    const Divider(
                      color: Colors.grey,
                      thickness:1,
                      height: 30,
                    ),
                    // Text("Id: $id"),
                    // Text("Uid: ${thisitem["Uid"]}"),
                  ],
                ),
              );
            }
        ));

  }
}
class CompletedPage extends StatefulWidget {
  final String? userId;
  const CompletedPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {

  @override
  void initState() {
    getData();
    // TODO: implement initState
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
        // Filter data based on user_id and validity date
        List<dynamic> filteredData = itemGroups.where((item) {
          DateTime validityDate;
          try {
            validityDate = DateTime.parse(item['validity']);
          } catch (e) {
            print('Error parsing validity date: $e');
            return false;
          }
          bool satisfiesFilter = item['user_id'] == widget.userId && validityDate.isBefore(DateTime.now());
          print('Satisfies Filter: $satisfiesFilter');
          return satisfiesFilter;
        }).toList();
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
    return  Scaffold(
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              String dateString = data[i]['validity'];
              DateTime dateTime = DateFormat('yyyy-MM-dd').parse(dateString);
              return Center(
                child: Column(
                  children: [
                    //MAIN ROW STARTS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:  [
                        //CIRCLEAVATAR STARTS
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.cyan,
                          /*backgroundImage:
                          //IMAGE STARTS CIRCLEAVATAR
                          Image.network('${thisitem['Image']}').image,*/
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                //STARTS CIRCLE AVATAR OFFER
                                child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.green[900],
                                    child: Text('${data[i]['discount']}%',
                                        style: Theme.of(context).textTheme.titleLarge)),
                              ),
                            ],
                          ),
                        ),
                        //END CIRCLEAVATAR

                        Column(
                          children: [
                            //START TEXTS
                            /*Text('${data[i]['company_name']}',
                              //Text style starts
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 15),),*/
                            const SizedBox(height: 10,),
                            //start texts
                            Text('${data[i]['offer_type']} - ${data[i]['name']}',
                              //Text style starts
                              style: const TextStyle(fontSize: 11,
                                  fontWeight: FontWeight.bold
                              ),),
                            //Text starts
                            Text(DateFormat('dd-MM-yyyy').format(dateTime)),

                          ],
                        ),
                      ],
                    ),
                    //Divider starts
                    const Divider(
                      color: Colors.grey,
                      thickness:1,
                      height: 30,
                    ),
                  ],
                ),
              );
            }
        )
    );
  }
}

class BlockPage extends StatefulWidget {
  final String? userId;
  const BlockPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<BlockPage> createState() => _BlockPageState();
}

class _BlockPageState extends State<BlockPage> {

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
        // Filter data based on user_id and validity date
        List<dynamic> filteredData = itemGroups.where((item) {
          DateTime validityDate;
          try {
            validityDate = DateTime.parse(item['validity']);
          } catch (e) {
            print('Error parsing validity date: $e');
            return false;
          }
          print('Widget User ID: ${widget.userId}');
          print('Item User ID: ${item['user_id']}');
          print('Validity Date: $validityDate');
          print('Current Date: ${DateTime.now()}');
          bool satisfiesFilter = item['user_id'] == widget.userId && validityDate.isAfter(DateTime.now()) && item['block_status'] == "Block";
          print('Satisfies Filter: $satisfiesFilter');
          return satisfiesFilter;
        }).toList();
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
  Future<void> unblock(int ID) async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/offers.php');
      final response = await http.put(
        url,
        body: jsonEncode({
          "ID": ID,
          "block_status": "Unblock"
        }),
      );
      if (response.statusCode == 200) {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const NewMemberApproval()));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully UnBlock")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to Unblock")));
      }
    } catch (e) {
      print("Error during Unblock: $e");
      // Handle error as needed
    }
  }
  Future<void> delete(String ID) async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/offers.php?ID=$ID');
      final response = await http.delete(url);
      print("Delete Url: $url");
      if (response.statusCode == 200) {
        // Success handling, e.g., show a success message
        print("Delete Response: ${response.body}");
        print('ID: $ID');
        print('Offer Deleted successfully');
      }
      else {
        // Error handling, e.g., show an error message
        print('Error: ${response.statusCode}');
      }
    }
    catch (e) {
      // Handle network or server errors
      print('Error making HTTP request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              String dateString = data[i]['validity'];
              DateTime dateTime = DateFormat('yyyy-MM-dd').parse(dateString);
              return Center(
                child: Column(
                  children: [
                    //MAIN ROW STARTS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:  [
                        //CIRCLEAVATAR STARTS
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.cyan,
                          /* backgroundImage:
                                  //IMAGE STARTS CIRCLEAVATAR
                                  Image.network('${data[i]['Image']}').image,*/
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                //STARTS CIRCLE AVATAR OFFER
                                child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.green[900],
                                    child: Text('${data[i]['discount']}%',
                                        style: Theme.of(context).textTheme.titleLarge)),
                              ),
                            ],
                          ),
                        ),
                        //END CIRCLEAVATAR

                        Column(
                          children: [
                            //START TEXTS
                            /* Text('${data[i]['company_name']}',
                              //Text style starts
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 15),),*/
                            const SizedBox(height: 10,),
                            //start texts
                            Text('${data[i]['offer_type']} - ${data[i]['name']}',
                              //Text style starts
                              style: const TextStyle(fontSize: 11,
                                  fontWeight: FontWeight.bold
                              ),),
                            //Text starts
                            Text(DateFormat('dd-MM-yyyy').format(dateTime)),
                          ],
                        ),
                        //IconButton starts

                        //IconButton starts
                        Row(
                          children: [
                            IconButton(onPressed: (){
                              showDialog(
                                  context: context,
                                  builder: (context)=>
                                      AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: const Text(
                                          "Confirmation!",
                                          style: TextStyle(color:Colors.black),
                                        ),
                                        content: const Text("Do you want to Unblock this offer?",
                                          style: TextStyle(color: Colors.black),),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("Yes"),
                                            onPressed: (){
                                              unblock(int.parse(data[i]["ID"]));
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> EditOffer(
                                                Id: data[i]['ID'],
                                                // currentimage: thisitem['Image'],
                                                currenttype: data[i]['offer_type'],
                                                currentproductname: data[i]['name'],
                                                currentDiscount: data[i]['discount'],
                                                currentvalidity: data[i]['validity'],
                                                user_id: data[i]['user_id'],
                                              ))
                                              );
                                              // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Your offer Unblocked Successfully")));
                                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> OfferList(userId: widget.userId,)));
                                            }, ),
                                          TextButton(
                                              onPressed: (){
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("No"))
                                        ],
                                      )
                              );
                            },
                                icon: Icon(Icons.check_circle,
                                  color: Colors.green[900],)),

                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context)=>
                                          AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: const Text(
                                              "Confirmation!",
                                              style: TextStyle(color:Colors.black),
                                            ),
                                            content: const Text("Do you want to Delete this Offer?",
                                              style: TextStyle(color: Colors.black),),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text("Yes"),
                                                onPressed: (){
                                                  delete(data[i]['ID']);
                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                      content: Text("You have Successfully Deleted a Offer Item")));
                                                  //  Navigator.of(context).pop();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              TextButton(
                                                  onPressed: (){
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("No"))
                                            ],
                                          )
                                  );

                                },
                                icon: Icon(Icons.delete,color: Colors.green[900],))
                          ],
                        ),
                      ],
                    ),
                    //Divider starts
                    const Divider(
                      color: Colors.grey,
                      thickness:1,
                      height: 30,
                    ),
                    // Text("Id: $id"),
                    // Text("Uid: ${thisitem["Uid"]}"),
                  ],
                ),
              );
            }
        ));

  }
}
