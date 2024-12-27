import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterClientScreen extends StatefulWidget {
  @override
  _RegisterClientScreenState createState() => _RegisterClientScreenState();
}

class _RegisterClientScreenState extends State<RegisterClientScreen> {
  final TextEditingController _codClienteController = TextEditingController();
  final TextEditingController _codTipoClienteController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _paisController = TextEditingController();
  final TextEditingController _provinciaController = TextEditingController();
  final TextEditingController _ciudadController = TextEditingController();
  final TextEditingController _codVendedorController = TextEditingController();
  final TextEditingController _codFormaPagoController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _limiteCreditoController = TextEditingController();
  final TextEditingController _saldoPendienteController = TextEditingController();
  final TextEditingController _cedulaRucController = TextEditingController();
  final TextEditingController _codListaPrecioController = TextEditingController();
  final TextEditingController _calificacionController = TextEditingController();
  final TextEditingController _nombreComercialController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _registrarCliente() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://10.0.2.2:8000/api/clientes/register'); // URL para el emulador de Android

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'codcliente': _codClienteController.text,
        'codtipocliente': _codTipoClienteController.text,
        'nombre': _nombreController.text,
        'email': _emailController.text,
        'pais': _paisController.text,
        'provincia': _provinciaController.text,
        'ciudad': _ciudadController.text,
        'codvendedor': _codVendedorController.text,
        'codformapago': _codFormaPagoController.text,
        'estado': _estadoController.text,
        'limitecredito': _limiteCreditoController.text,
        'saldopendiente': _saldoPendienteController.text,
        'cedularuc': _cedulaRucController.text,
        'codlistaprecio': _codListaPrecioController.text,
        'calificacion': _calificacionController.text,
        'nombrecomercial': _nombreComercialController.text,
        'login': _loginController.text,
        'password': _passwordController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cliente registrado con éxito!')),
      );
    } else {
      final responseData = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar cliente: ${responseData['errors']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Cliente')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  TextField(
                    controller: _codClienteController,
                    decoration: InputDecoration(labelText: 'Código Cliente'),
                  ),
                  TextField(
                    controller: _codTipoClienteController,
                    decoration: InputDecoration(labelText: 'Código Tipo Cliente'),
                  ),
                  TextField(
                    controller: _nombreController,
                    decoration: InputDecoration(labelText: 'Nombre'),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Correo Electrónico'),
                  ),
                  TextField(
                    controller: _paisController,
                    decoration: InputDecoration(labelText: 'País'),
                  ),
                  TextField(
                    controller: _provinciaController,
                    decoration: InputDecoration(labelText: 'Provincia'),
                  ),
                  TextField(
                    controller: _ciudadController,
                    decoration: InputDecoration(labelText: 'Ciudad'),
                  ),
                  TextField(
                    controller: _codVendedorController,
                    decoration: InputDecoration(labelText: 'Código Vendedor'),
                  ),
                  TextField(
                    controller: _codFormaPagoController,
                    decoration: InputDecoration(labelText: 'Código Forma de Pago'),
                  ),
                  TextField(
                    controller: _estadoController,
                    decoration: InputDecoration(labelText: 'Estado'),
                  ),
                  TextField(
                    controller: _limiteCreditoController,
                    decoration: InputDecoration(labelText: 'Límite de Crédito'),
                  ),
                  TextField(
                    controller: _saldoPendienteController,
                    decoration: InputDecoration(labelText: 'Saldo Pendiente'),
                  ),
                  TextField(
                    controller: _cedulaRucController,
                    decoration: InputDecoration(labelText: 'Cédula/RUC'),
                  ),
                  TextField(
                    controller: _codListaPrecioController,
                    decoration: InputDecoration(labelText: 'Código Lista Precio'),
                  ),
                  TextField(
                    controller: _calificacionController,
                    decoration: InputDecoration(labelText: 'Calificación'),
                  ),
                  TextField(
                    controller: _nombreComercialController,
                    decoration: InputDecoration(labelText: 'Nombre Comercial'),
                  ),
                  TextField(
                    controller: _loginController,
                    decoration: InputDecoration(labelText: 'Login'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Contraseña'),
                  ),
                  ElevatedButton(
                    onPressed: _registrarCliente,
                    child: Text('Registrar Cliente'),
                  ),
                ],
              ),
      ),
    );
  }
}
