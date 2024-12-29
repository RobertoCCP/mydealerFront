import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../styles/registerstyle.dart';

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

  // Navegar a la pantalla de login
  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restablecer Contraseña'),
        backgroundColor: const Color.fromARGB(255, 250, 77, 77),
        centerTitle: true,
        titleTextStyle: RegisterStyle.appBarTextStyle, // Estilo del AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  Container(
                    width: RegisterStyle.formWidth,
                    padding: RegisterStyle.formPadding,
                    decoration: RegisterStyle.formDecoration,
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _emailController,
                          decoration: RegisterStyle.textFieldDecoration.copyWith(
                            labelText: 'Correo Electrónico',
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20),
                        // Fila con los botones
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // Botón Enviar Enlace
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _sendResetLink,
                                style: RegisterStyle.registerButtonStyle.copyWith(
                                  backgroundColor: MaterialStateProperty.all(Colors.green), // Color verde
                                ),
                                child: Text('Enviar Enlace'),
                              ),
                            ),
                            SizedBox(width: 10),
                            // Botón Cancelar
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _navigateToLogin,
                                style: RegisterStyle.registerButtonStyle.copyWith(
                                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 0, 0)),
                                ),
                                child: Text('Cancelar'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
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
                ],
              ),
      ),
    );
  }
}
