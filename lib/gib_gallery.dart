import 'package:flutter/material.dart';
import 'package:gipapp/video_player.dart';

import 'gib_gallery_view.dart';
import 'home.dart';
import 'home1.dart';

class GibGallery extends StatelessWidget {
  const GibGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // Appbar title
          title: const Center(child: Text('GiB Gallery')),
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
                  ViewImages(),
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

class ViewImages extends StatefulWidget {
  const ViewImages({Key? key}) : super(key: key);

  @override
  State<ViewImages> createState() => _ViewImagesState();
}

class _ViewImagesState extends State<ViewImages> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
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
                                  builder: (context) => ViewGibGalleryImage(thisitem['id'])));
                            },

                            child: SizedBox(
                                width: 95,
                                height: 95,
                                child: Image.network('${thisitem['Image']}', fit: BoxFit.cover,)),

                          ),
                          const SizedBox(height: 5,),
                          Text(thisitem['Event Name']),
                          IconButton(
                              onPressed: () {
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
                                            //  _delete(thisitem['id'], thisitem['Image']);
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) => const GibGallery()));
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
                              icon: const Icon(Icons.delete,color: Colors.red,)
                          )
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

  String? thumbfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
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
                            height: 100,
                            width: 100,
                            child: InkWell(
                              onTap: () {
                                playvideo(thisitem["Video"]);
                              },
                              child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  //  child: VideoPlayer(playvideo(thisitem["Video"]))),
                                  child: Image.network(thumbfile!)),
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Text(thisitem['Event Name']),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) =>
                                    // Dialog box for register meeting and add guest
                                    AlertDialog(
                                      backgroundColor: Colors.grey[800],
                                      title: const Text('Delete',
                                          style: TextStyle(
                                              color: Colors.white)),
                                      content: const Text(
                                          "Do you want to Delete the Video?",
                                          style: TextStyle(
                                              color: Colors.white)),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              //_delete(thisitem['id'],
                                                //  thisitem['Video']);
                                              Navigator.push(
                                                  context, MaterialPageRoute(
                                                  builder: (
                                                      context) => const GibGallery()));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "You have Successfully Deleted a Video")));
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
                              icon: const Icon(Icons.delete, color: Colors.red,)
                          )

                        ],
                      ),
                    );
                  }
              )

    );
  }
}