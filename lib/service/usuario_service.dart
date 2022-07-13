import 'package:findphone_vdos/model/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsuarioService extends ChangeNotifier{
  final String _baseURL = 'findphoneflutter-default-rtdb.firebaseio.com';
  bool isLoading = true;
  bool isSaving = false;
  late Usuario userActual;


  Future<Usuario> ValidarUsuario(String email, String password) async{
      this.isLoading = true;
      notifyListeners();

      final url = Uri.https(_baseURL, 'usuario.json');
      final response = await http.get(url);
      final Map<String, dynamic> mapDisp = json.decode(response.body);


      mapDisp.forEach((key, value) {
        if(value['email'] == email && value['password'] == password){
          final tempUser = Usuario.fromMap(value);
          tempUser.idUsuario = key;
          this.userActual = tempUser;
        }
      });

      this.isLoading = false;
      notifyListeners();
      
      return this.userActual;

  }

}