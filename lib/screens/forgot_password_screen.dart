import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String _message = '';

  Future<void> _sendResetLink() async {
    setState(() {
      _isLoading = true;
      _message = ''; // Reset message
    });

    final url = Uri.parse('http://10.0.2.2:8000/api/password/forgot'); // Cambia la URL si es necesario

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': _emailController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        _message = 'Enlace de restablecimiento enviado correctamente a tu correo.';
      });
    } else {
      final responseData = json.decode(response.body);
      setState(() {
        _message = 'Error: ${responseData['error']}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restablecer Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Correo Electrónico',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _sendResetLink,
                    child: Text('Enviar Enlace de Restablecimiento'),
                  ),
                  if (_message.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        _message,
                        style: TextStyle(
                          color: _message.contains('Error') ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
