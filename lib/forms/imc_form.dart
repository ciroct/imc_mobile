import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImcForm extends StatefulWidget {
  final TextEditingController weightController;
  final TextEditingController heightController;
  String infoText;

  ImcForm(
      {Key? key,
      required this.weightController,
      required this.heightController,
      required this.infoText})
      : super(key: key);

  @override
  _ImcFormState createState() => _ImcFormState();
}

class _ImcFormState extends State<ImcForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _calculate() {
    var weight = double.parse(widget.weightController.text);
    var height = double.parse(widget.heightController.text) / 100;
    var imc = weight / (height * height);
    setState(() {
      if (imc < 18.9) {
        widget.infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc < 24.9) {
        widget.infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc < 29.9) {
        widget.infoText =
            "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc < 34.9) {
        widget.infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc < 39.9) {
        widget.infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else {
        widget.infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
            controller: widget.weightController,
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
            controller: widget.heightController,
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
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 25.0)),
            ),
          ),
          Text(
            widget.infoText,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.green, fontSize: 25.0),
          )
        ],
      ),
    );
  }
}
