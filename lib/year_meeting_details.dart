import 'package:flutter/material.dart';

class MeetingUpdateDate extends StatelessWidget {
  const MeetingUpdateDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MeetingUpdateDatePage(),
    );
  }
}
class MeetingUpdateDatePage extends StatefulWidget {
   MeetingUpdateDatePage({Key? key}) : super(key: key);

  @override
  State<MeetingUpdateDatePage> createState() => _MeetingUpdateDatePageState();
   int targetYear = DateTime.now().year;
}


class _MeetingUpdateDatePageState extends State<MeetingUpdateDatePage> {
  int targetYear = DateTime.now().year;
  var date = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Meeting Date Updates"),
          centerTitle: true,
        ),
        body: const Card(
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                contentPadding: EdgeInsets.all(12),
                title: Text("Time",),
                subtitle: Text("Place"),
                // Make sure you have a "Meeting Type" key
                // leading: Text(element["Meeting Type"]),
                trailing: Text("Meeting Name"),
              ),
            )
        )/*StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("Meeting").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                QuerySnapshot<Object?>? querySnapshot = streamSnapshot.data;
                List<QueryDocumentSnapshot> documents = querySnapshot!.docs;

                List<Map<String, dynamic>> form = documents
                    .where((doc) {
                  String dateString = doc['Meeting Date'];
                  DateTime meetingDate = DateTime.parse(dateString);
                  return meetingDate.year == targetYear;
                })
                    .map((e) => {
                  "Meeting Date": e['Meeting Date'],
                  "Meeting Name": e['Meeting Name'],
                  "Place": e['Place'],
                  "Time From": e['Time From'],
                  "Meeting Type": e['Meeting Type']
                  // "Meeting Month": e['Meeting Month'],
                })
                    .toList();

                return GroupedListView<dynamic, String>(

                    useStickyGroupSeparators: true,
                    elements: form,
                    groupBy: (element) => element['Meeting Date'],
                    groupSeparatorBuilder: (value) => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.green.shade900),
                      ),
                    ),
                    itemBuilder: (context, element)

                    {
                      DateTime meetingDate = DateTime.parse(element["Meeting Date"]);
                      bool isDateCompleted = meetingDate.isBefore(DateTime.now());

                      Color textColor = isDateCompleted ? Colors.grey : Colors.green;
                      return Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(12),
                            title: Text(element["Time From"],style: TextStyle(color: textColor),),
                            subtitle: Text(element["Place"],style: TextStyle(color: textColor)),
                            // Make sure you have a "Meeting Type" key
                           // leading: Text(element["Meeting Type"]),
                            trailing: Text(element["Meeting Name"],style: TextStyle(color: textColor)),
                          ),
                            )
                        );}
                );
              }return Container();
            }
        )*/
    );


  }
}

