import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class AddMedicinesScreen extends StatefulWidget {
  const AddMedicinesScreen({super.key});

  @override
  State<AddMedicinesScreen> createState() => _AddMedicinesScreenState();
}

class _AddMedicinesScreenState extends State<AddMedicinesScreen> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isStartDate ? _startDate : _endDate)) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String? _selectedTime;
  int _compartment = 1;
  String _type = 'Tablet';
  int _quantity = 1;
  bool _everyday = true;
  int _timesPerDay = 3;
  final List<Color> colors = const [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.amber,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.brown,
    Colors.grey,
    Colors.cyan,
  ];
  Widget _buildMealTimeButton(String time) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedTime = time;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedTime == time
            ? const Color.fromARGB(255, 103, 143, 244)
            : Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: Text(time),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Add Medicines'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Medicine Name',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: () {
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text('Compartment',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: List.generate(6, (index) {
                return ChoiceChip(
                  label: Text('${index + 1}'),
                  selected: _compartment == index + 1,
                  selectedColor: Colors.blueAccent[100],
                  showCheckmark: false,
                  onSelected: (selected) {
                    setState(() {
                      _compartment = index + 1;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 20),

            const Text('Colour', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal, 
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.all(8.0),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, 
                        color: colors[index],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            const SizedBox(height: 20),

            const Text('Type', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    ChoiceChip(
                      showCheckmark: false,
                      label: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/tablet.svg",
                            color: Colors.pink[100],
                            height: 40,
                            width: 40,
                          ),
                          const Text('Tablet'),
                        ],
                      ),
                      selected: _type == 'Tablet',
                      onSelected: (selected) {
                        setState(() {
                          _type = 'Tablet';
                        });
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ChoiceChip(
                      showCheckmark: false,
                      label: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/capsule.svg",
                            color: Colors.pink[100],
                            height: 40,
                            width: 40,
                          ),
                          const Text('Capsule'),
                        ],
                      ),
                      selected: _type == 'Capsule',
                      onSelected: (selected) {
                        setState(() {
                          _type = 'Capsule';
                        });
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ChoiceChip(
                      showCheckmark: false,
                      label: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/cream.svg",
                            color: Colors.pink[100],
                            height: 40,
                            width: 40,
                          ),
                          const Text('Cream'),
                        ],
                      ),
                      selected: _type == 'Cream',
                      onSelected: (selected) {
                        setState(() {
                          _type = 'Cream';
                        });
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ChoiceChip(
                      showCheckmark: false,
                      label: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/injection.svg",
                            color: Colors.pink[100],
                            height: 40,
                            width: 40,
                          ),
                          const Text('Injection'),
                        ],
                      ),
                      selected: _type == 'Injection',
                      onSelected: (selected) {
                        setState(() {
                          _type = 'Injection';
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Quantity',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 10),
                      child: Text('Take 1/2 Pill'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(border: Border.all(width: 0.5)),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (_quantity > 1) {
                              _quantity--;
                            }
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(border: Border.all(width: 0.5)),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text('Total Count',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Text('0$_quantity'),
                  ],
                ),
                const SizedBox(height: 20),
                Slider(
                  value: _quantity.toDouble(),
                  min: 1,
                  max: 100,
                  divisions: 99,
                  label: _quantity.toString(),
                  onChanged: (double value) {
                    setState(() {
                      _quantity = value.toInt();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Set Date',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(context, true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(DateFormat('yyyy-MM-dd')
                              .format(_startDate)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text('>'),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(context, false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(DateFormat('yyyy-MM-dd')
                              .format(_endDate)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                const Text('Frequency of Days',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: DropdownButton<bool>(
                    value: _everyday,
                    onChanged: (value) {
                      setState(() {
                        _everyday = value!;
                      });
                    },
                    items: const [
                      DropdownMenuItem<bool>(
                        value: true,
                        child: Text('Everyday'),
                      ),
                      DropdownMenuItem<bool>(
                        value: false,
                        child: Text('Specific Days'), 
                      ),
                    ],
                    isExpanded:
                        true,
                    underline: Container(), 
                  ),
                ),
                const SizedBox(height: 20),

                const Text('How many times a Day',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: DropdownButton<int>(
                    value: _timesPerDay,
                    onChanged: (value) {
                      setState(() {
                        _timesPerDay = value!;
                      });
                    },
                    items: const [
                      DropdownMenuItem<int>(
                        value: 1,
                        child: Text('Once a day'),
                      ),
                      DropdownMenuItem<int>(
                        value: 2,
                        child: Text('Twice a day'),
                      ),
                      DropdownMenuItem<int>(
                        value: 3,
                        child: Text('Three times a day'),
                      ),
                    ],
                    isExpanded: true,
                    underline: Container(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  border: BorderDirectional(
                      bottom: BorderSide(
                          color: const Color.fromARGB(255, 130, 127, 127)))),
              child: Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  const Text('Dose 1',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  border: BorderDirectional(
                      bottom: BorderSide(
                          color: const Color.fromARGB(255, 130, 127, 127)))),
              child: Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  const Text('Dose 2',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  border: BorderDirectional(
                      bottom: BorderSide(
                          color: const Color.fromARGB(255, 130, 127, 127)))),
              child: Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  const Text('Dose 3',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 10),

            const SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Select Meal Time',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _buildMealTimeButton('Before Food'),
                    _buildMealTimeButton('After Food'),
                    _buildMealTimeButton('Before Sleep'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            Center(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 140, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 94, 88, 212),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
