import 'package:flutter/material.dart';

import '../lavagem/calculadora_lavagem.dart';
import '../lavagem/strategy/lavagem_completa.dart';
import '../lavagem/strategy/lavagem_premium.dart';
import '../lavagem/strategy/lavagem_simples.dart';
import '../lavagem/strategy/lavagem_strategy.dart';

class LavagemScreen extends StatefulWidget {
  const LavagemScreen({super.key});

  @override
  State<LavagemScreen> createState() => _LavagemScreenState();
}

class _LavagemScreenState extends State<LavagemScreen> {
  final modalidades = <String, LavagemStrategy>{
    'Simples': LavagemSimples(),
    'Completa': LavagemCompleta(),
    'Premium': LavagemPremium(),
  };

  final quantidadeController = TextEditingController();
  String modalidade = 'Simples';
  String resultado = '';

  void calcular() {
    final qtd = int.tryParse(quantidadeController.text);

    if (qtd == null) {
      setState(() {
        resultado = 'Informe uma quantidade válida';
      });
      return;
    }

    try {
      final calculadora = CalculadoraLavagem(modalidades[modalidade]!);
      final valor = calculadora.calcular(qtd);

      setState(() {
        resultado =
            'Total: R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
      });
    } on ArgumentError {
      setState(() {
        resultado = 'A quantidade não pode ser negativa';
      });
    }
  }

  @override
  void dispose() {
    quantidadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulador de Lavagem'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              initialValue: modalidade,
              decoration: const InputDecoration(labelText: 'Modalidade'),
              items: modalidades.keys
                  .map(
                    (nome) => DropdownMenuItem(value: nome, child: Text(nome)),
                  )
                  .toList(),
              onChanged: (valor) {
                setState(() {
                  modalidade = valor!;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantidadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantidade de veículos',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: calcular, child: const Text('Calcular')),
            const SizedBox(height: 24),
            Text(
              resultado,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
