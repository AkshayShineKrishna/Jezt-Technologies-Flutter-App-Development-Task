import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:jezt_internship_app/services/services.dart';
import 'package:jezt_internship_app/models/login_response.dart';
import 'package:jezt_internship_app/presentation/dashboard.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final TextEditingController _companyIdController = TextEditingController();
  final TextEditingController _passwdController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  void _navigate(String access) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => ScreenDashboard(access: access)),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> _login() async {
    final companyId = _companyIdController.text.trim();
    final password = _passwdController.text.trim();

    if (companyId.isEmpty || password.isEmpty) {
      _showErrorMessage('Fill all fields to continue');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await Services.login(
        data: {"company_id": companyId, "password": password},
      );

      if (response.statusCode! == 200) {
        final loginResponse = LoginResponse.fromJson(response.data);
        log('Access Token: ${loginResponse.access}');
        _navigate(loginResponse.access!);
      } else if (response.statusCode == 401) {
        final loginResponse = LoginResponse.fromJson(response.data);
        _showErrorMessage(loginResponse.detail ?? 'Invalid credentials');
      } else {
        _showErrorMessage('Something went wrong');
      }
    } catch (e) {
      log('Login error: $e');
      _showErrorMessage('Login failed: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('asset/jezt.png', height: 120),
              const SizedBox(height: 20),
              TextFormField(
                controller: _companyIdController,
                decoration: InputDecoration(
                  hintText: 'Company ID',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 20.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwdController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 20.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        )
                      : const Text('Login', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
