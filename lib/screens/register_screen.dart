import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../styles/registerstyle.dart';

class RegisterClientScreen extends StatefulWidget {
  @override
  _RegisterClientScreenState createState() => _RegisterClientScreenState();
}

class _RegisterClientScreenState extends State<RegisterClientScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _paisController = TextEditingController();
  final TextEditingController _provinciaController = TextEditingController();
  final TextEditingController _ciudadController = TextEditingController();
  final TextEditingController _limiteCreditoController = TextEditingController();
  final TextEditingController _saldoPendienteController = TextEditingController();
  final TextEditingController _cedulaRucController = TextEditingController();
  final TextEditingController _codListaPrecioController = TextEditingController();
  final TextEditingController _calificacionController = TextEditingController();
  final TextEditingController _nombreComercialController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _selectedCodTipoCliente;
  String? _selectedCodFormaPago;
  String? _selectedCodVendedor;
  String? _selectedEstado;

  bool _isLoading = false;

  List<Map<String, dynamic>> _tiposClientes = [];
  List<Map<String, dynamic>> _formasPago = [];
  List<Map<String, dynamic>> _vendedores = [];

  @override
  void initState() {
    super.initState();
    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final tiposClientesResponse = await http.get(Uri.parse('http://10.0.2.2:8000/api/tiposclientes'));
      final formasPagoResponse = await http.get(Uri.parse('http://10.0.2.2:8000/api/formas-pago'));
      final vendedoresResponse = await http.get(Uri.parse('http://10.0.2.2:8000/api/vendedor'));

      if (tiposClientesResponse.statusCode == 200) {
        setState(() {
          _tiposClientes = List<Map<String, dynamic>>.from(json.decode(tiposClientesResponse.body));
        });
      }

      if (formasPagoResponse.statusCode == 200) {
        setState(() {
          _formasPago = List<Map<String, dynamic>>.from(json.decode(formasPagoResponse.body));
        });
      }

      if (vendedoresResponse.statusCode == 200) {
        final data = json.decode(vendedoresResponse.body)['datos']['data'];
        setState(() {
          _vendedores = List<Map<String, dynamic>>.from(data);
        });
      }
    } catch (e) {
      print('Error al cargar los datos: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _generateCodCliente() {
    final cedulaRuc = _cedulaRucController.text;
    return 'CLI-$cedulaRuc';
  }

  Future<void> _registrarCliente() async {
    setState(() {
      _isLoading = true;
    });

    final codCliente = _generateCodCliente();

    final url = Uri.parse('http://10.0.2.2:8000/api/clientes/register');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'codcliente': codCliente,
        'codtipocliente': _selectedCodTipoCliente,
        'nombre': _nombreController.text,
        'email': _emailController.text,
        'pais': _paisController.text,
        'provincia': _provinciaController.text,
        'ciudad': _ciudadController.text,
        'codvendedor': _selectedCodVendedor,
        'codformapago': _selectedCodFormaPago,
        'estado': _selectedEstado,
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cliente registrado con éxito!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar cliente')),
      );
    }
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Registrar Cliente'),
      backgroundColor: Colors.red,
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
                      _buildRowField('Nombre:', _buildTextField(_nombreController, 'Nombre')),
                      _buildRowField('Correo Electrónico:', _buildTextField(_emailController, 'Correo Electrónico')),
                      _buildRowField('País:', _buildTextField(_paisController, 'País')),
                      _buildRowField('Provincia:', _buildTextField(_provinciaController, 'Provincia')),
                      _buildRowField('Ciudad:', _buildTextField(_ciudadController, 'Ciudad')),
                      _buildRowField('Límite de Crédito:', _buildTextField(_limiteCreditoController, 'Límite de Crédito')),
                      _buildRowField('Saldo Pendiente:', _buildTextField(_saldoPendienteController, 'Saldo Pendiente')),
                      _buildRowField('Cédula/RUC:', _buildTextField(_cedulaRucController, 'Cédula/RUC')),
                      _buildRowField('Código Lista Precio:', _buildTextField(_codListaPrecioController, 'Código Lista Precio')),
                      _buildRowField('Calificación:', _buildTextField(_calificacionController, 'Calificación')),
                      _buildRowField('Nombre Comercial:', _buildTextField(_nombreComercialController, 'Nombre Comercial')),
                      _buildRowField('Login:', _buildTextField(_loginController, 'Login')),
                      _buildRowField('Contraseña:', _buildTextField(_passwordController, 'Contraseña')),
                      // Dropdowns con labelText agregado
                      _buildRowField(
                        'Tipo de Cliente:',
                        DropdownButtonFormField<String>(
                          value: _selectedCodTipoCliente,
                          decoration: RegisterStyle.textFieldDecoration.copyWith(labelText: 'Tipo de Cliente'),
                          hint: Text('Seleccione Tipo de Cliente', style: TextStyle(fontSize: 12.0)),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCodTipoCliente = newValue;
                            });
                          },
                          items: _tiposClientes.map<DropdownMenuItem<String>>((tipo) {
                            return DropdownMenuItem<String>(
                              value: tipo['codtipocliente'],
                              child: Text(tipo['descripcion']),
                            );
                          }).toList(),
                        ),
                      ),
                      _buildRowField(
                        'Forma de Pago:',
                        DropdownButtonFormField<String>(
                          value: _selectedCodFormaPago,
                          decoration: RegisterStyle.textFieldDecoration.copyWith(labelText: 'Forma de Pago'),
                          hint: Text('Seleccione Forma de Pago', style: TextStyle(fontSize: 12.0)),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCodFormaPago = newValue;
                            });
                          },
                          items: _formasPago.map<DropdownMenuItem<String>>((forma) {
                            return DropdownMenuItem<String>(
                              value: forma['codformapago'],
                              child: Text(forma['nombre']),
                            );
                          }).toList(),
                        ),
                      ),
                      _buildRowField(
                        'Vendedor:',
                        DropdownButtonFormField<String>(
                          value: _selectedCodVendedor,
                          decoration: RegisterStyle.textFieldDecoration.copyWith(labelText: 'Vendedor'),
                          hint: Text('Seleccione Vendedor', style: TextStyle(fontSize: 12.0)),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCodVendedor = newValue;
                            });
                          },
                          items: _vendedores.map<DropdownMenuItem<String>>((vendedor) {
                            return DropdownMenuItem<String>(
                              value: vendedor['codvendedor'].toString(),
                              child: Text(vendedor['nombre'].toString(), style: TextStyle(fontSize: 12.0)),
                            );
                          }).toList(),
                        ),
                      ),
                      _buildRowField(
                        'Estado:',
                        DropdownButtonFormField<String>(
                          value: _selectedEstado,
                          decoration: RegisterStyle.textFieldDecoration.copyWith(labelText: 'Estado'),
                          hint: Text('Seleccione Estado', style: TextStyle(fontSize: 12.0)),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedEstado = newValue;
                            });
                          },
                          items: [
                            DropdownMenuItem<String>(value: 'A', child: Text('Activo', style: TextStyle(fontSize: 12.0))),
                            DropdownMenuItem<String>(value: 'I', child: Text('Inactivo', style: TextStyle(fontSize: 12.0))),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _registrarCliente,
                        child: Text('Registrar Cliente'),
                        style: RegisterStyle.registerButtonStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    ),
  );
}

Widget _buildRowField(String label, Widget field) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 80.0,
          child: Text(
            label,
            style: TextStyle(fontSize: 12.0),
          ),
        ),
        Expanded(child: field),
      ],
    ),
  );
}

Widget _buildTextField(TextEditingController controller, String hintText) {
  return TextField(
    controller: controller,
    decoration: RegisterStyle.textFieldDecoration.copyWith(
      labelText: hintText,
      labelStyle: TextStyle(fontSize: 12.0),
    ),
  );
}

Widget _buildDropdown(
  String? value,
  String hint,
  List<Map<String, dynamic>> items,
  ValueChanged<String?> onChanged,
) {
  return DropdownButtonFormField<String>(
    value: value,
    decoration: RegisterStyle.textFieldDecoration,
    hint: Text(hint, style: TextStyle(fontSize: 12.0)),
    onChanged: onChanged,
    items: items.map<DropdownMenuItem<String>>((item) {
      return DropdownMenuItem<String>(
        value: item.values.first.toString(),
        child: Text(item.values.last.toString(), style: TextStyle(fontSize: 12.0)),
      );
    }).toList(),
  );
}

}
