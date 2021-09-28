import 'package:flutter/material.dart';
import 'package:imc_mobile/forms/imc_form.dart';

class ImcScreen extends StatefulWidget {
  const ImcScreen({Key? key}) : super(key: key);

  @override
  _ImcScreenState createState() => _ImcScreenState();
}

class _ImcScreenState extends State<ImcScreen> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  String _infoText = "Informe seus dados";

  void resetFields() {
    weightController.clear();
    heightController.clear();
    setState(() {
      _infoText = "Informe seus dados";
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
            IconButton(onPressed: resetFields, icon: const Icon(Icons.refresh))
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ImcForm(
              weightController: weightController,
              heightController: heightController,
              infoText: _infoText,
            )));
  }
}
