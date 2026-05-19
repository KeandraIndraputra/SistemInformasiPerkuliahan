import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'user_session.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashboardContent(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Selamat Pagi";
    if (hour < 15) return "Selamat Siang";
    if (hour < 18) return "Selamat Sore";
    return "Selamat Malam";
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    // 🔥 AMBIL NAMA DARI SQLITE
    final fullName = UserSession.user?['name'] ?? "User";

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // 🔵 HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF4A90E2),
                    Color(0xFF357ABD),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔴 HEADER TOP (judul + logout)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Dashboard",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _showLogoutDialog(context),
                        icon: const Icon(Icons.logout, color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // 🔥 GREETING DINAMIS
                  Text(
                    "${getGreeting()}, $fullName",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 🕒 JAM
                  Text(
                    "${now.hour}:${now.minute.toString().padLeft(2, '0')}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 📦 CONTENT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 📚 JADWAL
                  const Text(
                    "Jadwal Hari Ini",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const ClassCard(
                    title: "Pemrograman Mobile",
                    time: "08:00 - 10:00",
                    room: "Lab 1",
                    status: "Hadir",
                  ),
                  const ClassCard(
                    title: "Jaringan Komputer",
                    time: "10:00 - 12:00",
                    room: "Ruang 203",
                    status: "Belum",
                  ),

                  const SizedBox(height: 24),

                  // 📰 BERITA
                  const Text(
                    "Berita Teknik Komputer",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const NewsCard(
                    title: "AI Semakin Dominan",
                    description:
                        "AI digunakan di berbagai bidang seperti industri dan pendidikan.",
                  ),
                  const NewsCard(
                    title: "IoT Berkembang Pesat",
                    description:
                        "Smart device makin banyak digunakan di kehidupan sehari-hari.",
                  ),
                  const NewsCard(
                    title: "Cyber Security Penting",
                    description:
                        "Ancaman hacker meningkat, keamanan jadi prioritas.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔐 LOGOUT DIALOG
void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Logout"),
      content: const Text("Yakin ingin logout?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Batal"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/',
              (route) => false,
            );
          },
          child: const Text("Logout"),
        ),
      ],
    ),
  );
}

// 📦 CARD JADWAL
class ClassCard extends StatelessWidget {
  final String title, time, room, status;

  const ClassCard({
    super.key,
    required this.title,
    required this.time,
    required this.room,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        subtitle: Text("$time • $room"),
        trailing: Text(
          status,
          style: TextStyle(
            color: status == "Hadir" ? Colors.green : Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// 📰 CARD BERITA
class NewsCard extends StatelessWidget {
  final String title, description;

  const NewsCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(description,
                style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}