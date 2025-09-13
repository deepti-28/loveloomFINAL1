import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String dob;
  final String? profileImageFilePath;

  const EditProfilePage({
    Key? key,
    required this.name,
    required this.dob,
    this.profileImageFilePath,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _locationController = TextEditingController();
  String? _locationError;
  String? _photoFilePath;
  bool _noPhoto = false;

  final Color pink = const Color(0xFFF45D6B);
  int _selectedNav = 2;

  @override
  void initState() {
    super.initState();
    _photoFilePath = widget.profileImageFilePath;
  }

  void _pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SizedBox(
        height: 180,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.photo, color: pink),
              title: Text('Gallery', style: TextStyle(color: pink)),
              onTap: () async {
                final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  setState(() {
                    _noPhoto = false;
                    _photoFilePath = picked.path;
                  });
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: pink),
              title: Text('Camera', style: TextStyle(color: pink)),
              onTap: () async {
                final picked = await ImagePicker().pickImage(source: ImageSource.camera);
                if (picked != null) {
                  setState(() {
                    _noPhoto = false;
                    _photoFilePath = picked.path;
                  });
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person_off, color: pink),
              title: Text('No Photo', style: TextStyle(color: pink)),
              onTap: () {
                setState(() {
                  _photoFilePath = null;
                  _noPhoto = true;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onNext() {
    setState(() {
      _locationError = _locationController.text.trim().isEmpty ? "Please enter your location" : null;
    });
    if (_locationError == null) {
      // Replace this with your navigation logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text('Next pressed! Complete your logic.'), backgroundColor: pink),
      );
    }
  }

  Widget _profileAvatar() {
    if (_noPhoto || (_photoFilePath == null && widget.profileImageFilePath == null)) {
      return CircleAvatar(
        radius: 54,
        backgroundColor: pink.withOpacity(0.19),
        child: Icon(Icons.person, color: pink, size: 56),
      );
    } else {
      return CircleAvatar(
        radius: 54,
        backgroundColor: pink,
        backgroundImage: _photoFilePath != null
            ? Image.file(
          File(_photoFilePath!),
          fit: BoxFit.cover,
        ).image
            : null,
      );
    }
  }

  BottomNavigationBarItem navIcon(IconData iconData, String label) => BottomNavigationBarItem(
    icon: Icon(iconData),
    label: '',
    tooltip: label,
  );

  void _onNavTap(int idx) {
    setState(() => _selectedNav = idx);
    // Add your navigation logic per index, for example:
    // if (idx == 0) Navigator.pushNamed(context, '/home');
    // if (idx == 1) Navigator.pushNamed(context, '/editprofile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          navIcon(Icons.home, 'Home'),
          navIcon(Icons.edit, 'Edit'),
          navIcon(Icons.add_circle_outline, 'Add'),
          navIcon(Icons.notifications_none, 'Notifications'),
          navIcon(Icons.person, 'Profile'),
        ],
        currentIndex: _selectedNav,
        onTap: _onNavTap,
        selectedItemColor: pink,
        unselectedItemColor: Colors.grey[400],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 12,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, color: pink),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 2),
              const Center(
                child: Text(
                  "Edit profile",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                ),
              ),
              const SizedBox(height: 14),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 118,
                      height: 118,
                      decoration: BoxDecoration(
                        color: pink.withOpacity(0.25),
                        shape: BoxShape.circle,
                        border: Border.all(color: pink, width: 4),
                      ),
                    ),
                    _profileAvatar(),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _pickImage,
                child: Text(
                  "Edit profile photo",
                  style: TextStyle(
                    color: pink,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.5,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Name",
                  style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.grey[800],
                      height: 1.1,
                      fontFamily: 'Nunito'),
                ),
              ),
              const SizedBox(height: 2),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.name,
                  style: const TextStyle(
                      fontSize: 17.5, fontWeight: FontWeight.bold, fontFamily: 'Nunito'),
                ),
              ),
              Divider(height: 34, thickness: 1.1),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Date of birth",
                  style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.grey[800],
                      height: 1.1,
                      fontFamily: 'Nunito'),
                ),
              ),
              const SizedBox(height: 2),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.dob,
                  style: const TextStyle(
                      fontSize: 17.5, fontWeight: FontWeight.bold, fontFamily: 'Nunito'),
                ),
              ),
              Divider(height: 34, thickness: 1.1),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Location",
                  style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.grey[800],
                      height: 1.1,
                      fontFamily: 'Nunito'),
                ),
              ),
              const SizedBox(height: 2),
              TextField(
                controller: _locationController,
                style: const TextStyle(
                    fontSize: 17.5, fontWeight: FontWeight.bold, fontFamily: 'Nunito'),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  errorText: _locationError,
                ),
              ),
              Divider(height: 30, thickness: 1.1),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    elevation: 6,
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
