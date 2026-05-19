import 'package:flutter/material.dart';
import 'database_helper.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final username = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final nim = TextEditingController();
  final kelas = TextEditingController();

  void register() async {
    if (_formKey.currentState!.validate()) {
      await DatabaseHelper.instance.insertUser({
        'username': username.text,
        'password': password.text,
        'name': name.text,
        'nim': nim.text,
        'kelas': kelas.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Akun berhasil dibuat")),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _field("Username", username),
              _field("Password", password, isPassword: true),
              _field("Nama Lengkap", name),
              _field("NIM", nim),
              _field("Kelas", kelas),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: register,
                child: const Text("Create Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController c,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        obscureText: isPassword,
        validator: (v) => v!.isEmpty ? "$label wajib diisi" : null,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}