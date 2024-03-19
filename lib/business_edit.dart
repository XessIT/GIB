import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gipapp/profile.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http;

class BusinessEditPage extends StatefulWidget {
  final String? currentbusinesstype;
  final String? currentcompanyname;
  final String? currentbusinesskeywords;
  // final String? currentservice;
  final String? currentmobile;
  final String? currentemail;
  final String? currentaddress;
  final String? currentwebsite;
  final String? currentybe;
  final String? id;
  final String? currentbusinessimage;
  const BusinessEditPage({super.key,
    required this.currentbusinesstype,
    required  this.currentcompanyname,
    // required this.currentservice,
    required this.currentbusinesskeywords,
    required   this.currentmobile,
    required   this.currentemail,
    required  this.currentaddress,
    required   this.currentwebsite,
    required  this.currentybe,
    required this.id,
    required this.currentbusinessimage,

  });

  @override
  State<BusinessEditPage> createState() => _BusinessEditPageState();
}

class _BusinessEditPageState extends State<BusinessEditPage> {
  static final RegExp nameRegExp = RegExp('[a-zA-Z]');
  final _formKey = GlobalKey<FormState>();




  @override
  void  initState() {
    companynamecontroller = TextEditingController(text: widget.currentcompanyname,);
    businesskeywordcontroller = TextEditingController(text: widget.currentbusinesskeywords,);
    mobilecontroller = TextEditingController(text: widget.currentmobile,);
    emailcontroller = TextEditingController(text: widget.currentemail,);
    addresscontroller = TextEditingController(text: widget.currentaddress,);
    websitecontroller = TextEditingController(text: widget.currentwebsite,);
    ybecontroller = TextEditingController(text: widget.currentybe,);
    businesstype = widget.currentbusinesstype!;
    // TODO: implement build
    super.initState();
  }

  String businesstype ="Business Type";
  TextEditingController companynamecontroller = TextEditingController();
  TextEditingController businesskeywordcontroller = TextEditingController();
  TextEditingController servicecontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController websitecontroller = TextEditingController();
  TextEditingController ybecontroller = TextEditingController();

  Future<void> Edit() async {
    try {
      final url = Uri.parse('http://localhost/GIB/lib/GIBAPI/business_edit.php');
      // final url = Uri.parse('http://192.168.29.129/API/offers.php');
      final response = await http.put(
        url,
        body: jsonEncode({
          "company_name": companynamecontroller.text,
          "mobile": mobilecontroller.text,
          "email": emailcontroller.text,
          "company_address": addresscontroller.text,
          "website": websitecontroller.text,
          "b_year": ybecontroller.text,
          "business_keywords": businesskeywordcontroller.text,
          "business_type": businesstype,
          "id": widget.id
        }),
      );
      print(url);
      print("ResponseStatus: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Offers response: ${response.body}");
        Navigator.push(context,
          MaterialPageRoute(builder: (context)=> Profile(userID: widget.id, userType: '',)),);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Profile Successfully Updated")));
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error during signup: $e");
      // Handle error as needed
    }
  }

