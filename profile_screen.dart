import 'package:flutter/material.dart';
import 'user_session.dart';
import 'footer_widget.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserSession.user;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔵 HEADER
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                    ),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(30)),
                  ),
                ),
                Positioned(
                  top: 140,
                  left: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 50,
                      child: Text(
                        (user?['name'] ?? "U")[0],
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 70),

            // 👤 USER INFO
            Text(
              user?['name'] ?? "-",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("NIM: ${user?['nim'] ?? "-"}"),
            Text(user?['kelas'] ?? "-"),

            // ✏️ EDIT PROFILE
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditProfileScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profile"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 📚 JADWAL KELAS TERDEKAT (DITAMBAHKAN)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Jadwal Kelas Terdekat",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),

                  ScheduleCard(
                    title: "Pemrograman Mobile",
                    time: "08:00 - 10:00",
                    room: "Lab 1",
                  ),
                  ScheduleCard(
                    title: "Jaringan Komputer",
                    time: "10:00 - 12:00",
                    room: "Ruang 203",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 🔴 LOGOUT
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (_) => false);
              },
              child: const Text("Logout"),
            ),

            const SizedBox(height: 20),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}

// 📦 CARD JADWAL
class ScheduleCard extends StatelessWidget {
  final String title, time, room;

  const ScheduleCard({
    super.key,
    required this.title,
    required this.time,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.schedule, color: Colors.blue),
        title: Text(title),
        subtitle: Text("$time • $room"),
      ),
    );
  }
}