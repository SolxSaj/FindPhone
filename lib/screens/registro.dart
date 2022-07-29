import 'package:findphone_vdos/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:findphone_vdos/service/dispositivo_service.dart';
import 'package:provider/provider.dart';
  
class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}
  
class _RegistroState extends State<Registro> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  TextEditingController nombre = new TextEditingController();
  TextEditingController apellido = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  
  bool _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();
    return true;
  }
  
  @override
  Widget build(BuildContext context) {
    final dispositivoServicio = Provider.of<DispositivoServicio>(context);

    return Scaffold(
      //body
      body: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 25.0,
              spreadRadius: 5,
              offset: Offset(
                15.0,15.0
              ),
            ),
          ],
          color: Color.fromARGB(255, 43, 167, 200),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 50),
        padding: EdgeInsets.only(left: 20, right: 20),
        //form
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    "Registro",
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  //styling
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                  ),
                  TextFormField(
                    controller: nombre,
                    decoration: InputDecoration(labelText: 'Nombre(s)'),
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value) {
                      //Validator
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingresa tu nombre';
                      }
                      return null;
                    },
                  ),
                  //box styling
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                  ),
                  TextFormField(
                    controller: apellido,
                    decoration: InputDecoration(labelText: 'Apellidos'),
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value) {
                      //Validator
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingresa tus apellidos';
                      }
                      return null;
                    },
                  ),
                  //box styling
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                  ),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(labelText: 'E-Mail'),
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value) {
                      //Validator
                    },
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter a valid email!';
                      }
                      return null;
                    },
                  ),
                  //box styling
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                  ),
                  //text input 
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(labelText: 'Password'),
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value) {},
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid password!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                  ),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0,
                    ),
                    child: Text(
                      "Registrarse",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                    onPressed: () {
                      Usuario userTemp = Usuario(apellido: apellido.text, email: email.text, nombre: nombre.text, password: password.text);
                      if(_submit()){
                        dispositivoServicio.crearUsuario(userTemp);
                        Navigator.pop(context);                      
                      }
                    } ,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}