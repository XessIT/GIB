import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gipapp/video_player.dart';
import 'package:gipapp/view_gallery_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


import 'home.dart';
import 'home1.dart';

class MyGallery extends StatelessWidget {
  const MyGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // Appbar title
          title: const Center(child: Text('My Gallery')),
          centerTitle: true,
          leading:IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  Home(userType: '', userId: '',)));
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Column(
          children:  const [
            TabBar(
                isScrollable: true,
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: 'Image',),
                  Tab(text: 'Video',),
                ]),
            Expanded(
              child: TabBarView(
                children: [
                  Gallery(),
                  Video(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  DateTime date = DateTime.now();


  String? image = "";
  String? docId = "";



  Future<File?> CropImage({required File imageFile}) async{
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path);
    if(croppedImage == null) return null;
    return File(croppedImage.path);
  }
  List<String> multiImages=[];
  String imageUrl = "";
  bool showLocalImage = false;

  File? pickedimage;


 Future pickImageFromGallery() async {

  }

  Future<List<XFile>> multiImagePicker() async {
    List<XFile>? _images = await ImagePicker().pickMultiImage(imageQuality: 50);
    if(_images != null && _images.isNotEmpty){
      return _images;
    }
    return [];
  }
  Future<List<String>> multiImageUploader(List<XFile> list) async {
    List<String> _path = [];
    for(XFile _image in list) {
     // _path.add(await uploadImage(_image));
    }
    return _path;
  }

  // Return Image Name
  String getImageName(XFile image) {
    return image.path.split("/").last;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            showModalBottomSheet(context: context, builder: (ctx){
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text("With Camera"),
                    onTap: () async {
                      pickImageFromCamera();
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  const MyGallery()));
                      // Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.storage),
                    title: const Text("From Gallery"),
                    onTap: () async {
                     // multiImagePicker();
                      List<XFile>? _images = await multiImagePicker();
                      if (_images.isNotEmpty) {
                        multiImages = await multiImageUploader(_images);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyGallery()));
                    } )
                ],
              );

            });
          },
          child: const Icon(Icons.add),
        ),

        body: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                     // String docID = streamSnapshot.data!.docs[index].id;
                      Map thisitem = [index] as Map;
                      return Column(
                        children: [
                          const SizedBox(height: 30,),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ViewGalleryImage(thisitem['id'])));
                            },
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) =>
                                  // Dialog box for register meeting and add guest
                                  AlertDialog(
                                    backgroundColor: Colors.grey[800],
                                    title: const Text('Delete',
                                        style: TextStyle(color: Colors.white)),
                                    content: const Text("Do you want to Delete the Image?",
                                        style: TextStyle(color: Colors.white)),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                           // _delete(thisitem['id'], thisitem['Images']);
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => const Gallery()));
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                content: Text("You have Successfully Deleted a Image")));
                                          },
                                          child: const Text('Yes')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No'))
                                    ],
                                  )
                              );
                            },
                            child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.network('${thisitem['Images']}', fit: BoxFit.cover,)),

                          ),
                          // Text(urlDownload),
                        ],
                      );
                    }
                )
    );
  }
}

class Video extends StatefulWidget {
  const Video({Key? key}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {

  playvideo(String vurl) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => VideoApp(url: vurl)));
  }

  FilePickerResult? result;
  File? pickedfile;
  String urlDownload = "";
  String? thumbfile;

  String videoimage = "https://firebasestorage.googleapis.com/v0/b/giberode-9eaf1.appspot.com/o/gallery%2FIcon-video-play-green.png?alt=media&token=e556fbaa-bdcc-4b7f-9a1b-dcd8151e30db";

  String videoUrl="";
  bool showLocalVideo= false;
  File? pickedvideo;

  Future Camera()async{
    final ImagePicker _picker = ImagePicker();
    final XFile? file = await _picker.pickVideo(source: ImageSource.camera,maxDuration: const Duration(seconds: 30));
    showLocalVideo = true;
    print('${file?.path}');
    pickedvideo = File(file!.path);
    //pickedimage = await CropImage(imageFile: pickedimage!);
    setState(() {

    });
    if(file == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          showModalBottomSheet(context: context, builder: (ctx) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("With Camera"),
                  onTap: () async {
                    Camera();
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (
                            context) => const MyGallery()));
                    // Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.storage),
                  title: const Text("From Gallery"),
                  onTap: () {
                    selectFile();
                    // pickImageFromGallery();
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (
                            context) => const MyGallery()));
                    // Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
        },
        child: const Icon(Icons.add),
      ),
      body: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                   // String docID = streamSnapshot.data!.docs[index].id;
                    Map thisitem = [index] as Map;
                    thumbfile = thisitem["Video Image"];
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                          //  child:Image.network('${thisitem['Video Image']}', fit: BoxFit.cover,)),
                            child: InkWell(
                              onTap: () {
                                playvideo(thisitem["Video"]);
                              },
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) =>
                                    // Dialog box for register meeting and add guest
                                    AlertDialog(
                                      backgroundColor: Colors.grey[800],
                                      title: const Text('Delete',
                                          style: TextStyle(color: Colors.white)),
                                      content: const Text("Do you want to Delete the Video?",
                                          style: TextStyle(color: Colors.white)),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                            //  _delete(thisitem['id'], thisitem['Video'],thisitem['Video Image']);
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) => const Video()));
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  content: Text("You have Successfully Deleted a Video")));
                                            },
                                            child: const Text('Yes')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('No'))
                                      ],
                                    )
                                );
                              },

                              child: SizedBox(
                                  height: 100,
                                  width: 100,
                               //  child: VideoPlayer(playvideo(thisitem["Video"]))),
                                  child: Image.network(thumbfile!)),
                               // child: Image.file(thisitem["Video"]),),
                            // child: Image.file(File(thumbfile!))),
                            ),
                          )
                        ],
                      ),
                    );
                  }
              )

    );
  }


  Future selectFile() async{

    result = await FilePicker.platform.pickFiles();


    setState(() {
      //pickedfile = result.files.first;
    });
    //final path = 'gibachievements/${pickedfile!.name}';
    // final file = File(pickedfile!.path!);
    print('${result?.paths}');
    pickedfile =File(result!.files.first.path!) ;
    if(result == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
   // String uniquename = DateTime.now().microsecond.toString();

  }
}



