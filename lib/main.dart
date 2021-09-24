import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Home(), debugShowCheckedModeBanner: false));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = "Informe seus dados";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    weightController.clear();
    heightController.clear();
    setState(() {
      _infoText = "Informe seus dados";
    });
  }

  void _calculate() {
    var weight = double.parse(weightController.text);
    var height = double.parse(heightController.text) / 100;
    var imc = weight / (height * height);
    setState(() {
      if (imc < 18.9) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(onPressed: _resetFields, icon: const Icon(Icons.refresh))
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Colors.green,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Peso (Kg)',
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: weightController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Insira seu peso";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Altura (cm)',
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: heightController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Insira sua altura";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _calculate();
                        }
                      },
                      child: const Text("Calcular"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 25.0)),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.green, fontSize: 25.0),
                  )
                ],
              ),
            )));
  }
}