  Future<File?> CropImage({required File imageFile}) async{
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path);
    if(croppedImage == null) return null;
    return File(croppedImage.path);
  }

  String image = "";
  bool showLocalImage = false;
  File? pickedimage;
  pickImageFromGallery() async {
    ImagePicker imagepicker = ImagePicker();
    XFile? file = await imagepicker.pickImage(source: ImageSource.gallery);
    showLocalImage = true;
    print('${file?.path}');
    pickedimage = File(file!.path);
    pickedimage = await CropImage(imageFile: pickedimage!);
    setState(() {

    });
    if(file == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

  }

  pickImageFromCamera() async {
    ImagePicker imagepicker = ImagePicker();
    XFile? file = await imagepicker.pickImage(source: ImageSource.camera);
    showLocalImage = true;
    print('${file?.path}');
    pickedimage = File(file!.path);
    pickedimage = await CropImage(imageFile: pickedimage!);
    setState(() {

    });
    if(file == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  }
  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child:
        Text('Business Edit Profile'),),
        centerTitle: true,
        iconTheme:  const IconThemeData(
          color: Colors.white, // Set the color for the drawer icon
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Text('Business Information',
                    style: Theme.of(context).textTheme.headline2,),
                  const SizedBox(width: 20,),
                  InkWell(
                    child: CircleAvatar(
                      backgroundImage: pickedimage == null ? NetworkImage(image!)
                          : Image.file(pickedimage!).image,
                      /* backgroundImage: imageUrl == " " ? const AssetImage('assets/images.png')
                        : Image.network(imageUrl) as ImageProvider,*/
                      /* backgroundImage: showLocalImage == false ? const AssetImage('assets/profile.jpg')
                        : FileImage(pickedimage!) as ImageProvider,*/
                      radius: 50,
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
                                //  pickImageFromDevice();
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                    },
                  ),

                  const SizedBox(height: 10,),
                  Container(
                    width: 320,
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                    child: DropdownButtonFormField<String>(
                      value: businesstype,
                      icon: const Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      items: <String>["Business Type", "Manufacturer", "Whole Sale", "Ditributor", "Service", "Retail"]
                          .map<DropdownMenuItem<String>>((String Value) {
                        return DropdownMenuItem<String>(
                            value: Value,
                            child: Text(Value));
                      }
                      ).toList(),
                      onChanged: (String? newValue){
                        setState(() {
                          businesstype = newValue!;
                        });
                      },
                      validator: (value) {
                        if (businesstype == 'Business Type') return 'Select Business Type';
                        return null;
                      },
                    ),
                  ),
                  // Company Address textfield starts
                  const SizedBox(height: 10,),

                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: companynamecontroller,
                      validator: (value){
                        if (value!.isEmpty) {
                          return '* Enter your Company Name/Occupation';
                        } else if(nameRegExp.hasMatch(value)){
                          return null;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        String capitalizedValue = capitalizeFirstLetter(value);
                        companynamecontroller.value = companynamecontroller.value.copyWith(
                          text: capitalizedValue,
                          selection: TextSelection.collapsed(offset: capitalizedValue.length),
                        );
                      },
                      decoration:  const InputDecoration(
                        labelText:'Company Name',
                        hintText: "Company Name",
                        suffixIcon: Icon(Icons.business,color: Colors.green,)
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(25),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: businesskeywordcontroller,
                      validator: (value){
                        if (value!.isEmpty) {
                          return '* Enter your business keyword';
                        } else if(nameRegExp.hasMatch(value)){
                          return null;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        String capitalizedValue = capitalizeFirstLetter(value);
                        businesskeywordcontroller.value = businesskeywordcontroller.value.copyWith(
                          text: capitalizedValue,
                          selection: TextSelection.collapsed(offset: capitalizedValue.length),
                        );
                      },
                      decoration: const InputDecoration(
                        labelText: "Business Keywords",
                        hintText: "Business Keywords",
                        suffixIcon: Icon(Icons.business,color: Colors.green,)
                        // hintText: '',
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: mobilecontroller,
                      validator: (value){
                        if (value!.isEmpty) {
                          return "* Enter your Mobile Number";
                        } else if (value.length < 10) {
                          return "* Mobile Number should be 10 digits";
                        }  else{
                          return null;}
                      },
                      decoration:  const InputDecoration(
                        labelText:'Mobile Number',
                        hintText: "Mobile Number",
                        suffixIcon: Icon(Icons.phone_android,color: Colors.green,)
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: emailcontroller,
                      validator: (value){
                        if (value!.isEmpty) {
                          return '* Enter your Email Address';
                        }  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                       return '* Enter a valid Email Address';
                        }
                        return null;
                      },
                      decoration:  const InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'Email Address',
                        suffixIcon: Icon(Icons.mail,color: Colors.green,),


                      ),),
                  ),
                  const SizedBox(height: 10,),

                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 5,
                      maxLength: 100,
                      controller: addresscontroller,
                      validator: (value){
                        if (value!.isEmpty) {
                          return '* Enter your Company Address';
                        } else if(nameRegExp.hasMatch(value)){
                          return null;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        String capitalizedValue = capitalizeFirstLetter(value);
                        addresscontroller.value = addresscontroller.value.copyWith(
                          text: capitalizedValue,
                          selection: TextSelection.collapsed(offset: capitalizedValue.length),
                        );
                      },
                      decoration: const InputDecoration(
                        labelText: 'Company address',
                        hintText: 'Company address',
                        suffixIcon: Icon(Icons.business,color: Colors.green,),
                      ),),
                  ),
                  const SizedBox(height: 10,),

                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: websitecontroller,
                      validator: (value){
                        if (value!.isEmpty) {
                          return '* Enter your Website';
                        } else if(nameRegExp.hasMatch(value)){
                          return null;
                        }else if (value.length<5) {
                          return '* Enter a valid Website';
                        }
                        return null;
                      },
                      decoration:  const InputDecoration(
                        labelText: 'Website',
                        hintText: 'Website',
                        suffixIcon: Icon(Icons.web,color: Colors.green,)
                      ),),
                  ),
                  const SizedBox(height: 10,),

                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: ybecontroller,
                      validator: (value){
                        if (value!.isEmpty) {
                          return '* Enter Year of business established';
                        } else if(nameRegExp.hasMatch(value)){
                          return null;
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Year of established',
                        hintText: "YYYY",
                        suffixIcon: Icon(Icons.calendar_month,color: Colors.green,),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Save button starts
                      MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)  ),
                          minWidth: 130,
                          height: 50,
                          color: Colors.green[800],
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Edit();
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "You have Successfully Updated")));
                          },
                          child: const Text('SAVE',
                            style: TextStyle(color: Colors.white),)),
                      // Save button ends

                      // Cancel button starts
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
                      // Cancel button ends
                    ],
                  ),
                  const SizedBox(height: 20,)
                ],
              )
          ),
        ),
      ),
    );
  }
}


