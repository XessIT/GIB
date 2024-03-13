import 'package:flutter/material.dart';
import 'package:gipapp/sample_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Non_exe_pages/non_exe_home.dart';
import 'guest_home.dart';
import 'home.dart';
import 'login.dart';

void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.green[900]
          ),

          textTheme: TextTheme(
              displayLarge: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.green[900]),
              displayMedium: TextStyle(fontSize: 20.0,color: Colors.green[900]),
              displaySmall: const TextStyle(fontSize: 20.0,color: Colors.yellow),
              headlineMedium: const TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black),
              headlineSmall: TextStyle(fontSize: 16.0,color: Colors.green[900],fontWeight: FontWeight.bold),
              titleLarge: const TextStyle(fontSize: 16, color: Colors.white),
              bodyLarge: const TextStyle(fontSize: 18.0),
              bodyMedium: const TextStyle(fontSize: 16),
              headlineLarge:  TextStyle(fontSize: 16.0,color: Colors.blue[900],fontWeight: FontWeight.bold),
              titleSmall: const TextStyle( fontSize: 13.5,color: Colors.white70,fontWeight: FontWeight.w200),
              bodySmall: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)
           //   subtitle1:   TextStyle( fontSize: 20, color: Colors.black, ),
          //    labelSmall: const TextStyle(fontSize: 16, color: Colors.white),


          ),

          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                 // primary: Colors.white,
                  backgroundColor: Colors.green[800],
                  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 50),
                  textStyle: const TextStyle(
                      fontSize: 15))),
        ),

        home: FutureBuilder<Map<String, dynamic>>(
          future: isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Extract isLoggedIn, userType, and firstName from snapshot.data
              bool isLoggedIn = snapshot.data?['isLoggedIn'] ?? false;
              String? userType = snapshot.data?['userType'];
              String? firstName = snapshot.data?['firstName'];
              String? district = snapshot.data?['district'];
              String? chapter = snapshot.data?['chapter'];
              String? native = snapshot.data?['native'];
              String? DOB = snapshot.data?['DOB'];
              String? Koottam = snapshot.data?['Koottam'];
              String? Kovil = snapshot.data?['Kovil'];
              String? BloodGroup = snapshot.data?['BloodGroup'];
              String? lastName = snapshot.data?['lastName'];
              String? spouse_name = snapshot.data?['s_name'];
              String? spouse_blood = snapshot.data?['s_blood'];
              String? Wad = snapshot.data?['WAD'];
              String? place = snapshot.data?['place'];
              String? skoottam = snapshot.data?['s_father_koottam'];
              String? skovil = snapshot.data?['s_father_kovil'];
              String? pexe = snapshot.data?['past_experience'];
              String? edu = snapshot.data?['education'];
              String? email = snapshot.data?['email'];
              String? rid = snapshot.data?['referrer_id'];
              String? website = snapshot.data?['website'];
              String? byear = snapshot.data?['b_year'];
              String? mobile = snapshot.data?['mobile'];
              String? image = snapshot.data?['profile_image'];
              String? id = snapshot.data?['id'];

              if (isLoggedIn) {
                switch (userType) {
                  case "Executive":
                    return Homepage(
                      userType: userType ,
                      userID: id,
                    );
                  case "Non-Executive":
                    return NonExecutiveHome(
                      userType: userType ,
                      userID: id,
                    ); // Pass firstName to Homepage
                //   return NonExecutiveHome();
                  case "Guest":
                    return GuestHomePage(
                      userType: userType ,
                      userId: id,
                    );
                  default:
                  // Handle unexpected user types
                    return Text('Unknown user type: $userType');
                }
              } else {
                return const Login();
              }
            }
          },
        ),


        ///
///

/*
        home: FutureBuilder<bool>(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data! ? Homepage() : Login();
          } else {
            return CircularProgressIndicator();
          }
        },

      ),
*/

      ));
}
Future<Map<String, dynamic>> isLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  String? userType = prefs.getString('userType');
  String? firstName = prefs.getString('firstName'); // Retrieve first name
  String? district = prefs.getString('district');
  String? lastName = prefs.getString('lastName');
  String? chapter = prefs.getString('chapter');
  String? native = prefs.getString('native');
  String? DOB = prefs.getString('DOB');
  String? Koottam = prefs.getString('Koottam');
  String? Kovil = prefs.getString('Kovil');
  String? BloodGroup = prefs.getString('BloodGroup');
  String? s_koottam = prefs.getString('s_father_koottam');
  String? s_kovil = prefs.getString('s_father_kovil');
  String? pexe = prefs.getString('past_experience');
  String? website = prefs.getString('website');
  String? byear = prefs.getString('b_year');
  String? rid = prefs.getString('referrer_id');
  String? edu = prefs.getString('education');
  String? mobile = prefs.getString('mobile');
  String? email = prefs.getString('email');
  String? place = prefs.getString('place');
  String? s_blood = prefs.getString('s_blood');
  String? s_name = prefs.getString('s_name');
  String? WAD = prefs.getString('WAD');
  String? image = prefs.getString('profile_image');
  String? id = prefs.getString('id');
  return {
    'isLoggedIn': isLoggedIn,
    'userType': userType,
    'firstName': firstName ,
    'lastName': lastName ,
    'district':district,
    'chapter':chapter,
    'native':native,
    'DOB':DOB,
    'Koottam':Koottam,
    'Kovil':Kovil,
    'BloodGroup':BloodGroup,
    's_father_koottam':s_koottam,
    's_father_kovil':s_kovil,
    'past_experience':pexe,
    'website':website,
    'b_year':byear,
    'referrer_id':rid,
    'education':edu,
    'mobile':mobile,
    'email':email,
    'place':place,
    's_name':s_name,
    's_blood':s_blood,
    "WAD":WAD,
    "id":id
  };
}


/*
Future<bool> isLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;

}
*/





