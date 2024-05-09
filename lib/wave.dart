// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:wave/config.dart';
// import 'package:wave/wave.dart';
//
// void main() => runApp(WaveDemoApp());
//
// final String appName = 'Demo WAVE';
// final String repoURL = 'https://github.com/glorylab/wave';
//
// class WaveDemoApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: appName,
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         useMaterial3: true,
//       ),
//       home: WaveDemoHomePage(title: appName),
//     );
//   }
// }
//
// class WaveDemoHomePage extends StatefulWidget {
//   WaveDemoHomePage({Key? key, this.title}) : super(key: key);
//
//   final String? title;
//
//   @override
//   _WaveDemoHomePageState createState() => _WaveDemoHomePageState();
// }
//
// class _WaveDemoHomePageState extends State<WaveDemoHomePage> {
//   _buildCard({
//     required Config config,
//     Color? backgroundColor = Colors.transparent,
//     DecorationImage? backgroundImage,
//     double height = 152.0,
//   }) {
//     return Container(
//       height: height,
//       width: double.infinity,
//       child: Card(
//         elevation: 12.0,
//         margin: EdgeInsets.only(
//             right: marginHorizontal, left: marginHorizontal, bottom: 16.0),
//         clipBehavior: Clip.antiAlias,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(16.0))),
//         child: WaveWidget(
//           config: config,
//           backgroundColor: backgroundColor,
//           backgroundImage: backgroundImage,
//           size: Size(double.infinity, double.infinity),
//           waveAmplitude: 0,
//         ),
//       ),
//     );
//   }
//
//   double marginHorizontal = 16.0;
//
//   void _launchUrl(url) async {
//     if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     marginHorizontal = 16.0 +
//         (MediaQuery.of(context).size.width > 512
//             ? (MediaQuery.of(context).size.width - 512) / 2
//             : 0);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title!),
//         elevation: 2.0,
//         actions: [
//           IconButton(
//             onPressed: () {
//               _launchUrl(repoURL);
//             },
//             icon: Image.asset(
//               'icons/ic_github.png',
//               package: 'web3_icons',
//               width: 32.0,
//               height: 32.0,
//             ),
//           )
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView(
//               children: <Widget>[
//                 SizedBox(height: 16.0),
//                 _buildCard(
//                   backgroundColor: Colors.purpleAccent,
//                   config: CustomConfig(
//                     gradients: [
//                       [Colors.red, Color(0xEEF44336)],
//                       [Colors.red[800]!, Color(0x77E57373)],
//                       [Colors.orange, Color(0x66FF9800)],
//                       [Colors.yellow, Color(0x55FFEB3B)]
//                     ],
//                     durations: [35000, 19440, 10800, 6000],
//                     heightPercentages: [0.20, 0.23, 0.25, 0.30],
//                     gradientBegin: Alignment.bottomLeft,
//                     gradientEnd: Alignment.topRight,
//                   ),
//                 ),
//                 _buildCard(
//                   height: 256.0,
//                   backgroundImage: DecorationImage(
//                     image: NetworkImage(
//                       'https://images.unsplash.com/photo-1554779147-a2a22d816042?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3540',
//                     ),
//                     fit: BoxFit.cover,
//                     colorFilter:
//                     ColorFilter.mode(Colors.white, BlendMode.softLight),
//                   ),
//                   config: CustomConfig(
//                     colors: [
//                       Colors.pink[400]!,
//                       Colors.pink[300]!,
//                       Colors.pink[200]!,
//                       Colors.pink[100]!
//                     ],
//                     durations: [18000, 8000, 5000, 12000],
//                     heightPercentages: [0.85, 0.86, 0.88, 0.90],
//                   ),
//                 ),
//                 _buildCard(
//                     config: CustomConfig(
//                       colors: [
//                         Colors.white70,
//                         Colors.white54,
//                         Colors.white30,
//                         Colors.white24,
//                       ],
//                       durations: [32000, 21000, 18000, 5000],
//                       heightPercentages: [0.25, 0.26, 0.28, 0.31],
//                     ),
//                     backgroundColor: Colors.blue[600]),
//                 Align(
//                   child: Container(
//                     height: 128,
//                     width: 128,
//                     decoration:
//                     BoxDecoration(shape: BoxShape.circle, boxShadow: [
//                       BoxShadow(
//                         color: Color(0xFF9B5DE5),
//                         blurRadius: 2.0,
//                         spreadRadius: -5.0,
//                         offset: Offset(0.0, 8.0),
//                       ),
//                     ]),
//                     child: ClipOval(
//                       child: WaveWidget(
//                         config: CustomConfig(
//                           colors: [
//                             Color(0xFFFEE440),
//                             Color(0xFF00BBF9),
//                           ],
//                           durations: [
//                             5000,
//                             4000,
//                           ],
//                           heightPercentages: [
//                             0.65,
//                             0.66,
//                           ],
//                         ),
//                         backgroundColor: Color(0xFFF15BB5),
//                         size: Size(double.infinity, double.infinity),
//                         waveAmplitude: 0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 88,
//                 ),
//                 Container(
//                     alignment: Alignment.center,
//                     margin: const EdgeInsets.all(16),
//                     child: Column(
//                       children: [
//                         Image.asset(
//                           'icons/ic_glory_lab.png',
//                           package: 'web3_icons',
//                           width: 32.0,
//                           height: 32.0,
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Made in Glory Lab',
//                           style: GoogleFonts.robotoMono(
//                             color: Colors.grey[500],
//                           ),
//                         )
//                       ],
//                     )),
//                 Container(
//                   height: 48,
//                   child: WaveWidget(
//                     config: CustomConfig(
//                       colors: [
//                         Colors.indigo[400]!,
//                         Colors.indigo[300]!,
//                         Colors.indigo[200]!,
//                         Colors.indigo[100]!
//                       ],
//                       durations: [18000, 8000, 5000, 12000],
//                       heightPercentages: [0.65, 0.66, 0.68, 0.70],
//                     ),
//                     size: Size(double.infinity, double.infinity),
//                     waveAmplitude: 0,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';



enum _SelectedTab { home, favorite, add, search, person }


class bootomnav extends StatefulWidget {
  const bootomnav({super.key});

  @override
  State<bootomnav> createState() => _bootomnavState();
}

class _bootomnavState extends State<bootomnav> {
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Image.network(
          "https://images.pexels.com/photos/1671325/pexels-photo-1671325.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
          fit: BoxFit.fitHeight,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CrystalNavigationBar(
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          height: 10,
          // indicatorColor: Colors.blue,
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.black.withOpacity(0.1),
          onTap: _handleIndexChanged,
          items: [
            /// Home
            CrystalNavigationBarItem(
              icon: IconlyBold.home,
              unselectedIcon: IconlyLight.home,
              selectedColor: Colors.white,
            ),

            /// Favourite
            CrystalNavigationBarItem(
              icon: IconlyBold.heart,
              unselectedIcon: IconlyLight.heart,
              selectedColor: Colors.red,
            ),

            /// Add
            CrystalNavigationBarItem(
              icon: IconlyBold.plus,
              unselectedIcon: IconlyLight.plus,
              selectedColor: Colors.white,
            ),

            /// Search
            CrystalNavigationBarItem(
                icon: IconlyBold.search,
                unselectedIcon: IconlyLight.search,
                selectedColor: Colors.white),

            /// Profile
            CrystalNavigationBarItem(
              icon: IconlyBold.user_2,
              unselectedIcon: IconlyLight.user,
              selectedColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}