import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: contaPage(),
  ));
}

class contaPage extends StatefulWidget {
  @override
  _contaState createState() => _contaState();
}

class _contaState extends State<contaPage> {
  //criar controller para as variaveis
  TextEditingController quantidadePessoasController = TextEditingController();
  TextEditingController valorContaController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _valorPessoa = "Informe seus dados";
  //criar função void para calcular ao apertar o botão
  // metodo underline iniciado informa que a função só será acessada dentro do escopo desta classe.
  void _calcular() {
    double quantidadepessoas = double.parse(quantidadePessoasController.text);
    double valorconta = double.parse(valorContaController.text);

    double valortotal = valorconta / quantidadepessoas;

    //em dart concatenar string e variaveis utiliza o simbolo $
    //igual no reactjs setState para atualizar o estado
    setState(() {
      _valorPessoa = "Valor por pessoa: ${valortotal.toStringAsPrecision(4)}";
    });
  }

  void _limparCamposForm() {
    setState(() {
      _valorPessoa = "Informe seus dados";
      quantidadePessoasController.text = "";
      valorContaController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RACHA CONTA"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _limparCamposForm();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
          //para melhorar a usabilidade da aplicação nas diversas telas
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                  key:
                      _formkey, //chave formkey para identificar e poder criar os validators
                  child: (Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.stretch, // vai fazer com q
                    // os elemento ocupem
                    // td o espaço da coluna defina
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        size: 120,
                        color: Colors.lightGreen,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: quantidadePessoasController,
                        decoration: InputDecoration(
                            labelText: "Quantidade de pessoas",
                            labelStyle: TextStyle(color: Colors.lightGreen)),
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Colors.lightGreen, fontSize: 18),
                        validator: (value) {
                          //validador do campo, verifica qd o botao calcular for pressionado
                          if (value.isEmpty) {
                            return "Insira a quantidade de pessoas";
                          }
                        },
                      ),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          controller: valorContaController,
                          decoration: InputDecoration(
                            labelText: "Valor da conta",
                            labelStyle: TextStyle(color: Colors.lightGreen),
                          ),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.lightGreen, fontSize: 18),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira o valor da conta";
                            }
                          }),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20, top: 20),
                        child: Container(
                            child: RaisedButton(
                          onPressed: () {
                            if(_formkey.currentState.validate()){
                              _calcular();
                            }
                            valorContaController.clear(); //outro metodo de limpar os campos
                            quantidadePessoasController.clear();
                          },
                          color: Colors.lightGreen,
                          child: Text(
                            "CALCULAR",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                      ),
                      Text(
                        _valorPessoa,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Colors.lightGreen, fontSize: 18),
                      )
                    ],
                  ))))),
    );
  }
}
