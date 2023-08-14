// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double taxa = 0;
  late double totalConta, totalPagar, comissao;
  late int qtdPessoas;

  //Texts Controllers
  TextEditingController textTotal = TextEditingController();
  TextEditingController textQtd = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  void CaularConta() {
    setState(() {
      totalConta = double.parse(textTotal.text);
      qtdPessoas = int.parse(textQtd.text);

      comissao = (taxa * totalConta) / 100;

      totalPagar = (totalConta + comissao) / qtdPessoas;
    });

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Total a Pagar Por Pessoa"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/smile.png",
                    width: 60,
                  ),
                  Text("O TOTAL DA CONTA R\$$totalConta"),
                  Text("A TAXA DE SERVIÇO R\$ $comissao"),
                  Text("O TOTAL POR PESSOA R\$ $totalPagar")
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  // ignore: sort_child_properties_last
                  child: Text("OK"),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFFF6600),
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RACHA CONTA"),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF6600),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: SvgPicture.asset("assets/money.svg"),
                ),
                TextFormField(
                  controller: textTotal,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: "Total da Conta"),
                  style: TextStyle(fontSize: 18),
                  validator: (valor) {
                    if (valor!.isEmpty)
                      return "Campo Obrigatorio";
                    else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Taxa de Serviço %:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      value: taxa,
                      min: 0,
                      max: 10,
                      label: "$taxa%",
                      divisions: 10,
                      activeColor: const Color(0xFFFF6600),
                      inactiveColor: Colors.grey,
                      onChanged: (double valor) {
                        setState(() {
                          taxa = valor;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: textQtd,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration:
                      InputDecoration(labelText: "Quantidade de Pessoas"),
                  style: TextStyle(fontSize: 18),
                  validator: (valor) {
                    if (valor!.isEmpty)
                      return "Campo Obrigatorio";
                    else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFFFF6600),
                    ),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        CaularConta();
                      }
                    },
                    child: const Text(
                      "Calcular",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
