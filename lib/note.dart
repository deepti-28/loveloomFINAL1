import 'package:flutter/material.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color pink = const Color(0xFFF43045);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Add your radial gradient backgrounds here if needed...

          Column(
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: pink, size: 26),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Write a note to publish...",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.82),
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 0, 13, 75),
                child: SizedBox(
                  height: 48,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: pink, width: 1.6),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Message...',
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ),
                              Icon(Icons.edit, color: pink, size: 24),
                              SizedBox(width: 7),
                              Icon(Icons.mic, color: pink, size: 24),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
          boxShadow: [BoxShadow(color: pink.withOpacity(0.09), blurRadius: 18, offset: Offset(0, -2))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.home, color: Colors.white, size: 27),
            Icon(Icons.explore, color: Colors.white, size: 27),
            Icon(Icons.add_circle_outline, color: Colors.white, size: 27),
            Icon(Icons.chat_bubble_outline, color: Colors.white, size: 27),
            Icon(Icons.person, color: Colors.white, size: 27),
          ],
        ),
      ),
    );
  }
}
