import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'user_session.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = UserSession.user?['name'] ?? "";
  }

  void save() async {
    final user = UserSession.user;
    final id = user?['id'];

    if (id == null) return;

    // 🔐 cek password lama
    final isValid = await DatabaseHelper.instance.verifyPassword(
      id,
      oldPassController.text,
    );

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password lama salah")),
      );
      return;
    }

    // 🔄 update
    await DatabaseHelper.instance.updateUser(id, {
      'name': nameController.text,
      'password': newPassController.text.isNotEmpty
          ? newPassController.text
          : user?['password'],
    });

    // update session
    UserSession.user = {
      ...user!,
      'name': nameController.text,
      'password': newPassController.text.isNotEmpty
          ? newPassController.text
          : user['password'],
    };

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profil berhasil diupdate")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nama Lengkap"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: oldPassController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password Lama"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: newPassController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Baru (opsional)",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: save,
              child: const Text("Simpan Perubahan"),
            ),
          ],
        ),
      ),
    );
  }
}