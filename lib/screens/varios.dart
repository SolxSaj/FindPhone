/*child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: _dispositivoController,
                      onChanged: (text) => setState((){}),
                      onSubmitted: (input){
                        _cargarDispositivo();
                      },
                      decoration: const InputDecoration(
                        hintText: 'Escribe un dispositivo'
                      ),
                    ),
                  )
                  ),
                  IconButton(
                    icon: Icon(_puedoInsertar() ? CupertinoIcons.arrow_right_circle_fill:
                    CupertinoIcons.arrow_right_circle),
                    onPressed: (){
                      _cargarDispositivo();
                    },
                  )
                ],
              ),
            ],
          ),
        ),*/