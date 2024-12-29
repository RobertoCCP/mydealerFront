import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../styles/loginstyle.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _apiService = ApiService();
  bool _isLoading = false;

  void _login() async {
    setState(() => _isLoading = true);
    try {
      final response = await _apiService.login(
        _emailController.text,
        _passwordController.text,
      );
      if (response['success']) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showError(response['message']);
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: LoginStyle.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo and Welcome Text
              SizedBox(height: 20),
              Container(
                height: LoginStyle.logoHeight,
                child: Center(
                  child: Text(
                    'miLogo',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text('BIENVENIDO A MYDEALER', style: LoginStyle.welcomeTextStyle),
              SizedBox(height: 30),

              // Form container
              Container(
                width: LoginStyle.formWidth,
                padding: LoginStyle.formPadding,
                decoration: LoginStyle.formDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: LoginStyle.emailInputDecoration,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      decoration: LoginStyle.passwordInputDecoration,
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            style: LoginStyle.loginButtonStyle,
                            onPressed: _login,
                            child: Text('Ingresar'),
                          ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/forgot-password'),
                        child: Text('Olvidé mi Contraseña', style: LoginStyle.linkTextStyle),
                      ),
                    ),
                  ],
                ),
              ),

              // Register Button
              SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: Text('Registrarse', style: LoginStyle.linkTextStyle),
              ),

              // Footer (updated to span full screen width)
              Spacer(),
              Container(
                width: double.infinity,
                color: LoginStyle.footerBackgroundColor,
                padding: LoginStyle.footerPadding,
                child: Column(
                  children: [
                    Text(
                      'MEGAPRODUCTOS S.A.\nKm 7.5 via Duale, frente a Codemet\nTELÉFONO: (04) 2262628\ninfo@megaproductos.com.ec',
                      style: LoginStyle.footerTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
