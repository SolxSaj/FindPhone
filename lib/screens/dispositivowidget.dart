import 'package:findphone_vdos/model/dispositivo.dart';
import 'package:flutter/material.dart';

class DispositivoWidget extends StatelessWidget{
  final Dispositivo disp;

  const DispositivoWidget({Key? key, required this.disp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 1, top: 5, right: 1, bottom: 2),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[350]!,
                    blurRadius: 2.0,
                    offset: Offset(0, 1.0)
                  )
                ],
                borderRadius: BorderRadius.circular(5),
                color: Colors.white
              ),
              child: MaterialButton(
                disabledTextColor: Colors.black87,
                padding: EdgeInsets.only(left: 10),
                onPressed: null,
                child: Wrap(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: [
                          Text(disp.modelo),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 4),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    disp.marca,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ),
          ],
        ),
    );
  }

}