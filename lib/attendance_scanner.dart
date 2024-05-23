import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'Non_exe_pages/non_exe_home.dart';
import 'home.dart';

class AttendanceScanner extends StatelessWidget {
  const AttendanceScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Attendance Scanner'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  NavigationBarNon(userType: '', userId: '',)));
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: PopScope(
          canPop: false,
          onPopInvoked: (didPop)  {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  NavigationBarNon(userType: '', userId: '',)));
          },
          child: const AttendanceScannerPage()),
    );
  }
}

class AttendanceScannerPage extends StatefulWidget {
  const AttendanceScannerPage({Key? key}) : super(key: key);

  @override
  State<AttendanceScannerPage> createState() => _AttendanceScannerPageState();
}

class _AttendanceScannerPageState extends State<AttendanceScannerPage> {
  final _formKey = GlobalKey<FormState>();
  String qrstr ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/hand.webp'),
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.4), BlendMode.dstATop),
            fit: BoxFit.fill,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: 350,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      color: Colors.white,
                      child: Column(
                        children: [
                          const SizedBox(height: 10,),
                          const Text(
                            'How Many Members Come With You?',
                            style: TextStyle(fontSize: 12, color: Colors.lightBlue),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              decoration: const InputDecoration.collapsed(
                                hintText: 'ex.0 or 1,2,3,etc...',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '* Please fill out this field';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const Divider(color: Colors.red),
                          const SizedBox(height: 20,),
                          OutlinedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                scanQr();
                              }
                            },
                            child: const Text('Scan'),
                          ),
                          const SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> scanQr() async {
    try {
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, ScanMode.QR).then((value) {
        setState(() async {
          qrstr = value;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Attend Your Meeting"),
          ));
        });
      });
    } catch (e) {
      setState(() {
        //qrstr = 'unable to read this';
      });
    }
  }
}
