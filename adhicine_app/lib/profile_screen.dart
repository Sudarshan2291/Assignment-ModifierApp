import 'package:adhicine_app/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List listCareTakers = [
    {
      'image': Image.network(
        'https://www.kindpng.com/picc/m/252-2524695_dummy-profile-image-jpg-hd-png-download.png',
        fit: BoxFit.contain,
      ),
      'name': 'Dipa Luna'
    },
    {
      'image': Image.network(
          'https://www.kindpng.com/picc/m/252-2524695_dummy-profile-image-jpg-hd-png-download.png',
          fit: BoxFit.contain),
      'name': 'Dipa Luna'
    },
    {
      'image': Image.network(
          'https://www.kindpng.com/picc/m/252-2524695_dummy-profile-image-jpg-hd-png-download.png',
          fit: BoxFit.contain),
      'name': 'Dipa Luna'
    },
    {
      'image': Container(
        color: Colors.white,
        child: Icon(Icons.add),
      ),
      'name': 'Dipa Luna'
    }
  ];

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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: BorderDirectional(
                      bottom: BorderSide(color: Colors.grey))),
              child: Row(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            'https://www.kindpng.com/picc/m/252-2524695_dummy-profile-image-jpg-hd-png-download.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.blue)),
                          child: IconButton(
                            onPressed: () {
                            },
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 16,
                              color: Colors.blue,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ], 
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Take Care!",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text("Richa Bose",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text("Settings",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildSettingsItem(Icons.notifications, "Notification",
                "Check your medicine notification"),
            _buildSettingsItem(
                Icons.volume_up, "Sound", "Ring, Silent, Vibrate"),
            _buildSettingsItem(Icons.person, "Manage Your Account",
                "Password, Email ID, Phone Number"),
            _buildSettingsItem(Icons.notifications, "Notification",
                "Check your medicine notification"),
            _buildSettingsItem(Icons.notifications, "Notification",
                "Check your medicine notification"),

            const SizedBox(height: 20),

            const Text("Device", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 195, 212, 243),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  _buildSettingsItem(
                      Icons.volume_down, "Connect", "Bluetooth, Wi-fi"),
                  _buildSettingsItem(Icons.volume_down_alt, "Sound Option",
                      "Ring, Silent, Vibrate"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Caretakers: 03",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 195, 212, 243),
                  borderRadius: BorderRadius.circular(10)),

              height: 100, 
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listCareTakers
                    .length, 
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, right: 30),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child:
                              ClipOval(child: listCareTakers[index]['image']),
                        ),
                        index + 1 == listCareTakers.length
                            ? Text("Add")
                            : Text(listCareTakers[index]['name'])
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            const Text("Doctor", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blueAccent, shape: BoxShape.circle),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                      },
                    ),
                  ),
                  const Text("Add Your Doctor"),
                  const Text("Or use invite link",
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Privacy Policy",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text("Terms of Use",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text("Rate Us",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text("Share",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  await GoogleSignIn().signOut();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 140, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      "Log Out",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Text(subtitle, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
