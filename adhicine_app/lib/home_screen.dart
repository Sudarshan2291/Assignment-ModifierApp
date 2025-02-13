import 'dart:developer';

import 'package:adhicine_app/add_medicine_screen.dart';
import 'package:adhicine_app/profile_screen.dart';
import 'package:adhicine_app/report_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicineScreen extends StatefulWidget {
  const MedicineScreen({super.key});

  @override
  State<MedicineScreen> createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  DateTime _selectedDate = DateTime.now();

  String _formatDate(DateTime date) {
    return DateFormat('EEEE, MMM d').format(date);
  }

  bool circleButtonToggle = false;
  List<Color> listOfColor = [
    const Color(0xFFF2B5BA),
    Colors.orange,
    Colors.amber,
    Colors.deepOrangeAccent
  ];
  int index = 0;
  late FloatingBottomBarController _controller;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _controller = FloatingBottomBarController(initialIndex: index);
  }

  void _onTabTapped(int newIndex) {
    if (index != newIndex) {
      setState(() {
        index = newIndex;
      });

      if (newIndex == 0) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MedicineScreen()),
        );
      } else if (newIndex == 1) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ReportScreen()),
        );
      }

      log('Tab Changed to Index: $newIndex');
    }
  }

  bool _isConnected = true;

  Future<void> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    _updateConnectionStatus(connectivityResult.isNotEmpty
        ? connectivityResult[0]
        : ConnectivityResult.none);

    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      _updateConnectionStatus(
          results.isNotEmpty ? results[0] : ConnectivityResult.none);
    });
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      _isConnected = result != ConnectivityResult.none;
      if (!_isConnected) {
        _showNoInternetDialog();
      }
    });
  }

  Future<void> _showNoInternetDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text(
            'Please check your internet connection and try again.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _checkConnectivity(); 
              },
              child: const Text('Retry'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        
        padding: const EdgeInsets.only(top: 60.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hi Harry!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "5 Medicines Left",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.medical_services_outlined,
                          color: Colors.blue),
                      onPressed: () {
                        
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SettingsScreen()));
                      },
                      child: CircleAvatar(
                        child: Image.network(
                            "https://www.pngitem.com/pimgs/m/272-2720656_user-profile-dummy-hd-png-download.png"),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("hr Fri"),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _selectedDate =
                                _selectedDate.subtract(const Duration(days: 1));
                          });
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.black),
                        ),
                        onPressed: () {},
                        child: Text(
                          _formatDate(_selectedDate),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _selectedDate =
                                _selectedDate.add(const Duration(days: 1));
                          });
                        },
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Sun Mo"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/homepage_image.png',
                      height: 200,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Nothing Is Here, Add a Medicine",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        barColor: Colors.white,
        controller: _controller,
        bottomBar: [
          BottomBarItem(
              dotColor: Colors.white,
              icon: const Icon(
                Icons.home,
                size: 30,
                color: Colors.grey,
              ),
              iconSelected: const Icon(Icons.home,
                  size: 30, color: Colors.deepPurpleAccent),
              title: "Home",
              onTap: (value) => _onTabTapped(value)),
          BottomBarItem(
              dotColor: Colors.white,
              icon: const Icon(
                Icons.graphic_eq,
                size: 30,
                color: Colors.grey,
              ),
              iconSelected: const Icon(Icons.graphic_eq,
                  size: 30, color: Colors.deepPurpleAccent),
              title: "Report",
              onTap: (value) => _onTabTapped(value)),
        ],
        bottomBarCenterModel: BottomBarCenterModel(
          centerBackgroundColor: Colors.black,
          centerIcon: const FloatingCenterButton(
            child: Icon(
              Icons.add,
              color: AppColors.white,
            ),
          ),
          centerIconChild: [
            FloatingCenterButtonChild(
              child: const Icon(
                Icons.add_outlined,
                color: AppColors.white,
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddMedicinesScreen())),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
