import 'package:findphone_vdos/model/dispositivo.dart';
import 'package:findphone_vdos/service/dispositivo_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget{

  Login({Key? key}) : super(key: key);

  @override
    LoginState createState() => LoginState();

}

class LoginState extends State<Login>{

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context){
      
    final dispositivoServicio = Provider.of<DispositivoServicio>(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/Logo.png", height: 160,),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "User@correo.com",
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 70),
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 57, 57, 57),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: FlatButton(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                      ),
                    onPressed: (){
                      dispositivoServicio.obtenerUbicacion();
                      dispositivoServicio.ValidarUsuario(email.text, password.text);
                      if(dispositivoServicio.userActual.idUsuario != "Nulo"){
                        dispositivoServicio.CompDispo(dispositivoServicio.userActual.idUsuario!);
                        dispositivoServicio.ListaDispositivos();
                        Navigator.pushNamed(context, "Dispositivos");
                      }else{
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Center(
                    child: InkWell(
                      child: Text("¿Aún no tienes cuenta? Crea una cuenta"),
                      onTap: () => Navigator.pushNamed(context, "Register"),
                    ) 
                  ),
                ),
                
                
              ],
            ),
          )
        ),
      )
    );
  }

}