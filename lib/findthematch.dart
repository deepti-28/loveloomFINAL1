import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindTheMatchPage extends StatefulWidget {
  const FindTheMatchPage({Key? key}) : super(key: key);

  @override
  State<FindTheMatchPage> createState() => _FindTheMatchPageState();
}

class _FindTheMatchPageState extends State<FindTheMatchPage> {
  late GoogleMapController mapController;
  Map<String, dynamic>? selectedNote;

  final Color pink = const Color(0xFFF43045);
  final LatLng _center = const LatLng(39.0, -77.0); // Example starting point - adjust as needed

  // Sample data for notes with positions & messages
  final List<Map<String, dynamic>> notes = [
    {
      'id': '1',
      'position': LatLng(39.1, -77.0),
      'image': 'assets/user1.png', // Provide user image asset path
      'username': 'Anna',
      'location': 'Bloom Garden, Albert Street',
      'message': "The bench behind the oak tree that's the location I always end up at...",
      'timestamp': '25 Aug, 4:30 AM',
    },
    {
      'id': '2',
      'position': LatLng(39.05, -77.05),
      'image': 'assets/user2.png',
      'username': 'Mark',
      'location': 'Downtown Park',
      'message': "This is my favorite hangout spot!",
      'timestamp': '27 Aug, 2:15 PM',
    },
    // Add more records as needed
  ];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> _buildMarkers() {
    return notes.map((note) {
      return Marker(
        markerId: MarkerId(note['id']),
        position: note['position'],
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        onTap: () {
          setState(() {
            selectedNote = note;
          });
        },
      );
    }).toSet();
  }

  // Implement search to update map camera position (you can connect Google Places API here)
  void _onSearchSubmitted(String query) async {
    // Normally you would use a Geocoding API to get LatLng from query
    // Here just print or update camera position manually if known
    print('User searched: $query');
    // Example: move camera to fixed position for demo
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(const LatLng(39.1, -77.0), 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Radial background decoration - top right and bottom left lightly blurred with pink
          Positioned(
            right: -100,
            top: -90,
            child: Container(
              width: 220,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [pink.withOpacity(0.13), Colors.transparent],
                  radius: 1,
                ),
              ),
            ),
          ),
          Positioned(
            left: -110,
            bottom: 55,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [pink.withOpacity(0.12), Colors.transparent],
                  radius: 1,
                ),
              ),
            ),
          ),

          // Content Column
          Column(
            children: [
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, size: 26, color: pink),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: pink, width: 1.5),
                        ),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search location",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onSubmitted: _onSearchSubmitted,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: const AssetImage('assets/my_profile.jpg'), // User's pic
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Map with markers under search bar
              Expanded(
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11,
                  ),
                  myLocationEnabled: true,
                  markers: _buildMarkers(),
                ),
              ),

              // Chat bubble overlay when a note is selected
              if (selectedNote != null && selectedNote!['message'] != null)
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: pink,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: pink.withOpacity(0.6),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedNote!['location'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage(selectedNote!['image']),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              selectedNote!['message'] ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            selectedNote!['timestamp'] ?? '',
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          const SizedBox(width: 15),
                          Text('Reply', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                          const SizedBox(width: 12),
                          Text('React', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 62,
        decoration: BoxDecoration(
          color: pink,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(36), topRight: Radius.circular(36)),
          boxShadow: [
            BoxShadow(
              color: pink.withOpacity(0.11),
              blurRadius: 18,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.home, color: Colors.white, size: 28),
            Icon(Icons.explore, color: Colors.white, size: 28),
            Icon(Icons.search, color: Colors.white, size: 28),
            Icon(Icons.chat_bubble_outline, color: Colors.white, size: 28),
            Icon(Icons.person, color: Colors.white, size: 28),
          ],
        ),
      ),
    );
  }
}
