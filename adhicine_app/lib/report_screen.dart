import 'dart:developer';

import 'package:adhicine_app/add_medicine_screen.dart';
import 'package:adhicine_app/home_screen.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int index = 1;
  late FloatingBottomBarController _controller;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Today\'s Report',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildReportItem('5', 'Total'),
                _buildReportItem('3', 'Taken'),
                _buildReportItem('1', 'Missed'),
                _buildReportItem('1', 'Snoozed'),
              ],
            ),
            const SizedBox(height: 20),


            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Check Dashboard',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 220,
                        child: const Text(
                          'Here you will find everything related to your active and past medicines.',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Image.asset("assets/images/hollow_piechart.png")
                ],
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Check History',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildDayCircle('SUN', '1'),
                _buildDayCircle('MON', '2'),
                _buildDayCircle('TUE', '3'),
                _buildDayCircle('WED', '4'),
                _buildDayCircle('THU', '5'),
                _buildDayCircle('FRI', '6'),
              ],
            ),
            const SizedBox(height: 20),

            const Text('Morning 08:00 am',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
            _buildMedicineItem(
                'Calpol 500mg Tablet', 'Before Breakfast', 'Day 01', 'Taken'),
            _buildMedicineItem(
                'Calpol 500mg Tablet', 'Before Breakfast', 'Day 27', 'Missed'),
            const SizedBox(height: 20),

            const Text('Afternoon 02:00 pm',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
            _buildMedicineItem(
                'Calpol 500mg Tablet', 'After Food', 'Day 01', 'Snoozed'),
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

  Widget _buildReportItem(String value, String label) {
    return Column(
      children: <Widget>[
        Text(value,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 67, 118))),
        Text(label),
      ],
    );
  }

  Widget _buildDayCircle(String day, String date) {
    return Column(
      children: <Widget>[
        Text(day),
        CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          radius: 20,
          child: Text(date),
        ),
      ],
    );
  }

  Widget _buildMedicineItem(
      String name, String time, String day, String status) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            child: Icon(
              Icons.water_drop,
              color: Colors.white,
            ),
            backgroundColor:
                Colors.deepPurple.shade200, 
            radius: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(time),
              ],
            ),
          ),
          Column(
            children: [
              SvgPicture.asset(
                "assets/svg/bell.svg",
                color: (status == "Taken")
                    ? Colors.green
                    : (status == "Missed")
                        ? Colors.red
                        : Colors.amber,
              ),
              Text(status),
            ],
          ),
        ],
      ),
    );
  }
}
